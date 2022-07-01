class WallpaperModel {
  String photographer;
  String photographerURL;
  int photographerID;
  SrcModel src;

  WallpaperModel(
      {this.src, this.photographer, this.photographerID, this.photographerURL});

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData) {
    return WallpaperModel(
      src: SrcModel.fromMap(jsonData['src']),
      photographer: jsonData['photographer'],
      // photographerID: jsonData['photographer_id'],
      photographerURL: jsonData['photographer_url'],
    );
  }
}

class SrcModel {
  String portrait;
  // String original;
  // String small;

  SrcModel({
    this.portrait,
    /*this.original,  this.small*/
  });
  factory SrcModel.fromMap(Map<String, dynamic> jsonData) {
    return SrcModel(
      portrait: jsonData['portrait'],
      // original: jsonData['original'],
      // small: jsonData['small'],
    );
  }
}
