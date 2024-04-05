

import 'package:flutter/material.dart';

import '../utils/AppColor.dart';

class CategoriesBox extends StatelessWidget {



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
  final List<String> labels = [
    'Burger',
    'Noodle',
    'Pizza',
    'Thaal',
    'Salad',
    'Burger',
    'Noodle',
    'Pizza',
    'Thaal',
    'Salad',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: image.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))

              ),
              child: Image.asset(image[index],width: 40,height: 40,),
            ),
            SizedBox(height: 5),
            Text(labels[index],style: TextStyle(color: AppColors.ktext),),
          ],
        );
      },
    );
  }
}
