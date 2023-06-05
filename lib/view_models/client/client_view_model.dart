import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/api/business_api.dart';
import '../../domain/models/common/category.dart';
// import '../../domain/models/category.dart';

class ClientViewModel extends ChangeNotifier {
  final BusinessApi _businessApi = BusinessApi();

  int currentIndex = 0;

  bool isLoading = false;
  bool isLoadingCategories = false;

  List<Category> categories = [];

  void setindex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void onChange(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    const storage = FlutterSecureStorage();

    // await prefs.remove('isLogged');
    // await storage.delete(key: 'token');
    await prefs.clear();
    await storage.deleteAll();
    currentIndex = 0;
    // notifyListeners();
  }
}
