import 'dart:convert';

import 'package:http/http.dart' as http;

const baseUrl = 'http://192.168.0.20:3700'; //Se debe usar la ip del internet ipv4 ya que la app del movil no conoce el localhost de la maquina del servidor

class UserService{
  //Future es una clase que nos permite trabajar de manera asincrona
  Future registerUser(String api, String name, String email, String password, String code_uni, String type) async {

    var client = http.Client();
    var url = Uri.parse(baseUrl+api);

    //una peticion es de tipo Response
    var response = await client.post(url,
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: jsonEncode({ //Aqui no hay json, esto se entiende en flutter como Map
      "name": name,
      "email": email,
      "password": password,
      "code_uni": code_uni,
      "type": type
    }));

    if(response.statusCode == 200)
    {
      return response.body;
    }
    else if(response.statusCode == 404)
    {
      print("Error en la peticion");
    }
  }

  Future loginUser(String api, String email, String password, bool getToken) async {

    var client = http.Client();
    var url = Uri.parse(baseUrl+api);

    //una peticion es de tipo Response
    var response = await client.post(url,
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: jsonEncode({
      'email': email,
      'password': password,
      'getToken': getToken
    }));

    if(response.statusCode == 200)
    {
      return response.body;
    }
    else if(response.statusCode == 404)
    {
      print("Error en la peticion");
    }
  }
}