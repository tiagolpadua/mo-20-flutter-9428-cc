import 'package:http/http.dart';

void findAll() {
  get('http://192.168.0.100:8080/transactions')
      .then((value) => print('value: ${value.body}'));
//  get('http://10.0.2.2:8080/transactions')
//      .then((value) => print('value: ${value.body}'));
}