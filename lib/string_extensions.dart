import 'package:intl/intl.dart';

extension MyIterable<E> on Iterable<E> {
  Iterable<E> sortedBy(Comparable Function(E e) key) =>
      toList()..sort((a, b) => key(a).compareTo(key(b)));

  Iterable<E> reversedBy(Comparable Function(E e) key) =>
      toList()..sort((a, b) => key(b).compareTo(key(a)));
}

extension StringExtensions on String {
  String phoneFormatterForCall() {
    return removeWhitespace().removeForPhone().replaceAllMapped(
          RegExp(r'(\d{3})(\d{2})(\d{3})(\d{2})(\d+)'),
          (m) => '+${m[1]}${m[2]}${m[3]}${m[4]}${m[5]}',
        );
  }

  String phoneFormatter() {
    return removeWhitespace().removeForPhone().replaceAllMapped(
          RegExp(r'(\d{3})(\d{2})(\d{3})(\d{2})(\d+)'),
          (m) => '+(${m[1]}) ${m[2]} ${m[3]} ${m[4]} ${m[5]}',
        );
  }

  String phoneHiddenFormatter() {
    return removeWhitespace().removeForPhone().replaceAllMapped(
          RegExp(r'(\d{3})(\d{2})(\d{3})(\d{2})(\d+)'),
          (m) => '+(${m[1]}) ${m[2]} *** ** ${m[5]}',
        );
  }

  String cardFormatter() {
    return replaceAllMapped(
      RegExp(r'(\d{4})(\d{4})(\d{4})(\d{4})'),
      (m) => '${m[1]} ${m[2]} ${m[3]} ${m[4]}',
    );
  }

  String removeWhitespace() {
    return replaceAll(RegExp(r'\s+'), '');
  }

  String removeAllSymbols() {
    return replaceAll(RegExp(r'[^\d]+'), '');
  }

  String removeCommas() {
    return replaceAll(RegExp(r'\,+'), '');
  }

  String removeForPhone() {
    return replaceAll(RegExp('[+()]'), '');
  }

  String cardHiddenFormatter() {
    return replaceAllMapped(
      RegExp(r'(\d{4})(\d{2})(\d{2})(\d{4})(\d{4})'),
      (m) => '${m[1]} ${m[2]}** **** ${m[5]}',
    );
  }

  String getLocaleDateTime({int? addingHours}) {
    // final DateFormat formatter = DateFormat('dd MMMM yyyy, hh:mm');
    final formatter = DateFormat('dd MMMM yyyy,').add_Hm();

    return addingHours == null
        ? formatter.format(DateTime.parse(this))
        : formatter
            .format(DateTime.parse(this).add(Duration(hours: addingHours)));
  }

  String getDateForQuery() {
    final formatter = DateFormat('yyyy-MM-dd');

    return formatter.format(DateTime.parse(this));
  }

  String getLocaleDate() {
    final formatter = DateFormat('dd MMMM yyyy');

    return formatter.format(DateTime.parse(this));
  }

  String getLocaleDateWithoutYear() {
    final formatter = DateFormat('dd.MM');

    return formatter.format(DateTime.parse(this));
  }

  String getLocaleDateWithYear() {
    final formatter = DateFormat('dd.MM.yyyy');

    return formatter.format(DateTime.parse(this));
  }

  String getLocaleDateWithoutYearWithMont() {
    final formatter = DateFormat('dd-MMMM');

    return formatter.format(DateTime.parse(this));
  }

  String getAmountInSum() {
    return NumberFormat.simpleCurrency(
      name: 'сум',
      locale: 'ru_RU',
      decimalDigits: 0,
    ).format(double.parse(removeCommas().removeWhitespace()));
  }

  String getFormattedNumber() {
    return NumberFormat.simpleCurrency(
      name: '',
      locale: 'ru_RU',
      decimalDigits: 0,
    ).format(double.parse(this)).trim();
  }

  String kMBgenerator() {
    final num = double.parse(this);
    if (num > 999 && num < 99999) {
      return '${(num / 1000).toStringAsFixed(1)} тыс';
    } else if (num > 99999 && num < 999999) {
      return '${(num / 1000).toStringAsFixed(0)} тыс';
    } else if (num > 999999 && num < 999999999) {
      return '${(num / 1000000).toStringAsFixed(1)} млн';
    } else if (num > 999999999) {
      return '${(num / 1000000000).toStringAsFixed(1)} млрд';
    } else {
      return num.toString();
    }
  }
}
