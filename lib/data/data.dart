import 'package:wallpaperhub2/model/categories_model.dart';

List<CategoriesModel> getCategories() {
  List<CategoriesModel> categories = new List();
  CategoriesModel categoryModel = new CategoriesModel();

  //
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.categorieName = "Street Art";
  categories.add(categoryModel);
  categoryModel = new CategoriesModel();

  //
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/704320/pexels-photo-704320.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.categorieName = "Wild Life";
  categories.add(categoryModel);
  categoryModel = new CategoriesModel();

  //
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.categorieName = "Nature";
  categories.add(categoryModel);
  categoryModel = new CategoriesModel();

  //
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.categorieName = "City";
  categories.add(categoryModel);
  categoryModel = new CategoriesModel();

  //
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/1434819/pexels-photo-1434819.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260";
  categoryModel.categorieName = "Motivation";

  categories.add(categoryModel);
  categoryModel = new CategoriesModel();

  //
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.categorieName = "Bikes";
  categories.add(categoryModel);
  categoryModel = new CategoriesModel();

  //
  categoryModel.imgUrl =
      "https://images.pexels.com/photos/1149137/pexels-photo-1149137.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categoryModel.categorieName = "Cars";
  categories.add(categoryModel);
  categoryModel = new CategoriesModel();

  return categories;
}
