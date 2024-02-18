import 'package:flutter/cupertino.dart';

import '../../core/api/business_api.dart';
import '../../domain/models/owner/notification_price.dart';
import '../../domain/models/owner/report_cashback.dart';
import '../../domain/models/owner/report_cashback_client.dart';

class BusinessStatisticsViewModel extends ChangeNotifier {
  final BusinessApi _businessApi = BusinessApi();

  bool isLoading = false;
  bool isClientsLoading = false;
  List<ReportCashback> cashbackAndWithdraws = [];
  List<InlineCashbackAndWithdraw> mergedList = [];

  List<ReportCashbackClient> clients = [];

  Future<void> getStats() async {
    isLoading = true;
    cashbackAndWithdraws = await _businessApi.getCashbackStatistics();
    // mergedList = cashbackAndWithdraws.first.cashback;
    // cashbackAndWithdraws.forEach((element) {
    //   mergedList.addAll(element.cashback);
    // });

    cashbackAndWithdraws.forEach((element) {
      mergedList
        ..addAll(element.withdraw)
        ..addAll(element.cashback);
    });

    mergedList.sort(
        (a, b) => DateTime.parse(a.date!).compareTo(DateTime.parse(b.date!)));

    isLoading = false;
    notifyListeners();
  }

  Future<void> getClients() async {
    isClientsLoading = true;
    clients = await _businessApi.getCashbackStatisticsByClient();
    isClientsLoading = false;
    notifyListeners();
  }
}
