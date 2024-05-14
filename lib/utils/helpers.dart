import 'package:url_launcher/url_launcher.dart';

import '../domain/models/owner/business_license.dart';
import '../string_extensions.dart';

mixin Helpers {
  // static bool subsctibedChecker(BusinessProfile profile) {
  //   print(profile.balance);
  //   return profile.licence.isNotEmpty &&
  //       DateTime.parse(
  //         profile.licence.first.endAt.getDateForQuery(),
  //       ).isAfter(DateTime.now());
  // }

  static bool subsctibedChecker(List<BusinessLicense> licence) {
    return licence.isNotEmpty &&
        DateTime.parse(
          licence.first.endAt.getDateForQuery(),
        ).isAfter(DateTime.now());
  }

  static Future<void> toCall(String phone) async {
    final url = Uri.parse('tel:$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  static String getLocalImage(String text) {
    final index = text.split('-').last;
    if (text.contains('Акция')) {
      return 'assets/images/notification/ak-$index.png';
    } else if (text.contains('Бонус')) {
      return 'assets/images/notification/bo-$index.png';
    } else if (text.contains('Реклама')) {
      return 'assets/images/notification/re-$index.png';
    }
    return text;
  }

  static Future<void> toWeb(String web, String type) async {
    final url = Uri.parse(web);
    if (await canLaunchUrl(url)) {
      if (type == 'telegram' || type == 'instagram') {
        // await launch(
        //   web,
        //   forceWebView: false,
        // );
        if (type == 'instagram') {
          await launch('https://$web', universalLinksOnly: true);
        } else {
          await launchUrl(
            mode: LaunchMode.externalApplication,
            Uri.parse('https://$web'),
          );
        }
      } else {
        await launchUrl(url);
      }
    } else {
      if (type == 'telegram' || type == 'instagram') {
        // await launch(
        //   'https://$web}',
        //   forceWebView: false,
        // );
        if (type == 'instagram') {
          await launch('https://$web', universalLinksOnly: true);
        } else {
          await launchUrl(
            mode: LaunchMode.externalApplication,
            Uri.parse('https://$web'),
          );
        }
      } else {
        await launchUrl(
          Uri.parse('https://$web'),
        );
      }
    }
  }

  static Future<void> toMail() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map(
            (MapEntry<String, String> e) =>
                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
          )
          .join('&');
    }

    final emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'jafaralituraev@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Удалить аккаунт',
        'body': 'Удалить аккаунт',
      }),
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {}
  }
}
