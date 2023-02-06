import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/api/client.dart';
import '../domain/models/balance.dart';
import '../domain/models/one_month_statistic.dart';
import '../domain/models/user.dart';
import '../domain/models/worker.dart';
import '../views/business/business_home_view/business_home_view.dart';
import '../views/business/scanner_view/payment_success_view.dart';
import '../views/business/settings_view/payment_verify_view.dart';
import '../widgets/info_alert_widget.dart';

class BusinessHomeViewModel extends ChangeNotifier {
  final Client _client = Client();

  int currentIndex = 0;

  bool isLoading = false;

  void setindex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  late User user;
  // User?   user;
  // List<Balance> balance = [];
  late List<Balance> balance;
  List<Worker> workers = [];
  // List<OneMonthStatistic> oneWeekStatistics = [];

  Future<List<Object>> getFuture() async {
    user = await getProfile();
    balance = await getBalance();

    return [user, balance];
  }

  Future<User> getProfile() async {
    user = await _client.getProfile();
    notifyListeners();
    return user;
  }

  Future<List<OneMonthStatistic>> getStatistics() async {
    return _client.getOneMonthStatistics();
  }

  void onChange(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Future<void> changeName(int userId, String firstName, String lastName) async {
    await _client.changeName(userId, firstName, lastName);
    await getProfile();
    notifyListeners();
  }

  Future<void> createWorker(String userName, String password, String firstName,
      String lastName) async {
    await _client.createWorker(userName, password, firstName, lastName);
    await getWorkers();
    notifyListeners();
  }

  Future<List<Worker>> getWorkers() async {
    return workers = await _client.getWorkers();
  }

  Future<void> switchWorker(int id, bool type) async {
    await _client.switchWorker(id, type);
    print('wor changed to $type');
    await getWorkers();
    notifyListeners();
  }

  Future<List<Balance>> getBalance() async {
    var balance = await _client.getBalance();
    notifyListeners();
    return balance;
  }

  Future<void> paySubscription(BuildContext context, bool type) async {
    isLoading = true;
    notifyListeners();
    // var result = await _client.paySubscription(type);
    // user = await getProfile();
    // balance = await getBalance();
    // isLoading = false;
    // notifyListeners();
    // return result;

    await _client.paySubscription(type).then((value) async {
      user = await getProfile();
      balance = await getBalance();
      if (value == 'Xato') {
        await showCupertinoDialog(
          context: context,
          builder: (context) {
            return const InfoAlertWidget(
              title: 'Ошибка сервера',
            );
          },
        );
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        isLoading = false;
        notifyListeners();
        await Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(
            builder: (context) => const BusinessHomeView(),
          ),
          (route) => false,
        );
      }
    });
  }

  Future<String> cancelSubscription() async {
    var result = await _client.cancelSubscription();
    user = await getProfile();
    balance = await getBalance();
    notifyListeners();
    return result;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final storage = const FlutterSecureStorage();

    // await prefs.remove('isLogged');
    // await storage.delete(key: 'bearer');
    await prefs.clear();
    await storage.deleteAll();
    currentIndex = 0;
    // notifyListeners();
  }

  Future<void> editStore(
    int id,
    int category,
    String name,
    int cashback,
    int province,
    int city,
  ) async {
    await _client.editStore(
      id,
      category,
      name,
      cashback,
      province,
      city,
    );
    await getProfile();
    notifyListeners();
  }

  Future<void> editStoreImage(
    int id,
    File file,
  ) async {
    await _client.editStoreImage(
      id,
      file,
    );
    await getProfile();
    notifyListeners();
  }

  Future<void> enterCardDetails(
    BuildContext context,
    String cardNumber,
    String expireDate,
    String amount,
  ) async {
    isLoading = true;
    notifyListeners();
    var result = _client.enterCardDetails(cardNumber, expireDate, amount).then(
      (value) {
        if (value[0] == 'error_miqdor') {
          showCupertinoDialog(
            context: context,
            builder: (context) {
              return InfoAlertWidget(
                title:
                    'Сумма должен быт больше ${balance.first.balanceShop.subscriptionPrice}',
              );
            },
          );
          isLoading = false;
          notifyListeners();
          return true;
        } else if (value[0] == 'Неправильные входные данные') {
          showCupertinoDialog(
            context: context,
            builder: (context) {
              return const InfoAlertWidget(
                title: 'Неправильные входные данные',
              );
            },
          );
          isLoading = false;
          notifyListeners();
          return true;
        } else if (value[0] == 'Превышен лимит отправки одноразового пароля') {
          showCupertinoDialog(
            context: context,
            builder: (context) {
              return const InfoAlertWidget(
                title: 'Превышен лимит отправки одноразового пароля',
              );
            },
          );
          isLoading = false;
          notifyListeners();
          return true;
        } else if (value[0] == 'xato') {
          showCupertinoDialog(
            context: context,
            builder: (context) {
              return const InfoAlertWidget(
                title: 'Попробуйте позже',
              );
            },
          );
          isLoading = false;
          notifyListeners();
          return true;
        }
        isLoading = false;
        notifyListeners();
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => PaymentVerifyView(
              cardNumber: value[0],
              expireDate: value[1],
              amount: value[2],
              session: value[3],
              phone: value[4],
            ),
          ),
        );
      },
    );
  }

  Future<void> paymentConfirm(
    BuildContext context,
    String cardNumber,
    String expireDate,
    String amount,
    int session,
    String otp,
  ) async {
    isLoading = true;
    notifyListeners();
    await _client
        .paymentConfirm(cardNumber, expireDate, amount, session, otp)
        .then(
      (value) {
        if (value == 'xato') {
          showCupertinoDialog(
            context: context,
            builder: (context) {
              return const InfoAlertWidget(
                title: 'Неправильные входные данные или попробуйте позже',
              );
            },
          );
          isLoading = false;
          notifyListeners();
          return true;
        }
        isLoading = false;
        notifyListeners();
        return Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(
            builder: (context) => const PaymentSuccessView(
              title: 'Счет пополнено',
            ),
          ),
          (route) => false,
        );
      },
    );
  }
}
