import 'dart:io';

import 'package:flutter/material.dart';

import '../core/api/client.dart';
import '../domain/models/sent_notification.dart';

class SendNotificationViewModel extends ChangeNotifier {
  final Client _client = Client();

  String notificationPrice = '';
  bool isLoading = false;

  Future<void> send(
      // File file,
      String title,
      String content) async {
    isLoading = true;
    notifyListeners();
    await _client.sendNotification(
      title, content,
      // file
    );
    isLoading = false;
    notifyListeners();
  }

  Future<List<SentNotification>> getNotifications() async {
    return _client.getSentNotifications();
  }

  Future<String> getNotificationPrice() async {
    notificationPrice = await _client.getNotificationPrice();
    return notificationPrice;
  }
}
