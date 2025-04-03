import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/icd.dart';

class IcdRepository {

  static Future<String> getEntityId(String code) async {

  
    var url = 'http://floris-20df0051ge.local:8081/icd/release/11/2024-01/mms/codeinfo/$code';
    // var url = 'http://localhost/icd/release/11/2024-01/mms/codeinfo/$code';
    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'application/json',
      'Accept-language': 'en',
      'Api-version': 'v2',
    });
    if (response.statusCode == 200) {
      var codeinfo = jsonDecode(response.body);
      return codeinfo["stemId"].split("/").last;
    } else {
      throw Exception('Failed to get Entity ID');
    }
    
  }

  static Future<Map<String, dynamic>> getEntity(String id) async {
    var url = 'http://floris-20df0051ge.local:8081/icd/entity/$id';
    // var url = 'http://localhost:80/icd/entity/$id';

    var response = await http.get(Uri.parse(url), headers: {
      'accept': 'application/json',
      'Accept-language': 'en',
      'Api-version': 'v2',
    });
    if (response.statusCode == 200) {
      var entity = jsonDecode(response.body);
      
      return entity;
    } else {
      throw Exception('Failed to load entity');
    }
  }
  static Future<Icd> getIcd(String code) async {
    try{
    String entityID=  await getEntityId(code);
    Map<String, dynamic> entity = await getEntity(entityID);
    String title = entity["title"]["@value"];
    String description = entity["definition"]?["@value"]??'';
    return Icd(title: title, description: description, entity: entityID, code: code);
    }
    catch(e){
      return Icd(title: code, description: '', entity: '', code: code);
    }
  }                   
}