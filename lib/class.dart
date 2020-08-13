import 'value.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

UserProf user = UserProf(myuser);

// Начальная функция
//профиль юзера
class UserProf {
  String voxName;
  String voxPass;
  Map city;
  String email;
  int id;
  int money;
  String name;
  String pass;
  String phone;
  int status;
  int timeCreate;
  int timezone;
  String token;
  UserProf(Map<dynamic, dynamic> json) {
    fromJson(json);
  }
  fromJson(Map<dynamic, dynamic> json) {
    voxName = json['voxName'];
    voxPass = json['voxPass'];
    city = json['city'];
    email = json['email'];
    id = json['id'];
    money = json['money'];
    name = json['name'];
    pass = json['pass'];
    phone = json['phone'];
    status = json['status'];
    timeCreate = json['timeCreate'];
    timezone = json['timezone'];
    token = json['token'];
  }
}
