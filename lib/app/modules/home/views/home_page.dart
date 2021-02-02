import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_movies/app/modules/home/controllers/home_controller.dart';
import 'package:my_movies/app/modules/home/views/widgets/moviesList.dart';

class HomePage extends GetView<HomeController> {
  final HomeController _homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.red,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {}),
            IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                onPressed: () {}),
            IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {}),
          ]),
        ),
      ),
      // appBar: AppBar(title: Text('Home')),
      body: Padding(
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
                            height: Get.height * 0.5,
                            child: _.myMoviesList.length == 0
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          'Você ainda não tem nenhum filme marcado para assistir'),
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
                                          buttonText: 'Marcar como Assistido',
                                          icon: Icons.check,
                                          onTap: () => _.markAsWatched(index),
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/original/${_.moviesPopularList[index].posterPath}',
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
                            itemCount: _homeController.moviesPopularList.length,
                            itemBuilder: (context, index) => MoviesListWidget(
                                  buttonText: 'Minha Lista',
                                  icon: Icons.add,
                                  onTap: () => _.addtoMyList(index),
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/original/${_.moviesPopularList[index].posterPath}',
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
    );
  }
}
