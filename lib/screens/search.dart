import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperhub2/data/constants.dart';
import 'package:wallpaperhub2/model/wallpaper_model.dart';
import 'package:wallpaperhub2/widget/widget.dart';

class Search extends StatefulWidget {
  final searchQuery;

  Search({this.searchQuery});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = new TextEditingController();
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
    getSearchWallpapers(widget.searchQuery);
    super.initState();
    searchController.text =
        widget.searchQuery; // To make search keyword shows in search screen
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
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF5F8FD),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                margin: EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Search(
                                      searchQuery: searchController.text,
                                    )));
                      },
                      child: Container(
                        child: Icon(Icons.search, color: Colors.blue, size: 25),
                      ),
                    ),
                  ],
                ),
              ),
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
