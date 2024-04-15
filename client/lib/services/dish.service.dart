import 'dart:convert';

import 'package:http/http.dart' as http;

const baseUrl = 'http://192.168.0.20:3700';

class DishService {
  Future getDishes(String token) async {
    var client = http.Client();
    var url = Uri.parse('$baseUrl/getDishes');
    var headers = {'Authorization': token};
    Map dishesData; //Map acepta json pero no array, pero permite entrar en los valores del json
    List data; //List acepta json y array

    final response = await client.get(url, headers: headers);

    final responseJson = jsonDecode(response.body);

    return responseJson;
    /*
    if (response.statusCode == 200) {
      dishesData =
          await jsonDecode(response.body); //jsonDecode transforma el json a Map
      print(dishesData);
      data = dishesData['dishes'];
      return data;
    } else if (response.statusCode == 404) {
      print("Error en la peticion getDishes");
    }*/
  }
}
