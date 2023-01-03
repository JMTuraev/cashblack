import '../core/api/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/models/worker.dart';

class SettingsViewModel extends ChangeNotifier {
  final Client _client = Client();

  Future<void> changeName(int userId, String firstName, String lastName) async {
    await _client.changeName(userId, firstName, lastName);
    // notifyListeners();
  }

  Future<void> rebuild() async {
    notifyListeners();
  }

  Future<void> createWorker(
    String userName,
    String password,
    String firstName,
    String lastName,
  ) async {
    await _client.createWorker(userName, password, firstName, lastName);
  }

  Future<List<Worker>> getWorkers() async {
    return _client.getWorkers();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final storage = FlutterSecureStorage();

    // await prefs.remove('isLogged');
    // await storage.delete(key: 'bearer');
    await prefs.clear();
    await storage.deleteAll();
  }
}
