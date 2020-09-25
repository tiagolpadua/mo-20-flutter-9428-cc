import 'dart:convert';

import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

Future<List<Transaction>> findAll() async {
  Client client =
      HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
  final Response response =
      await client.get('http://192.168.0.100:8080/transactions');
  final List<dynamic> decodedJson = jsonDecode(response.body);
  print('decodedJson $decodedJson');
  final List<Transaction> transactions = List();
  for (Map<String, dynamic> el in decodedJson) {
    final Transaction transcaction = Transaction(
      el['id'],
      el['value'],
      Contact(
        0,
        el['contact']['name'],
        el['contact']['accountNumber'],
      ),
    );
    transactions.add(transcaction);
  }
  return transactions;
}

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print('Request');
    print('url: ${data.url}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print('Response');
    print('status code: ${data.statusCode}');
    print('headers: ${data.headers}');
    print('body: ${data.body}');
    return data;
  }
}
