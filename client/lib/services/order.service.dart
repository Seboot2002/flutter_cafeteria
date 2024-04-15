import 'dart:convert';

import 'package:http/http.dart' as http;

const baseUrl = 'http://192.168.0.20:3700';

class orderService{

  Future getOrders(String token) async {

    var client = http.Client();
    var url = Uri.parse('$baseUrl/getOrdersSeller');
    var headers = {'Authorization': token};
    Map dishesData;
    List data;

    var response = await client.get(url, headers: headers);

    if(response.statusCode == 200)
    {
      dishesData = await jsonDecode(response.body);
      data = dishesData['orders'];
      return data;
    }
    else if(response.statusCode == 404)
    {
      print("Error en la peticion getDishes");
    }

  }

  Future createOrder(String token, String sellerId, String dishId) async {

    var client = http.Client();
    var url = Uri.parse('$baseUrl/saveOrder/$sellerId/$dishId');
    var headers = {'Authorization': token};
    Map dishesData;
    List data;

    var response = await client.post(url, headers: headers);

    if(response.statusCode == 200)
    {
      await getOrders(token);
      return response.body;
    }
    else if(response.statusCode == 404)
    {
      print("Error en la peticion getOrders");
    }

  }

  Future deleteOrder(String token, String idOrder) async {

    var client = http.Client();
    var url = Uri.parse('$baseUrl/deleteOrder/$idOrder');
    var headers = {'Authorization': token};
    Map dishesData;
    List data;

    var response = await client.delete(url, headers: headers);

    if(response.statusCode == 200)
    {
      await getOrders(token);
      return response.body;
    }
    else if(response.statusCode == 404)
    {
      print("Error en la peticion getOrders");
    }

  }

  Future updateOrder(String token, String orderId, String state) async {

    var client = http.Client();
    var url = Uri.parse('$baseUrl/saveOrder/$orderId');
    var headers = {'Authorization': token};
    Map dishesData;
    List data;

    var response = await client.put(url, headers: headers,
    body: jsonEncode({
      'state': state
    }));

    if(response.statusCode == 200)
    {
      await getOrders(token);
      return response.body;
    }
    else if(response.statusCode == 404)
    {
      print("Error en la peticion getOrders");
    }

  }



}