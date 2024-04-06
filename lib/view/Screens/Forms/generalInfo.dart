import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:em_friend/modals/general_info.dart';
import 'package:em_friend/utilities/live_location.dart';
import 'package:em_friend/utilities/push_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class GeneralInfoForm extends StatefulWidget {
  const GeneralInfoForm({super.key});

  @override
  State<GeneralInfoForm> createState() => _GeneralInfoFormState();
}

class _GeneralInfoFormState extends State<GeneralInfoForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  DateTime _dob = DateTime.now(); // Initialize _dob with the current date

  String _phone = '';
  String _address = '';
  String _city = '';
  String _pinCode = '';
  String _medicalCondition = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('General Info Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 17, right: 17, top: 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Date of Birth'),
                readOnly: true, // Make it read-only to prevent manual editing
                onTap: () {
                  // Show date picker when text field is tapped
                  showDatePicker(
                    context: context,
                    initialDate: _dob ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  ).then((selectedDate) {
                    if (selectedDate != null) {
                      setState(() {
                        _dob = selectedDate;
                      });
                    }
                  });
                },
                validator: (value) {
                  if (_dob == null) {
                    return 'Please select your date of birth';
                  }
                  return null;
                },
                controller: TextEditingController(
                  text:
                      _dob != null ? DateFormat('yyyy-MM-dd').format(_dob) : '',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) => _phone = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
                onSaved: (value) => _address = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
                onSaved: (value) => _city = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Pin Code'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your pin code';
                  }
                  return null;
                },
                onSaved: (value) => _pinCode = value!,
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Medical Condition (If Any)'),
                onSaved: (value) => _medicalCondition = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final Position _position =
                      await LiveLocation().getCurrentLocation();
                      final token =  await PushNotification().setupPopNotifications();
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // You can do something with the form data here, such as submit it to a database
                    GeneralInfo _info = GeneralInfo(
                      uid: FirebaseAuth.instance.currentUser!.uid,
                      name: _name,
                      DOB: DateFormat('yyyy-MM-dd').format(_dob),
                      address: _address,
                      city: _city,
                      medicalCondition: _medicalCondition,
                      pincode: _pinCode,
                      liveLocation: GeoPoint(
                        _position.latitude,
                        _position.longitude,
                      ),
                      token:token,
                    );
                   
                    final response = await PushGI().GIsignIn(_info);
                    if (response == "pass") {
                      Navigator.pushNamed(context, '/home');
                      print('Form submitted');
                    } else {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      SnackBar(
                        content: Text(response),
                      );
                    }
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
