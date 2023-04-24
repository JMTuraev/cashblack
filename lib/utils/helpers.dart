import 'package:url_launcher/url_launcher.dart';

mixin Helpers {
  static void toCall(String phone) async {
    Uri url = Uri.parse('tel:$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  static String getLocalImage(String text) {
    String index = text.split('-').last;
    if (text.contains('Акция')) {
      return 'assets/images/notification/ak-$index.png';
    } else if (text.contains('Бонус')) {
      return 'assets/images/notification/bo-$index.png';
    } else if (text.contains('Реклама')) {
      return 'assets/images/notification/re-$index.png';
    }
    return text;
  }

  static void toWeb(String web, String type) async {
    Uri url = Uri.parse(web);
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
}
