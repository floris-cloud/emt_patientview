import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/icd.dart';

class IcdRepository {
  static Future<String> getEntity(String id) async {
    var url = 'http://floris-20df0051ge.local:80/icd/entity/$id';

    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'application/json',
      'Accept-language': 'en',
      'Api-version': 'v2',
    });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return '';
    }
  }
  static Future<Icd> getIcd(String id) async {
    Map<String, dynamic> entity =  jsonDecode(await getEntity(id));
    String title = entity["title"]["@value"];
    String description = entity["definition"]["@value"];
    return Icd(code: title, description: description);

  }
}