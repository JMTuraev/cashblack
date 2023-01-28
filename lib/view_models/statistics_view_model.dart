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
    return sumStats = _client.getSumStatistics(start: start, end: end);
  }

  Future<List<SumCashback>> getCashbackStats() async {
    return _client.getCashbackStatistics();
  }
}
