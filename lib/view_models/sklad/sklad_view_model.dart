import 'package:flutter/material.dart';

import '../../core/api/warehouse_api.dart';
import '../../domain/models/services/sklad_item_status.dart';
import '../../domain/models/services/warehouse.dart';
import '../../domain/models/services/warehouse_category.dart';
import '../../domain/models/services/warehouse_item.dart';
import '../../domain/models/services/warehouse_prixod.dart';
import '../../domain/models/services/warehouse_prixod_create.dart';
import '../../domain/models/services/warehouse_provider.dart';
import '../../domain/models/services/warehouse_unit.dart';
import '../../string_extensions.dart';

class SkladViewModel extends ChangeNotifier {
  final WarehousesApi _warehousesApi = WarehousesApi();

  //units
  List<WarehouseUnit> warehouseUnits = [];
  bool isGettingWarehouseUnits = false;
  Future<void> getWarehouseUnits() async {
    isGettingWarehouseUnits = true;
    notifyListeners();
    warehouseUnits = await _warehousesApi.getWarehouseUnits();
    isGettingWarehouseUnits = false;
    notifyListeners();
  }

  //skladlar
  List<Warehouse> warehouses = [];
  bool isGettingWarehouses = false;
  bool isCreatingWarehouse = false;
  TextEditingController warehouseNameController = TextEditingController();
  TextEditingController warehouseAddressController = TextEditingController();
  String? selectedWarehouseShop;

  Future<bool> createWarehouse() async {
    isCreatingWarehouse = true;
    notifyListeners();

    final res = await _warehousesApi.createWarehouse(
      name: warehouseNameController.text.trim(),
      address: warehouseAddressController.text.trim(),
      shopId: selectedWarehouseShop.toString(),
    );
    isCreatingWarehouse = false;
    notifyListeners();
    return res;
  }

  Future<void> getWarehouses() async {
    isGettingWarehouses = true;
    notifyListeners();

    warehouses = await _warehousesApi.getWarehouses();
    isGettingWarehouses = false;
    notifyListeners();
  }

  void clearWarehouseCreating() {
    warehouseNameController.clear();
    warehouseAddressController.clear();
    selectedWarehouseShop = null;
  }

  //providerlar
  List<WarehouseProvider> warehouseProviders = [];
  bool isGettingWarehouseProviders = false;
  bool isCreatingWarehouseProvider = false;
  TextEditingController warehouseProviderNameController =
      TextEditingController();
  TextEditingController warehouseProviderEmailController =
      TextEditingController();
  TextEditingController warehouseProviderPhoneController =
      TextEditingController();

  Future<bool> createWarehouseProvider() async {
    isCreatingWarehouseProvider = true;
    notifyListeners();
    final res = await _warehousesApi.createWarehouseProvider(
      name: warehouseProviderNameController.text.trim(),
      email: warehouseProviderEmailController.text.trim(),
      phone: warehouseProviderPhoneController.text
          .removeForPhone()
          .removeWhitespace(),
    );
    isCreatingWarehouseProvider = false;
    notifyListeners();
    return res;
  }

  Future<void> getWarehouseProviders() async {
    isGettingWarehouseProviders = true;
    notifyListeners();

    warehouseProviders = await _warehousesApi.getWarehouseProviders();
    isGettingWarehouseProviders = false;
    notifyListeners();
  }

  void clearWarehouseProviderCreating() {
    warehouseProviderNameController.clear();
    warehouseProviderEmailController.clear();
    warehouseProviderPhoneController.clear();
  }

  // categories
  List<WarehouseCategory> warehouseCategories = [];
  bool isGettingWarehouseCategorys = false;
  bool isCreatingWarehouseCategory = false;
  TextEditingController warehouseCategoryNameController =
      TextEditingController();
  TextEditingController warehouseCategoryTitleController =
      TextEditingController();
  // String? selectedWarehouseCategoryParentId;

  Future<bool> createWarehouseCategory() async {
    isCreatingWarehouseCategory = true;
    notifyListeners();
    final res = await _warehousesApi.createWarehouseCategory(
      name: warehouseCategoryNameController.text.trim(),
      title: warehouseCategoryTitleController.text.trim(),
      // parentId: selectedWarehouseCategoryParentId.toString(),
    );
    isCreatingWarehouseCategory = false;
    notifyListeners();
    return res;
  }

  Future<void> getWarehouseCategories() async {
    isGettingWarehouseCategorys = true;
    notifyListeners();
    warehouseCategories = await _warehousesApi.getWarehouseCategories();
    isGettingWarehouseCategorys = false;
    notifyListeners();
  }

  void clearWarehouseCategoryCreating() {
    warehouseCategoryNameController.clear();
    warehouseCategoryTitleController.clear();
    // selectedWarehouseCategoryParentId = null;
  }

  //nomenklatura
  List<WarehouseItem> warehouseItems = [];
  bool isGettingWarehouseItems = false;
  bool isCreatingWarehouseItem = false;
  String? selectedWarehouseItemCategoryId;
  TextEditingController warehouseItemNameController = TextEditingController();
  TextEditingController warehouseItemBarcodeController =
      TextEditingController();
  // TextEditingController warehouseItemRemarkController =
  //     TextEditingController();
  TextEditingController warehouseItemLowerController = TextEditingController();

  Future<bool> createWarehouseItem() async {
    isCreatingWarehouseItem = true;
    notifyListeners();
    final res = await _warehousesApi.createWarehouseItem(
      categoryId: selectedWarehouseItemCategoryId.toString(),
      barCode: warehouseItemBarcodeController.text,
      name: warehouseItemNameController.text,
      lower: warehouseItemLowerController.text,
    );
    isCreatingWarehouseItem = false;
    notifyListeners();
    return res;
  }

  Future<void> getWarehouseItems() async {
    isGettingWarehouseItems = true;
    notifyListeners();

    warehouseItems = await _warehousesApi.getWarehouseItems();
    isGettingWarehouseItems = false;
    notifyListeners();
  }

  void clearWarehouseItemCreating() {
    warehouseItemNameController.clear();
    warehouseItemBarcodeController.clear();
    warehouseItemLowerController.clear();
    selectedWarehouseItemCategoryId = null;
  }

  //prixod
  String? selectedPrixodProductItem;
  String? selectedPrixodUnit;
  String? selectedPrixodCategory;
  String? selectedPrixodWarehouse;
  // String? selectedSubCategory;
  String? prixodCreatedDate;
  TextEditingController prixodQuantityController = TextEditingController();
  TextEditingController prixodPriceBuyController = TextEditingController();
  TextEditingController prixodPriceSellController = TextEditingController();
  TextEditingController prixodPriceSumOfAllController = TextEditingController();
  TextEditingController prixodSerialNumberController = TextEditingController();
  // TextEditingController partyNumberController = TextEditingController();
  String? selectedPrixodProvider;
  // String? selectedSkladItemStatus;
  // TextEditingController minQuantityController = TextEditingController();

  void clearFields() {
    selectedPrixodProductItem = null;
    selectedPrixodUnit = null;
    selectedPrixodCategory = null;
    selectedPrixodWarehouse = null;
    prixodCreatedDate = null;
    prixodQuantityController.clear();
    prixodPriceBuyController.clear();
    prixodPriceSellController.clear();
    prixodPriceSumOfAllController.clear();
    prixodSerialNumberController.clear();
    selectedPrixodProvider = null;
  }

  List<SkladItemStatus> skladItemStatuses = [
    SkladItemStatus(value: '1', name: 'Есть в наличии'),
    SkladItemStatus(value: '2', name: 'В пути'),
    SkladItemStatus(value: '3', name: 'Ожидается'),
  ];

  List<WarehousePrixodCreate> prixodItemsForCreate = [];

  void addToSklad() {
    prixodItemsForCreate.add(
      WarehousePrixodCreate(
        productiId: selectedPrixodProductItem.toString(),
        quantity: prixodQuantityController.text.removeWhitespace(),
        unitId: selectedPrixodUnit.toString(),
        price: prixodPriceBuyController.text.removeWhitespace(),
        priceSell: prixodPriceSellController.text.removeWhitespace(),
      ),
    );
    notifyListeners();
  }

  void addPrixod() {
    // print(skladItems.length);
    // if (skladItems.isEmpty) {
    //   print('object');
    //   return;
    // } else {
    //   skladPrixods.add(
    //     SkladPrixod(
    //       dateTime: DateTime.now().toString(),
    //       skladItems: [...skladItems],
    //     ),
    //   );
    //   notifyListeners();
    // }
  }

  void clearSkladItems() {
    // skladItems.clear();
  }

  WarehousePrixod? warehousePrixodItems;
  bool isGettingWarehousePrixodItems = false;
  Future<void> getWarehousePrixodItems() async {
    isGettingWarehouseUnits = true;
    warehousePrixodItems = await _warehousesApi.getWarehousePrixodItems();
    isGettingWarehousePrixodItems = false;
    notifyListeners();
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
