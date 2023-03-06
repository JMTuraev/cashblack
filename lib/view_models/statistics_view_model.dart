import 'package:flutter/material.dart';

import '../core/api/client.dart';
import '../domain/models/sum_cashback.dart';
import '../domain/models/sum_stat.dart';

class StatisticsViewModel extends ChangeNotifier {
  final Client _client = Client();

  late Future<List<SumStat>> sumStats;
  late var clients;
  double cashbackSum = 0;
  int withdrawSum = 0;
  int priceSum = 0;

  Future<List<SumStat>> getSumStats({
    required String start,
    required String end,
  }) async {
    var sumStats = _client.getSumStatistics(start: start, end: end);
    var sumStat = await sumStats;
    var _cashbackList = sumStat.where((element) => !element.isWithdraw);
    var _withdrawList = sumStat.where((element) => element.isWithdraw);
    cashbackSum = 0;
    withdrawSum = 0;
    priceSum = 0;
    for (var element in _cashbackList) {
      priceSum += element.price;
    }
    for (var element in _cashbackList) {
      cashbackSum += element.cashback;
    }
    for (var element in _withdrawList) {
      withdrawSum += element.price;
    }

    notifyListeners();
    return sumStats;
  }

  Future<List<SumCashback>> getCashbackStats() async {
    var cashbackStatistics = _client.getCashbackStatistics();
    // notifyListeners();
    return clients = await cashbackStatistics;
  }
}
