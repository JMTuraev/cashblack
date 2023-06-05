import 'package:intl/intl.dart';

extension MyIterable<E> on Iterable<E> {
  Iterable<E> sortedBy(Comparable key(E e)) =>
      toList()..sort((a, b) => key(a).compareTo(key(b)));

  Iterable<E> reversedBy(Comparable key(E e)) =>
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

  String removeCommas() {
    return replaceAll(RegExp(r'\,+'), '');
  }

  String removeForPhone() {
    return replaceAll(RegExp(r'[+()]'), '');
  }

  String cardHiddenFormatter() {
    return replaceAllMapped(
      RegExp(r'(\d{4})(\d{2})(\d{2})(\d{4})(\d{4})'),
      (m) => '${m[1]} ${m[2]}** **** ${m[5]}',
    );
  }

  String getLocaleDateTime() {
    // final DateFormat formatter = DateFormat('dd MMMM yyyy, hh:mm');
    final DateFormat formatter = DateFormat('dd MMMM yyyy,').add_Hm();

    return formatter.format(DateTime.parse(this));
  }

  String getDateForQuery() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    return formatter.format(DateTime.parse(this));
  }

  String getLocaleDate() {
    final DateFormat formatter = DateFormat('dd MMMM yyyy');

    return formatter.format(DateTime.parse(this));
  }

  String getLocaleDateWithoutYear() {
    final DateFormat formatter = DateFormat('dd.MM');

    return formatter.format(DateTime.parse(this));
  }

  String getLocaleDateWithYear() {
    final DateFormat formatter = DateFormat('dd.MM.yyyy');

    return formatter.format(DateTime.parse(this));
  }

  String getLocaleDateWithoutYearWithMont() {
    final DateFormat formatter = DateFormat('dd-MMMM');

    return formatter.format(DateTime.parse(this));
  }

  String getAmountInSum() {
    return NumberFormat.simpleCurrency(
      name: 'сум',
      locale: 'ru_RU',
      decimalDigits: 0,
    ).format(double.parse(this.removeCommas()));
  }

  String getFormattedNumber() {
    return NumberFormat.simpleCurrency(
      name: '',
      locale: 'ru_RU',
      decimalDigits: 0,
    ).format(double.parse(this));
  }
}
