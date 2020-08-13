import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert' show json;
import 'package:http/http.dart' as http;
import 'socket.dart';
import 'class.dart';

/*   константы   */
/*   системные   */
final bool test = true;

/*   цвета   */
final Color backgroundColorBottomBar = HexColor('#FFF8DB'); // цвет нижнего бара
final Color borderColorBottomBar = HexColor('#FEDC4D'); // обводка нижнего бара
final Color backgroundColorBut1 = HexColor('#FEDC4D'); // цвет кнопки 1
final Color colorBut1 = HexColor('#6A6A6A'); // цвет текста кнопки 1
final Color shadowBut1 = Color.fromRGBO(0, 0, 0, 0.1); // цвет тени кнопки
final Color colorTextAppBar = HexColor('#CA635F'); // цвет тени кнопки
final Color colorMain = HexColor('#6ACA01'); // главный цвет темы
final Color colorGrey = HexColor('#575757'); // серый цвет темы
final Color colorRed = HexColor('#CA635F'); // красный цвет темы
/*   переменные   */
//начальная загрузка myuser, потом надо будет убрать
Map myuser = {
  'VoxName': "74_client@videochat-dev.dostpravo.voximplant.com",
  'VoxPass': "9fb7e480b771c00e428a84aeb3c216404d1e89a8918d76c096a93acbccfb00c8",
  'city': {'id': 50, 'name': "Икша"},
  'email': "Dgg@dgg.ru",
  'id': 74,
  'money': null,
  'name': "Тест",
  'pass': "123456",
  'phone': "79999999994",
  'status': 1,
  'time_create': 1557291541,
  'timezone': 7,
  'token': "U5XoCWxpcUJ_MpS50GiI8BG9ARBFW7cg1596019354"
};
/*  Пути к запросам */
String pathAll =
    "https://api.dostupnoepravo.ru/v1"; // путь к запросам виды помощи, запрос get  JSON
String puthImg = "https://dp.edcn.ru/img/article/normal/"; // путь к картинками
String socket = "wss://dostupnoepravo.ru/ws";
String pathMoney = "https://dostupnoepravo.ru/";

//   Ответ {"id": 2, "category_id": 1, "name": "Банкротство физических лиц", "price": 800, "price_express": 99   }
String token = pathAll +
    "/auth/token"; // путь для получения токена запрос POST {"phone": "79039948890","password": "12345678"}
//   Ответ {"token": "lOL2LVGJKMAJg1R5lirZIcd34cjmPugQ1556177221"}
String registration = pathAll +
    "/auth/registration"; // путь к запросам регистрации запрос POST {"phone": "79039948897","name": "Илья"}
//   Ответ {"success": true, "user": 15, "token": 5576 }
String verification = pathAll +
    "/auth/verification-token"; // путь к запросам проверки смс запрос POST {"user_id": "15","token": "5576"}
//   Ответ { "success": true, "token": "HkJr4PLueTPuSxwtbrhby-2VeX6frmyC1556182025" }

// остальные
double widthScr, heightScr; // размеры экрана
var lawerIdSocket; // id юриста в сокетах
Map body; // дополнительные данные
Map headers; // заголовок

/*   дополнительные функции  */
// функция для использования 16 именование цвета
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

//  отправляет строку по сокетам, val - строка JSON
addSocket(Map val, WebSocket ws) {
  ws.add(json.encode(val).codeUnits);
}

//функция для отправки GET запросов
Future<http.Response> getReq(url, headers) {
  return http.get(url, headers: headers);
}

//функция для отправки POST запросов
Future<http.Response> postReq(url, body, headers) {
  return http.post(url, body: body, headers: headers);
}

//функция для начального распределения путей
begin() {
  if (test) {
    pathAll = "https://api.dp.edcn.ru/v1";
    socket = "wss://dp.edcn.ru/ws";
    puthImg = "https://dp.edcn.ru/img/article/normal/";
    pathMoney = "https://dp.edcn.ru/";
  }
  sockets.initCommunication(user);
  sockets.send({'command': "open_client", 'id': user.id});
  sockets.send({'command': "open", 'id': user.id, 'role': "client"});
  sockets.send({'command': "add-client-online", 'id': user.id});
}
