import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'class.dart';
import 'value.dart';

// класс отвечающий за состояние приложения
class StateButton with ChangeNotifier {
  var _context;
  int _localVideoViewController;
  int _remoteVideoViewController;
  int get localVideoViewController => _localVideoViewController;
  int get remoteVideoViewController => _remoteVideoViewController;
  get context => _context;

  String _loginVox;
  String _passVox;
  String get loginVox => _loginVox;
  String get passVox => _passVox;

  set context(var newValue) {
    _context = newValue;
    notifyListeners();
  }

  set loginVox(var newValue) {
    _loginVox = newValue;
    notifyListeners();
  }

  set passVox(var newValue) {
    _passVox = newValue;
    notifyListeners();
  }

  set localVideoViewController(var newValue) {
    _localVideoViewController = newValue;
    notifyListeners();
  }

  set remoteVideoViewController(var newValue) {
    _remoteVideoViewController = newValue;
    notifyListeners();
  }

  //конструктор
  StateButton(this._loginVox, this._passVox);
//взять данные
  getShare() async {
    notifyListeners();
  }

  press(int n) {
    var line =
        '------------------------------------------------------------------------------------------------------------------------------------';
    if (n == -1) {
      print('нажали бесплатно');
//* создание консультации *//
      var body = {
        "type": '1',
        "view_type": '0',
        "profile": '1',
        'platform': 'android'
      };
      var headers = {'Authorization': 'Bearer ${user.token}'};
      postReq('$pathAll/cabinet/consultation-create', body, headers)
          .then((res) {
        print("Response status: ${res.statusCode}");
        print(line);
        print("Response body: ${res.body}");
      });
    }
    // CallService().answerVideoCall().then((value) {
    //   print(line);
    //   print('отвечаем видео');
    //         print('answer2');
    // });
  }

// сохранить данные Connecting
  setShare() async {
    notifyListeners();
  }
}
