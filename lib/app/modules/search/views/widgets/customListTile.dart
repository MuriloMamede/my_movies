import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomListTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final Function onPressed;
  CustomListTile({this.imageUrl, this.title = '', this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.2),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: Get.width * 0.2,
                height: Get.height / 10,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(imageUrl)))),
            Container(
              width: Get.width * 0.56,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onPressed,
              child: Column(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, right: 5),
                    child: Text(
                      'Minha Lista',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
