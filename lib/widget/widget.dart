import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaperhub2/data/constants.dart';
import 'package:wallpaperhub2/model/wallpaper_model.dart';
import 'package:wallpaperhub2/screens/image_view.dart';

Widget brandName() {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      children: <TextSpan>[
        TextSpan(
            text: 'Wallpaper',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Segoe Print',
              fontWeight: FontWeight.w700,
            )),
        TextSpan(
            text: 'Hub',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w900,
              fontFamily: 'Segoe Print',
            )),
      ],
    ),
  );
}

Widget wallpapersList({List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.65,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageView(
                    imgUrl: wallpaper.src.portrait,
                    photographer: wallpaper.photographer,
                    photographerURL: wallpaper.photographerURL,
                  ),
                ),
              );
            },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    wallpaper.src.portrait,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}

Widget nextPageButton(Function initState) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            children: <TextSpan>[
              TextSpan(
                  text: 'Photos provided by ',
                  style: TextStyle(color: Colors.black)),
              TextSpan(
                text: 'Pexels',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    final url = 'https://www.pexels.com/';
                    if (await canLaunch(url)) {
                      await launch('$url', forceSafariVC: false);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            kPageNumber++;
            initState();
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Next ',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )),
                Icon(
                  FontAwesomeIcons.arrowRight,
                  //Icons.arrow_forward,
                  color: Colors.blue,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
