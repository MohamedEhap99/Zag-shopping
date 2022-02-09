class HomeModel
{
   bool?status;
  String? message;
   HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message= json['message'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel
{
  List<BannerModel>?banners = [];
  List<ProductsModel>?products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json)
  {
    json['banners'].forEach((element){
      banners!.add(BannerModel.fromJson(element));
    });

    json['products'].forEach((element)
    {
      products!.add(ProductsModel.fromJson(element));
    });
  }
}

class BannerModel
{
   int ?id;
   String ?image;

  BannerModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel
{
late  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String ?image;
  String ?name;
  String ?description;
 late bool inFavorites;
   bool ?inCart;

  ProductsModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description=json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}