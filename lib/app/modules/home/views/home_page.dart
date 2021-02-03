import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_movies/app/global/constants.dart';
import 'package:my_movies/app/global/widgets/customBottomAppBar.dart';
import 'package:my_movies/app/modules/home/controllers/home_controller.dart';
import 'package:my_movies/app/modules/home/views/widgets/moviesList.dart';

class HomePage extends GetView<HomeController> {
  final HomeController _homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: CustomBottomAppBar(),
      // appBar: AppBar(title: Text('Home')),
      body: SingleChildScrollView(
        child: Container(
          width: Get.width * 1,
          height: Get.height * 0.94,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: GetX<HomeController>(
                init: HomeController(),
                initState: (_) {},
                builder: (_) {
                  try {
                    if (_.moviesPopularList.length > 0) {
                      return Column(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              Container(
                                height: Get.height * 0.1,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text(
                                        'Minha Lista',
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: Get.height * 0.47,
                                child: _.myMoviesList.length == 0
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              'Você ainda não tem filmes marcados para assistir',
                                              style: TextStyle(
                                                fontSize: 18,
                                              )),
                                        ],
                                      )
                                    : GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio: 1,
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 1,
                                                mainAxisSpacing: 1),
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            _homeController.myMoviesList.length,
                                        itemBuilder: (context, index) =>
                                            MoviesListWidget(
                                              buttonText: _homeController
                                                      .myMoviesList[index]
                                                      .isWatched
                                                  ? 'Já Assistido'
                                                  : 'Marcar como Assistido',
                                              icon: Icons.check,
                                              onTap: () =>
                                                  _.markAsWatched(index),
                                              imageUrl: _homeController
                                                          .myMoviesList[index]
                                                          .posterPath ==
                                                      null
                                                  ? imgNotFound
                                                  : imageUrl +
                                                      _homeController
                                                          .myMoviesList[index]
                                                          .posterPath,
                                            )),
                              ),
                            ],
                          )),
                          Container(
                            height: Get.height * 0.07,
                            child: Row(
                              children: [
                                Text(
                                  'Mais Populares',
                                  style: TextStyle(fontSize: 30),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: Get.height * 0.25,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    _homeController.moviesPopularList.length,
                                itemBuilder: (context, index) =>
                                    MoviesListWidget(
                                      buttonText: 'Minha Lista',
                                      icon: Icons.add,
                                      onTap: () => _.addtoMyList(index),
                                      imageUrl: imageUrl +
                                          _.moviesPopularList[index].posterPath,
                                    )),
                          ),
                        ],
                      );
                    } else {
                      _.loadData();
                      return CircularProgressIndicator();
                    }
                  } catch (e) {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
