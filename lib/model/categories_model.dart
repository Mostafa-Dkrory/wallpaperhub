import 'package:flutter/material.dart';
import 'package:wallpaperhub2/screens/categorie.dart';
import 'package:wallpaperhub2/screens/search.dart';

class CategoriesModel {
  String categorieName;
  String imgUrl;
}

class CategoriesContainer extends StatelessWidget {
  const CategoriesContainer({
    Key key,
    @required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Search(searchQuery: searchController.text)));
            },
            child: Container(
              child: Icon(Icons.search, color: Colors.blue, size: 25),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  CategoriesTile({@required this.title, @required this.imgUrl});

  final String imgUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Categorie(
              categorieName: title.toLowerCase(),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 4),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imgUrl,
                height: 60,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
              height: 60,
              width: 100,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Lobster Two',
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
