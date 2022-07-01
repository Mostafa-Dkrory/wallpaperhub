import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaperhub2/data/constants.dart';
import 'package:wallpaperhub2/data/data.dart';
import 'package:wallpaperhub2/model/categories_model.dart';
import 'package:wallpaperhub2/model/wallpaper_model.dart';
import 'package:wallpaperhub2/widget/widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories = new List();
  List<WallpaperModel> wallpapers = new List();
  TextEditingController searchController = new TextEditingController();

  getTrendingWallpapers() async {
    var response = await http.get(
        'https://api.pexels.com/v1/curated?per_page=$kNumberOfImagesPerPage&page=$kPageNumber',
        headers: {"Authorization": apiKey});

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData['photos'].forEach(
      (element) {
        WallpaperModel wallpaperModel = new WallpaperModel();
        wallpaperModel = WallpaperModel.fromMap(element);
        wallpapers.add(wallpaperModel);
      },
    );
    // updating the screen after getting Data
    setState(() {});
  }

  @override
  void initState() {
    getTrendingWallpapers();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              // SearchBar Container
              CategoriesContainer(searchController: searchController),
              SizedBox(height: 10),
              //Made with love
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Made with  ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      FontAwesomeIcons.solidHeart,
                      // Icons.favorite,
                      color: Colors.red,
                    ),
                    FlatButton(
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () async {
                        const url = 'https://www.facebook.com/dkrory22';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Text(
                        'by DKRORY',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontFamily: 'Segoe Print',
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              // Categories ListView Container
              Container(
                height: 80,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoriesTile(
                        title: categories[index].categorieName,
                        imgUrl: categories[index].imgUrl,
                      );
                    }),
              ),

              wallpapersList(wallpapers: wallpapers, context: context),
              nextPageButton(initState),
            ],
          ),
        ),
      ),
    );
  }
}
