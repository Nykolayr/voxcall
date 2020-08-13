import 'socket.dart';
import 'value.dart';
import 'dart:convert' show json;
import 'class.dart';
import 'package:video_call/services/auth_service.dart';
import 'package:video_call/services/navigation_helper.dart';

void registerVoximplant(lawerIdSocket) {
  var headers = {'Authorization': 'Bearer ${user.token}'};
  getReq('$pathAll/cabinet/register-voximplant', headers).then((data) {
    var response = json.decode(data.body);
    if (response['success'] == true) {
      var headers = {'Authorization': 'Bearer ${user.token}'};
      getReq('$pathAll/voximplant/user', headers).then((data) {
        var response = json.decode(data.body);
        print('${user.voxName} = ${user.voxPass}');
        user.voxName = response['name'];
        user.voxPass = response['password'];
        initVox(lawerIdSocket);
      });
    } else {
      print('Ошибка регистрации клиента в системе Voximplant');
      sockets.send({
        'command': "register_vox_error",
        'lawyer_id_socket': lawerIdSocket,
        'error': 'Ошибка регистрации клиента в системе Voximplant'
      });
    }
  });
}

void initVox(lawerIdSocket) {
  print('вызвали initVox');
  print('${user.voxName} = ${user.voxPass}');

  AuthService().loginWithPassword(user.voxName, user.voxPass).then((value) {
    print(value);
    print('авторизация прошла');
    sockets.send(
        {'command': "register_vox_success", 'lawyer_id_socket': lawerIdSocket});
    sockets.send({
      'command': "add-client-online-vox",
      'lawyer_id_socket': lawerIdSocket,
      'id': user.id,
      'status': 1
    });
    Future.delayed(Duration(milliseconds: 10), () => {}).then((value) =>
        NavigationHelper.pushToIncomingCall(caller: 'Доступное право'));
  }).catchError((err) {
    print('авторизация не прошла');
    sockets.send({
      'command': "add-client-online-vox",
      'lawyer_id_socket': lawerIdSocket,
      'id': user.id,
      'status': 2
    });
    sockets.send({
      'command': "register_vox_error",
      'lawyer_id_socket': lawerIdSocket,
      'error': 'Ошибка регистрации клиента в системе Voximplant'
    });
  });
}
