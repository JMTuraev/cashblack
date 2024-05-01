import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../domain/models/services/sklad_category.dart';
import '../../domain/models/services/sklad_deliever.dart';
import '../../domain/models/services/sklad_item.dart';
import '../../domain/models/services/sklad_item_status.dart';
import '../../domain/models/services/sklad_prixod.dart';
import '../../domain/models/services/sklad_subcategory.dart';
import '../../string_extensions.dart';

class SkladViewModel extends ChangeNotifier {
  //prixod
  TextEditingController nameController = TextEditingController();
  TextEditingController attributeController = TextEditingController();
  String? selectedCategory;
  String? selectedSubCategory;
  String? createdDate;
  TextEditingController quantityController = TextEditingController();
  TextEditingController pricePrixodController = TextEditingController();
  TextEditingController priceSellController = TextEditingController();
  TextEditingController priceSumOfAllController = TextEditingController();
  TextEditingController serialNumberController = TextEditingController();
  TextEditingController partyNumberController = TextEditingController();
  String? selectedDeliever;
  String? selectedSkladItemStatus;
  TextEditingController minQuantityController = TextEditingController();

  void clearFields() {
    // return;
    nameController.clear();
    attributeController.clear();
    selectedCategory = null;
    selectedSubCategory = null;
    createdDate = null;
    quantityController.clear();
    pricePrixodController.clear();
    priceSellController.clear();
    priceSumOfAllController.clear();
    serialNumberController.clear();
    partyNumberController.clear();
    selectedDeliever = null;
    selectedSkladItemStatus = null;
    minQuantityController.clear();
  }

  List<SkladCategory> skladCategories = [
    SkladCategory(value: '1', name: 'Категория 1', subcategories: []),
    SkladCategory(value: '2', name: 'Категория 2', subcategories: []),
    SkladCategory(value: '3', name: 'Категория 3', subcategories: []),
  ];
  List<SkladSubcategory> skladSubcatogies = [
    SkladSubcategory(value: '1', name: 'Субкатегория 1'),
    SkladSubcategory(value: '2', name: 'Субкатегория 2'),
    SkladSubcategory(value: '3', name: 'Субкатегория 3'),
  ];
  List<SkladDeliever> skladDelievers = [
    SkladDeliever(value: '1', name: 'Поставщик 1'),
    SkladDeliever(value: '2', name: 'Поставщик 2'),
    SkladDeliever(value: '3', name: 'Поставщик 3'),
  ];
  List<SkladItemStatus> skladItemStatuses = [
    SkladItemStatus(value: '1', name: 'Есть в наличии'),
    SkladItemStatus(value: '2', name: 'В пути'),
    SkladItemStatus(value: '3', name: 'Ожидается'),
  ];

  List<SkladItem> skladItems = [];
  List<SkladPrixod> skladPrixods = [];

  void addToSklad() {
    skladItems.add(
      SkladItem(
        id: const Uuid().v4(),
        name: nameController.text.trim(),
        attribute: attributeController.text.trim(),
        category: selectedCategory!.trim().removeWhitespace(),
        subCategory: selectedSubCategory!.trim().removeWhitespace(),
        createdDate: createdDate!.trim(),
        quantity: quantityController.text.trim().removeWhitespace(),
        pricePrixod: pricePrixodController.text.trim().removeWhitespace(),
        priceSell: priceSellController.text.trim().removeWhitespace(),
        priceSumOfAll: priceSumOfAllController.text.trim().removeWhitespace(),
        serialNumber: serialNumberController.text.trim().removeWhitespace(),
        partyNumber: partyNumberController.text.trim().removeWhitespace(),
        skladDeliever: selectedDeliever!.trim().removeWhitespace(),
        skladItemStatus: selectedSkladItemStatus!.trim().removeWhitespace(),
        minimumQuantity: minQuantityController.text.trim().removeWhitespace(),
      ),
    );
    notifyListeners();
  }

  void addPrixod() {
    print(skladItems.length);
    if (skladItems.isEmpty) {
      print('object');
      return;
    } else {
      skladPrixods.add(
        SkladPrixod(
          dateTime: DateTime.now().toString(),
          skladItems: [...skladItems],
        ),
      );
      notifyListeners();
    }
  }

  void clearSkladItems() {
    skladItems.clear();
  }

//rasxod
  TextEditingController clientNameController = TextEditingController();
  String? selectedSkladItem;
  String? raxsodDate;
  TextEditingController quantityRasxodController = TextEditingController();
  TextEditingController priceRasxodController = TextEditingController();
  TextEditingController priceSumOfRasxodController = TextEditingController();

  void clearRasxodFields() {
    // return;
    clientNameController.clear();
    selectedSkladItem = null;
    raxsodDate = null;
    quantityRasxodController.clear();
    priceRasxodController.clear();
    priceSumOfRasxodController.clear();
  }
}
