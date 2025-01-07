import 'dart:async';

import '../models/patient.dart';
import '../models/protocol.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProtocolRepository {
  static Future<void> saveProtocol(Protocol protocol) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(protocol.patientId, jsonEncode(protocol));
  }

  static Future<Protocol?> loadProtocol(Patient patient) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? protocolJson = prefs.getString(patient.id);
    Protocol protocol = Protocol.fromJson(protocolJson!);
    return protocol;

  }
}
