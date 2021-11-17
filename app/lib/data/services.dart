import 'dart:convert';
import 'dart:io';
import 'package:bloc_sql/utils/customException.dart';
import 'package:http/http.dart' as http;

class NetworkServices {
  static final baseUrl =
      "http://75b7-2400-1a00-b020-f89-e98f-8be8-bddc-eee2.ngrok.io";

  Future<List<dynamic>> fetchTodos() async {
    print("fetch");
    var responseJson;
    try {
      final response = await http.get(Uri.parse(baseUrl + "/todos"));
      print(response.body);
      responseJson = _response(response);
    } on SocketException {
      print("hasjdhasd");
      throw FetchDataException("No Internet connection");
    }
    return responseJson as List;
  }

  Future<dynamic> patchTodo(Map<String, String> patchobj, int? id) async {
    try {
      final response =
          await http.patch(Uri.parse(baseUrl + "/todos/${id}"), body: patchobj);
      var responseJson = _response(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException("No Internet connection");
    }
  }

  Future<dynamic> addTodo(Map<String, String> obj) async {
    var responseJson;
    try {
      final response =
          await http.post(Uri.parse(baseUrl + "/todos"), body: obj);
      responseJson = _response(response);
      // print(response);
      // print(response.statusCode);
      // return response;
    } on SocketException {
      throw FetchDataException("No Internet connection");
    }
    return responseJson;
  }

  Future<dynamic> editTodo(Map<String, String> patchobj, int? id) async {
    try {
      final response =
          await http.patch(Uri.parse(baseUrl + "/todos/${id}"), body: patchobj);
      var responseJson = _response(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException("No Internet connection");
    }
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 201:
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        throw InvalidInputException(response.body.toString());
      default:
        throw FetchDataException(
            'Error while communicating with server with status code : ${response.statusCode}');
    }
  }

  Future<dynamic> deleteTodo(int? id) async {
    try {
      final response = await http.delete(Uri.parse(baseUrl + "/todos/${id}"));
      var responseJson = _response(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException("No Internet connection");
    }
  }
}
