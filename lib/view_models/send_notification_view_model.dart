import 'dart:io';

import 'package:flutter/material.dart';

import '../core/api/client.dart';
import '../domain/models/sent_notification.dart';

class SendNotificationViewModel extends ChangeNotifier {
  final Client _client = Client();

  Future<void> send(File file, String title, String content) async {
    await _client.sendNotification(title, content, file);
  }

  Future<List<SentNotification>> getNotifications() async {
    return _client.getSentNotifications();
  }

  Future<String> getNotificationPrice() async {
    return _client.getNotificationPrice();
  }
}
