import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'dart:convert';

import 'package:smart_delivery/flexible_polyline.dart';
import 'package:smart_delivery/latlngz.dart' as latlat;

// Sustainable Food Delivery Optimization: Build a solution (website or mobile app) that optimizes food delivery routes for local restaurants using HERE Routing APIs and Mobile SDKs while minimizing environmental impact.

class MyApp11 extends StatefulWidget {
  @override
  State<MyApp11> createState() => _MyApp11State();
}

class _MyApp11State extends State<MyApp11> {
  List<Marker> _marker = [];
  final GlobalKey _markerLayerKey = GlobalKey();
  late MapController _mapController;
  LatLng? camera_center = null;
  double camera_zoom_level = 12.5;
  int count = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('HERE Map Example')),
        body: FutureBuilder<Map<String, dynamic>>(
          future: _getRoute(),
          builder: (context, snapshot) {
            print(_marker.length);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              print(snapshot.data);
              var route =
                  snapshot.data!['routes'][0]['sections'][0]['polyline'];
              var startMarker = snapshot.data!['routes'][0]['sections'][0]
                  ['departure']['place']['location'];
              var endMarker = snapshot.data!['routes'][0]['sections'][0]
                  ['arrival']['place']['location'];
              camera_center = camera_center ??
                  LatLng((startMarker['lat'] + endMarker['lat']) / 2 as double,
                      (startMarker['lng'] + endMarker['lng']) / 2 as double);
              // print(startMarker[0] + "  " + endMarker[0]);
              // sak(route);
              api_testing();
              return Stack(children: [
                Positioned.fill(
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      center: camera_center,
                      zoom: camera_zoom_level,
                      onTap: (tap, latlng) {
                        print(
                            "Tapped at: ${latlng.latitude}, ${latlng.longitude}, ${tap}");
                        setState(() {
                          _marker.add(
                            Marker(
                              width: 40.0,
                              height: 40.0,
                              point: latlng,
                              child:
                                  Icon(Icons.location_on, color: Colors.blue),
                            ),
                          );
                          camera_center = _mapController.camera.center;
                          camera_zoom_level = _mapController.camera.zoom;
                        });
                        // setState(() {
                        // });

                        // Use latlng.latitude and latlng.longitude for your purposes
                      },
                      onSecondaryTap: (tapPosition, point) =>
                          print("${point.latitude},${point.longitude}"),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        // subdomains: ['a', 'b', 'c'],
                      ),
                      PolylineLayer(
                        //12.7889551, 80.2213335
                        // 12.791826579973867, 80.22216117610574
                        //12.79699690468084, 80.22307579398407
                        // 12.8593407,  80.2265026
                        polylines: [
                          Polyline(
                            points: sak(route)
                                .map((e) => LatLng(e.lat, e.lng))
                                .toList(),
                            color: Colors.blue,
                            strokeWidth: 8.0,
                          ),
                        ],
                      ),
                      MarkerLayer(
                        key: _markerLayerKey,
                        markers: [
                          ..._marker,
                          Marker(
                            width: 40.0,
                            height: 40.0,
                            point:
                                LatLng(startMarker['lat'], startMarker['lng']),
                            child: GestureDetector(
                                onTap: () => {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Marker Text'),
                                            content: Text(
                                                'This is the text for the marker.'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Close'),
                                              ),
                                            ],
                                          );
                                        },
                                      )
                                    },
                                child: Icon(Icons.location_on,
                                    color: Colors.green)),
                          ),
                          Marker(
                            width: 40.0,
                            height: 40.0,
                            point: LatLng(endMarker['lat'], endMarker['lng']),
                            child: Icon(Icons.location_on, color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    padding: EdgeInsets.all(5),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(244, 243, 243, 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black87,
                        ),
                        hintText: 'Search you\'re looking for',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text("Calculate Route"),
                      onPressed: () {},
                    ),
                  ),
                ),
              ]);
            }
          },
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> _getRoute() async {
    final apiKey = 'd_ag3Uo2tkXDKu4yXHAHMX5L-YsiYlhswXAYd6M6fUo';
    final url = Uri.parse(
        'https://router.hereapi.com/v8/routes?transportMode=car&origin=25.05230661095756,75.8282113815214&destination=25.149455369588768,75.84268661985736&return=polyline&apiKey=$apiKey');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load route: ${response.statusCode}');
    }
  }

  List<latlat.LatLngZ> sak(String poly) {
    String encodedPolyline = poly;
    List<latlat.LatLngZ> decoded = FlexiblePolyline.decode(encodedPolyline);
    // for (var point in decoded) {
    //   print(
    //       'Latitude: ${point.lat}, Longitude: ${point.lng}, Altitude: ${point.lng}');
    // }
    return decoded;
  }

  void api_testing() async {
    const carTrafficUrl =
        'https://router.hereapi.com/v8/routes?transportMode=car&origin=START&destination=END&return=summary&traffic:enabled=true&sortBy=duration&apiKey=YOUR_API_KEY';
    final apiKey = 'd_ag3Uo2tkXDKu4yXHAHMX5L-YsiYlhswXAYd6M6fUo';
    final alternativeroute =
        // 'https://router.hereapi.com/v8/routes?&transportMode=car&traffic=enabled&origin=25.05230661095756,75.8282113815214&destination=25.149455369588768,75.84268661985736&return=routeLabels,summary&alternatives=3&apikey=${apiKey}';
        "https://router.hereapi.com/v8/routes?"
        "apiKey=$apiKey"
        "&transportMode=car"
        "&origin=25.05230661095756,75.8282113815214"
        "&destination=25.149455369588768,75.84268661985736"
        "&return=summary"
        "&alternatives=3";
    final url = 'https://pos.ls.hereapi.com/positioning/v1/locate?key=$apiKey';
    final response = await http.get(Uri.parse(alternativeroute));
    final data = jsonDecode(response.body);
    print(data);
    print('object');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      // final lat = data['location']['lat'];
      // final lon = data['location']['lng'];
      // print('Latitude: $lat, Longitude: $lon');
    } else {
      print('Failed to get live location: ${response.statusCode}');
    }
  }
}
