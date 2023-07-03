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
  List<InlineCashback> mergedList = [];

  List<ReportCashbackClient> clients = [];

  Future<void> getStats() async {
    isLoading = true;
    cashbackAndWithdraws = await _businessApi.getCashbackStatistics();
    mergedList = cashbackAndWithdraws.first.cashback;
    // cashbackAndWithdraws.forEach((element) {
    //   mergedList.addAll(element.cashback);
    // });
    for (final element in cashbackAndWithdraws.first.withdraw) {
      mergedList.add(
        InlineCashback(
          type: element.type,
          companyName: element.companyName,
          sellerId: element.sellerId,
          sellerName: element.sellerName,
          sellerPhone: element.sellerPhone,
          sellerType: element.sellerType,
          shopId: element.shopId,
          shopName: element.shopName,
          percent: '-1',
          totalPrice: '-1',
          amount: element.amount,
          date: element.date,
          clientId: element.clientId,
          clientName: element.clientName,
          clientPhone: element.clientPhone,
        ),
      );
    }
    print(mergedList.length);
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
