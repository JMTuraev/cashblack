import 'dart:io';

import 'package:flutter/material.dart';

import '../core/api/client.dart';
import '../domain/models/category.dart';
import '../domain/models/city.dart';
import '../domain/models/user.dart';

class CreateStoreViewViewModel extends ChangeNotifier {
  final Client _client = Client();
  // List<Category> categories = [];
  // List<Province> provincies = [];
  // List<City> cities = [];

  // Future<void> _getCategories() async {
  //   categories = await _client.getCategories();
  // }

  // Future<void> _getProvincies() async {
  //   provincies = await _client.getProvincies();
  // }

  // Future<void> _getCities() async {
  //   cities = await _client.getCities();
  // }

  // Future<void> getCategoryProperties() async {
  //   _getCategories();
  //   _getProvincies();
  //   _getCities();
  // }

  Future<List<Category>> getCategories() async {
    return _client.getCategories();
  }

  Future<List<Province>> getProvincies() async {
    return _client.getProvincies();
  }

  Future<List<City>> getCities() async {
    return _client.getCities();
  }

  Future<User> getProfile() async {
    return _client.getProfile();
  }

  Future<void> createstore(
    // int userId,
    int category,
    String name,
    int cashback,
    int province,
    int city,
    File file,
  ) async {
    return _client.createStore(
      // userId,
      category,
      name,
      cashback,
      province,
      city,
      file,
    );
  }
}
