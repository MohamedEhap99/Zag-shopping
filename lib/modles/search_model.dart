class SearchModel {
  bool?status;
  Null?message;
  SearchData?data;
  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  SearchData.fromJson(json['data']) : null;
  }
}

class SearchData {
  int?currentPage;
  List<Products> data=[];
  String?firstPageUrl;
  int?from;
  int?lastPage;
  String?lastPageUrl;
  Null?nextPageUrl;
  String?path;
  int?perPage;
  Null?prevPageUrl;
  int ?to;
  int ?total;


  SearchData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(Products.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}


class Products {
  int?id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String?image;
  String?name;
  String?description;
  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}