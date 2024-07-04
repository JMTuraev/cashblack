import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/api/business_api.dart';
import '../../domain/models/common/category.dart';
import '../../string_extensions.dart';
// import '../../domain/models/category.dart';

class BusinessViewModel extends ChangeNotifier {
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

  Future<void> getCategories() async {
    isLoadingCategories = true;
    categories = await _businessApi.getCategories();
    categories = categories.sortedBy((e) => e.title).toList();
    isLoadingCategories = false;
    notifyListeners();
  }
}
