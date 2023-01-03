import 'package:flutter/material.dart';

import '../core/api/client.dart';
import '../domain/models/sum_stat.dart';

class StatisticsViewModel extends ChangeNotifier {
  final Client _client = Client();

  Future<List<SumStat>> getSumStats() async {
    return _client.getSumStatistics();
  }
}
