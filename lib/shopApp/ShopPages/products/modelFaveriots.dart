class ChangeFaveriotsModel{

  bool? status;
  String? message;

  ChangeFaveriotsModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
  }

}