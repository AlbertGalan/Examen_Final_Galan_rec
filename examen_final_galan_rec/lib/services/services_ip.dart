import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dart_ipify/src/model/geo.dart';


class ServicesIP extends ChangeNotifier {
  final String _baseUrl = "https://api.ipify.org?format=json";
  Map<String, dynamic> ip = {"ip": "188.86.28.212"};

  ServicesIP() {
    carregarIP();
  }

  Future<void> carregarIP() async {
    final url = Uri.parse(_baseUrl);
    final response = await http.get(url);

    print("URL: $url");
    print("Response status code: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      ip = json.decode(response.body);
      print("IP carregada: $ip");
    } else {
      throw Exception('Error al carregar la ip');
    }

    notifyListeners();
  }

}