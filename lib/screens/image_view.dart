import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;
  final String photographer;
  final String photographerURL;

  ImageView(
      {@required this.imgUrl,
      @required this.photographer,
      @required this.photographerURL});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Hero(
            tag: widget.imgUrl,
            child: Container(
              height: MediaQuery.of(context)
                  .size
                  .height, //to get all height of the screen
              width: MediaQuery.of(context)
                  .size
                  .width, //to get all width of the screen
              child: Image.network(
                widget.imgUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Row(
                        children: [
                          Text("Wallpaper Saved."),
                          SizedBox(width: 10),
                          Icon(FontAwesomeIcons.solidThumbsUp),
                        ],
                      ),
                      duration: Duration(seconds: 100),
                    ));
                    _save();
                  },
                  child: Stack(
                    children: [
                      // Container(
                      //   height: 50,
                      //   width: MediaQuery.of(context).size.width / 2,
                      //   decoration: BoxDecoration(
                      //     color: Color(0xFF1C1B1B).withOpacity(0.8),
                      //     border: Border.all(color: Colors.white54, width: 1),
                      //     borderRadius: BorderRadius.circular(30.0),
                      //     gradient: LinearGradient(
                      //       colors: [
                      //         Color(0xFFFFFFFF),
                      //         Color(0x00FFFFFF),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2,
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54, width: 1),
                          borderRadius: BorderRadius.circular(30.0),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFF232526),
                              Color(0x02434343),
                              //Color(0xFFFFFFFF),
                              // Color(0xF000000F),
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Set Wallpaper',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Image will be saved in gallery',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 16.0),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Photo by ',
                          style: TextStyle(color: Colors.amber)),
                      TextSpan(
                        text: '${widget.photographer}',
                        style: TextStyle(
                            color: Colors.blue,
                            fontFamily: 'Segoe Print',
                            fontWeight: FontWeight.w700),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            if (await canLaunch(widget.photographerURL)) {
                              await launch('${widget.photographerURL}',
                                  forceSafariVC: false);
                            } else {
                              throw 'Could not launch ${widget.photographerURL}';
                            }
                          },
                      ),
                    ],
                  ),
                ),
                // Text(
                //   '${widget.photographer}',
                //   style: TextStyle(color: Colors.blue),
                // ),
                SizedBox(height: 40.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _save() async {
    if (Platform.isAndroid) {
      await _askPermission();
    }
    var response = await Dio()
        .get(widget.imgUrl, options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }

  _askPermission() async {
    if (Platform.isIOS) {
      /*Map<PermissionGroup, PermissionStatus> permissions =
         */
      await PermissionHandler().requestPermissions([PermissionGroup.photos]);
    } else {
      /* PermissionStatus permission = */ await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
      await PermissionHandler().requestPermissions(
          [PermissionGroup.storage, PermissionGroup.photos]);
    }
  }
}
