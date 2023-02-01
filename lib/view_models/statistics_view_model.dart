import 'package:flutter/material.dart';

import '../core/api/client.dart';
import '../domain/models/sum_cashback.dart';
import '../domain/models/sum_stat.dart';

class StatisticsViewModel extends ChangeNotifier {
  final Client _client = Client();

  late Future<List<SumStat>> sumStats;

  Future<List<SumStat>> getSumStats({
    required String start,
    required String end,
  }) async {
    var sumStats = _client.getSumStatistics(start: start, end: end);
    // notifyListeners();
    return sumStats;
  }

  Future<List<SumCashback>> getCashbackStats() async {
    var cashbackStatistics = _client.getCashbackStatistics();
    // notifyListeners();
    return cashbackStatistics;
  }
}
