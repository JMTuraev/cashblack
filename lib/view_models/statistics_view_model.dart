import 'package:flutter/material.dart';

import '../core/api/client.dart';
import '../domain/models/sum_cashback.dart';
import '../domain/models/sum_stat.dart';

class StatisticsViewModel extends ChangeNotifier {
  final Client _client = Client();

  List<SumStat> sumStats = [];

  Future<List<SumStat>> getSumStats({
    String start = '2022-01-01',
    String end = '2024-12-12',
  }) async {
    sumStats = await _client.getSumStatistics(start: start, end: end);
    return sumStats;
  }

  Future<List<SumCashback>> getCashbackStats() async {
    return _client.getCashbackStatistics();
  }
}
