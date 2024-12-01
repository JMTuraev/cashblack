import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/api/warehouse_api.dart';
import '../../domain/models/services/sklad_item_status.dart';
import '../../domain/models/services/sklad_prixod.dart';
import '../../domain/models/services/sklad_rasxod.dart';
import '../../domain/models/services/sklad_remaining.dart';
import '../../domain/models/services/warehouse.dart';
import '../../domain/models/services/warehouse_category.dart';
import '../../domain/models/services/warehouse_item.dart';
import '../../domain/models/services/warehouse_item_for_kassa.dart';
import '../../domain/models/services/warehouse_prixod.dart';
import '../../domain/models/services/warehouse_prixod_create.dart';
import '../../domain/models/services/warehouse_provider.dart';
import '../../domain/models/services/warehouse_rasxod_create.dart';
import '../../domain/models/services/warehouse_shop.dart';
import '../../domain/models/services/warehouse_unit.dart';
import '../../string_extensions.dart';
import '../business/business_dashboard_view_model.dart';

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

  Future<bool> createWarehouse(BuildContext context) async {
    isCreatingWarehouse = true;
    notifyListeners();

    // final res = await _warehousesApi.createWarehouse(
    //   name: warehouseNameController.text.trim(),
    //   address: warehouseAddressController.text.trim(),
    //   shopId: selectedWarehouseShop.toString(),
    // );
    inspect(context.read<BusinessDashboardViewModel>().businessShops);
    warehouses.add(
      Warehouse(
        id: Random().nextInt(100) * 99,
        name: warehouseNameController.text.trim(),
        address: warehouseAddressController.text.trim(),
        shop: WarehouseShop(
          id: context
              .read<BusinessDashboardViewModel>()
              .businessShops!
              .where((x) => x.id.toString() == selectedWarehouseShop.toString())
              .first
              .id,
          name: context
              .read<BusinessDashboardViewModel>()
              .businessShops!
              .where((x) => x.id.toString() == selectedWarehouseShop.toString())
              .first
              .name,
        ),
      ),
    );
    isCreatingWarehouse = false;
    notifyListeners();
    // return res;
    return true;
  }

  Future<void> getWarehouses() async {
    isGettingWarehouses = true;
    notifyListeners();

    // warehouses = await _warehousesApi.getWarehouses();
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
    // final res = await _warehousesApi.createWarehouseProvider(
    //   name: warehouseProviderNameController.text.trim(),
    //   email: warehouseProviderEmailController.text.trim(),
    //   phone: warehouseProviderPhoneController.text
    //       .removeForPhone()
    //       .removeWhitespace(),
    // );
    warehouseProviders.add(
      WarehouseProvider(
        id: Random().nextInt(100) * 99,
        name: warehouseProviderNameController.text.trim(),
        email: warehouseProviderEmailController.text.trim(),
        phone: warehouseProviderPhoneController.text
            .removeForPhone()
            .removeWhitespace(),
        companyId: Random().nextInt(100) * 99,
      ),
    );
    isCreatingWarehouseProvider = false;
    notifyListeners();
    // return res;
    return true;
  }

  Future<void> getWarehouseProviders() async {
    isGettingWarehouseProviders = true;
    notifyListeners();
    // warehouseProviders = await _warehousesApi.getWarehouseProviders();
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
    warehouseCategories.add(
      WarehouseCategory(
        id: Random().nextInt(100) * 99,
        name: warehouseCategoryNameController.text.trim(),
        // title: warehouseCategoryTitleController.text.trim(),
      ),
    );
    // final res = await _warehousesApi.createWarehouseCategory(
    //   name: warehouseCategoryNameController.text.trim(),
    //   title: warehouseCategoryTitleController.text.trim(),
    //   // parentId: selectedWarehouseCategoryParentId.toString(),
    // );
    isCreatingWarehouseCategory = false;
    notifyListeners();
    // return res;
    return true;
  }

  Future<void> getWarehouseCategories() async {
    isGettingWarehouseCategorys = true;
    notifyListeners();
    // warehouseCategories = await _warehousesApi.getWarehouseCategories();
    isGettingWarehouseCategorys = false;
    notifyListeners();
  }

  void clearWarehouseCategoryCreating() {
    warehouseCategoryNameController.clear();
    warehouseCategoryTitleController.clear();
    // selectedWarehouseCategoryParentId = null;
  }

  //nomenklatura / item
  List<WarehouseItem> warehouseItems = [];
  bool isGettingWarehouseItems = false;
  bool isCreatingWarehouseItem = false;
  String? selectedWarehouseItemCategoryId;
  String? selectedWarehouseItemUnitId;
  TextEditingController warehouseItemNameController = TextEditingController();
  TextEditingController warehouseItemBarcodeController =
      TextEditingController();
  // TextEditingController warehouseItemRemarkController =
  //     TextEditingController();
  TextEditingController warehouseItemTagsController = TextEditingController();
  TextEditingController warehouseItemLowerController = TextEditingController();

  void randomBarcode() {
    final random = Random();
    const min = 100000000;
    const max = 999999999;
    const min2 = 1000;
    const max2 = 9999;
    //  min + random.nextInt(max - min + 1);
    clearWarehouseItemCreating();
    warehouseItemBarcodeController.text =
        // Random().nextInt(999999999).toString() +
        //     Random().nextInt(9999).toString();
        (min + random.nextInt(max - min + 1)).toString() +
            (min2 + random.nextInt(max2 - min2 + 1)).toString();
    notifyListeners();
  }

  List<WarehouseItemForKassa> tempItems = [
    WarehouseItemForKassa(
      id: 0,
      name: 'IPhone 14',
      unit: WarehouseUnit(id: -1, name: 'шт', title: 'штук'),
      category: WarehouseCategory(id: -1, name: 'Техника'),
      barCode: '1234567890',
      code: -1,
      count: 1,
      tags: ['128 GB'],
      price: 11000000,
      addition: 0,
      totalPrice: 11000000,
    ),
    WarehouseItemForKassa(
      id: 1,
      name: 'IPhone 14',
      unit: WarehouseUnit(id: -1, name: 'шт', title: 'штук'),
      category: WarehouseCategory(id: -1, name: 'Техника'),
      barCode: '1234567890',
      code: -1,
      count: 1,
      tags: ['256 GB'],
      price: 13000000,
      addition: 0,
      totalPrice: 13000000,
    ),
    WarehouseItemForKassa(
      id: 2,
      name: 'IPhone 13',
      unit: WarehouseUnit(id: -1, name: 'шт', title: 'штук'),
      category: WarehouseCategory(id: -1, name: 'Техника'),
      barCode: '1234567890',
      code: -1,
      count: 1,
      tags: ['128 GB'],
      price: 10000000,
      addition: 0,
      totalPrice: 10000000,
    ),
    WarehouseItemForKassa(
      id: 3,
      name: 'IPhone 13',
      unit: WarehouseUnit(id: -1, name: 'шт', title: 'штук'),
      category: WarehouseCategory(id: -1, name: 'Техника'),
      barCode: '1234567890',
      code: -1,
      count: 1,
      tags: ['256 GB'],
      price: 12000000,
      addition: 0,
      totalPrice: 12000000,
    ),
    WarehouseItemForKassa(
      id: 4,
      name: 'IPad 10',
      unit: WarehouseUnit(id: -1, name: 'шт', title: 'штук'),
      category: WarehouseCategory(id: -1, name: 'Техника'),
      barCode: '1234567890',
      code: -1,
      count: 1,
      tags: ['128 GB', 'Wifi'],
      price: 7000000,
      addition: 0,
      totalPrice: 7000000,
    ),
    WarehouseItemForKassa(
      id: 5,
      name: 'IPad 10',
      unit: WarehouseUnit(id: -1, name: 'шт', title: 'штук'),
      category: WarehouseCategory(id: -1, name: 'Техника'),
      barCode: '1234567890',
      code: -1,
      count: 1,
      tags: ['256 GB', '4G'],
      price: 9000000,
      addition: 0,
      totalPrice: 9000000,
    ),
  ];

  void tempItemsReset() {
    for (final element in tempItems) {
      element.count = 1;
    }
  }

  List<WarehouseItemForKassa> tempItemsForSale = [];
  double tempTotalSum = 0;
  TextEditingController tempCounterController = TextEditingController(text: '');
  TextEditingController tempAdditionController =
      TextEditingController(text: '0');

  List<WarehouseItem> tempKassaItem = [];

  Future<bool> createWarehouseItem() async {
    isCreatingWarehouseItem = true;
    notifyListeners();
    // final res = await _warehousesApi.createWarehouseItem(
    //   categoryId: selectedWarehouseItemCategoryId.toString(),
    //   barCode: warehouseItemBarcodeController.text,
    //   name: warehouseItemNameController.text,
    //   lower: warehouseItemLowerController.text,
    // );
    warehouseItems.add(
      WarehouseItem(
        id: Random().nextInt(100) * 99,
        name: warehouseItemNameController.text,
        category: warehouseCategories
            .where(
              (element) =>
                  element.id.toString() == selectedWarehouseItemCategoryId,
            )
            .first,
        unit: warehouseUnits
            .where(
              (element) => element.id.toString() == selectedWarehouseItemUnitId,
            )
            .first,
        barCode: warehouseItemBarcodeController.text,
        code: int.parse(warehouseItemBarcodeController.text),
        // lower: int.parse(warehouseItemLowerController.text.removeWhitespace()),
        lower: -1,
        tags: warehouseItemTagsController.text
            .removeWhitespace()
            .split(',')
            .toList(),
      ),
    );
    isCreatingWarehouseItem = false;
    notifyListeners();
    // return res;
    return true;
  }

  Future<void> getWarehouseItems() async {
    isGettingWarehouseItems = true;
    notifyListeners();

    // warehouseItems = await _warehousesApi.getWarehouseItems();
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

  List<SkladPrixod> prixodList = [];

  void addToSklad() {
    prixodItemsForCreate.add(
      WarehousePrixodCreate(
        productiId: selectedPrixodProductItem.toString(),
        quantity: prixodQuantityController.text.removeWhitespace(),
        unitId: selectedPrixodUnit.toString(),
        // unitId: warehouseItems.where((element) => element,),
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
    if (prixodItemsForCreate.isEmpty) {
      print('object');
      return;
    } else {
      prixodList.add(
        SkladPrixod(
          dateTime: DateTime.now().toString(),
          skladItems: [...prixodItemsForCreate],
        ),
      );
      notifyListeners();
    }
  }

  void clearSkladItems() {
    prixodItemsForCreate.clear();
  }

  WarehousePrixod? warehousePrixodItems;
  bool isGettingWarehousePrixodItems = false;
  Future<void> getWarehousePrixodItems() async {
    isGettingWarehouseUnits = true;
    // warehousePrixodItems = await _warehousesApi.getWarehousePrixodItems();
    isGettingWarehousePrixodItems = false;
    notifyListeners();
  }

  //ostatok
  bool isGettingWarehouseRemainings = false;
  List<SkladRemaining> skladRemainings = [];

  void getRemainingItems() {
    print('get itme');
    skladRemainings.clear();
    for (final element in warehouseItems) {
      skladRemainings.add(
        SkladRemaining(
          quantity: 0,
          warehouseItemId: element.id.toString(),
          warehouseItem: element,
        ),
      );
    }

    for (final prixod in prixodList) {
      for (final skladItem in prixod.skladItems) {
        for (final item in skladRemainings) {
          if (item.warehouseItemId == skladItem.productiId) {
            item.quantity += double.parse(skladItem.quantity);
          }
        }
      }
    }

    for (final rasxod in rasxodList) {
      for (final rasxodItem in rasxod.rasxodItems) {
        for (final item in skladRemainings) {
          if (item.warehouseItemId == rasxodItem.warehouseItem.id.toString()) {
            item.quantity -= double.parse(rasxodItem.quantity.toString());
          }
        }
      }
    }
  }

  //rasxod
  TextEditingController clientNameController = TextEditingController();
  String? selectedSkladItem;
  String? raxsodDate;
  TextEditingController quantityRasxodController = TextEditingController();
  TextEditingController priceRasxodController = TextEditingController();
  TextEditingController priceSumOfRasxodController = TextEditingController();

  List<WarehouseRasxodCreate> rasxodItemsForCreate = [];

  List<SkladRasxod> rasxodList = [];

  void clearRasxodFields() {
    // return;
    clientNameController.clear();
    selectedSkladItem = null;
    raxsodDate = null;
    quantityRasxodController.clear();
    priceRasxodController.clear();
    priceSumOfRasxodController.clear();
  }

  void removeFromSklad() {
    rasxodItemsForCreate.add(
      WarehouseRasxodCreate(
        client: clientNameController.text,
        warehouseItem: warehouseItems
            .where(
              (element) => element.id.toString() == selectedSkladItem,
            )
            .first,
        quantity: int.parse(quantityRasxodController.text.removeWhitespace()),
        priceSellSingle: priceRasxodController.text.removeWhitespace(),
        priceSellAll: priceSumOfRasxodController.text.removeWhitespace(),
      ),
    );
    inspect(rasxodItemsForCreate);
    notifyListeners();
  }

  void addRasxod() {
    if (rasxodItemsForCreate.isEmpty) {
      print('object');
      return;
    } else {
      rasxodList.add(
        SkladRasxod(
          dateTime: DateTime.now().toString(),
          rasxodItems: [...rasxodItemsForCreate],
        ),
      );
      notifyListeners();
    }
  }

  void clearSkladRasxods() {
    rasxodItemsForCreate.clear();
  }
}
