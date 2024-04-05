import 'package:flutter/material.dart';

import '../utils/AppColor.dart';

class RestaurantBox extends StatelessWidget {
  final List<String> image = [
    "assets/foodCategories/burger.jpeg",
    "assets/foodCategories/noodle.jpeg",
    "assets/foodCategories/pizza.jpeg",
    "assets/foodCategories/thaal.jpeg",
    "assets/foodCategories/salad.jpeg",
    "assets/foodCategories/burger.jpeg",
    "assets/foodCategories/noodle.jpeg",
    "assets/foodCategories/pizza.jpeg",
    "assets/foodCategories/thaal.jpeg",
    "assets/foodCategories/salad.jpeg",
  ];

   RestaurantBox({super.key});


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: image.length,
      itemBuilder: ( context, int index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          margin: EdgeInsets.only(
            bottom: 15
          ),
          width: double.infinity,
          height: 160,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white

          ),
          child: Row(
            children: [
              Stack(children: [
                Image.asset(image[index],width: 150,height:double.infinity,fit: BoxFit.fill,
                ),
                Positioned(child:
                Container(

                  child: Row(
                    children: [
                      Icon(Icons.star,color: AppColors.kmain2,size: 18,),
                      SizedBox(width: 5),
                      Text("5.0",),
                    ],
                  ),
                ), )
              ],),
              SizedBox(
                width: 13,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  const Text("Filada Family Bar",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                  const SizedBox(height: 8,),
                  Text("Asian food",style: TextStyle(color: AppColors.ktext),),
                  const SizedBox(height: 40,),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,color: AppColors.ktext,),
                      Text("0.2 km - \$\$ -",style: TextStyle(color: AppColors.ktext),),
                      Icon(Icons.drive_eta_outlined,color: AppColors.kmain2,),
                      Text("Free",style: TextStyle(color: AppColors.kmain2),)
                    ],
                  )
                ],
              )

            ],
          )

        );
      },
    );
  }
}





