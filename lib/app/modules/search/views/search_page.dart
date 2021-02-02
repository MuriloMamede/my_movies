import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_movies/app/global/widgets/customBottomAppBar.dart';
import 'package:my_movies/app/modules/search/controllers/search_controller.dart';

class SearchPage extends GetView<SearchController> {
  final SearchController _searchController = Get.find<SearchController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: CustomBottomAppBar(),
        body: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Center(
            child: Column(
              children: [
                Container(
                  height: Get.height * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 8),
                          color: Colors.grey,
                          child: TextField(
                            onSubmitted: (text) =>
                                _searchController.searchMovie(text),
                            autofocus: true,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Pesquisar',
                                suffixIcon:
                                    Icon(Icons.search, color: Colors.white)),
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                        itemCount: _searchController.movies.length,
                        itemBuilder: (context, index) => ListTile(
                              title: Text(
                                _searchController.movies[index].title,
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
