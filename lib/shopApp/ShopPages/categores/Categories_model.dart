class Categories_model{
  bool? status;
  CategoriesData? Data;

  Categories_model.fromJson(Map<String,dynamic> json){
    status = json["status"];
    Data = CategoriesData.fromJson(json["data"]);
  }
}


class CategoriesData{
  int? current_page;
  List<dataaaa> data = [];

  CategoriesData.fromJson(Map<String, dynamic> json)
  {
    current_page = json["current_page"];
    json['data'].forEach((element)
    {
      data.add(dataaaa.fromJson(element));
    });

  }
}


class dataaaa{
  int? id;
  String? name;
  String? image;

  dataaaa.fromJson(Map <String,dynamic> json){
    id = json["id"];
    name = json["name"];
    image = json["image"];
  }
 }