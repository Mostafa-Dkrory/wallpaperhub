import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperhub2/data/constants.dart';
import 'package:wallpaperhub2/model/wallpaper_model.dart';
import 'package:wallpaperhub2/widget/widget.dart';

class Categorie extends StatefulWidget {
  final String categorieName;
  Categorie({this.categorieName});
  @override
  _CategorieState createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  List<WallpaperModel> wallpapers = new List();
  getSearchWallpapers(String query) async {
    var response = await http.get(
        'https://api.pexels.com/v1/search?query=$query&per_page=$kNumberOfImagesPerPage&page=$kPageNumber',
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
    getSearchWallpapers(widget.categorieName);
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
        child: Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              SizedBox(height: 16),
              wallpapersList(wallpapers: wallpapers, context: context),
              nextPageButton(initState),
            ],
          ),
        ),
      ),
    );
  }
}
