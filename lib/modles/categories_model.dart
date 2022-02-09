class CategoriesModel
{
  bool?status;
  CategoriesDataModel?data;

  CategoriesModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  List<DataModel> dataList = [];
  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((element) {
        dataList.add(new DataModel.fromJson(element));
      });
    }

  }
}



class DataModel
{
  int?id;
  String ? name;
  String ? image;

  DataModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}