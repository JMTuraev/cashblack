import 'package:flutter/cupertino.dart';

import '../../core/api/business_api.dart';
import '../../domain/models/owner/report_cashback.dart';
import '../../domain/models/owner/report_cashback_client.dart';

class BusinessStatisticsViewModel extends ChangeNotifier {
  final BusinessApi _businessApi = BusinessApi();

  bool isLoading = false;
  bool isClientsLoading = false;
  List<ReportCashback> cashbackAndWithdraws = [];
  List<InlineCashbackAndWithdraw> mergedList = [];

  List<ReportCashbackClient> clients = [];
  List<ReportCashbackClient> filteredClients = [];

  List shopIdsForHideOrShow = [];
  double allCashbackSums = 0;
  double allWithdrawSums = 0;
  double allTotalSums = 0;

  Future<void> getStats(int shopId) async {
    isLoading = true;
    mergedList.clear();
    allCashbackSums = 0;
    allWithdrawSums = 0;
    allTotalSums = 0;
    print(shopId);
    // shopIdsForHideOrShow.clear(); // `todo` kerakmi bu?
    cashbackAndWithdraws = await _businessApi.getCashbackStatistics();

    // mergedList = cashbackAndWithdraws.first.cashback;
    // cashbackAndWithdraws.forEach((element) {
    //   mergedList.addAll(element.cashback);
    // });

    for (final element in cashbackAndWithdraws) {
      mergedList
        ..addAll(element.withdraw)
        ..addAll(element.cashback);

      // allCashbackSums += double.parse(element.cashbackSum.toString());
      // allWithdrawSums += double.parse(element.withdrawSum.toString());
      for (final element in element.cashback) {
        if (element.shopId == shopId) {
          allTotalSums += double.parse(element.totalPrice.toString());
        }
      }
      for (final element in element.cashback) {
        if (element.shopId == shopId) {
          allCashbackSums += double.parse(element.amount.toString());
        }
      }
      for (final element in element.withdraw) {
        if (element.shopId == shopId) {
          allWithdrawSums += double.parse(element.amount.toString());
        }
      }

      for (final el in element.cashback) {
        shopIdsForHideOrShow.add(el.shopId);
      }
    }
    print('all total shums $allTotalSums');
    // print(shopIdsForHideOrShow);

    mergedList.sort(
      (a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)),
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> getClients() async {
    isClientsLoading = true;
    clients = await _businessApi.getCashbackStatisticsByClient();
    filteredClients = [...clients];
    isClientsLoading = false;
    notifyListeners();
  }
}
