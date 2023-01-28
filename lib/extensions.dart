import 'package:intl/intl.dart';

extension MyIterable<E> on Iterable<E> {
  Iterable<E> sortedBy(Comparable key(E e)) =>
      toList()..sort((a, b) => key(a).compareTo(key(b)));
}

extension StringExtensions on String {
  String phoneFormatter() {
    return replaceAllMapped(
      RegExp(r'(\d{3})(\d{2})(\d{3})(\d{2})(\d+)'),
      (m) => '+(${m[1]}) ${m[2]} ${m[3]} ${m[4]} ${m[5]}',
    );
  }

  String cardFormatter() {
    return replaceAllMapped(
      RegExp(r'(\d{4})(\d{4})(\d{4})(\d{4})'),
      (m) => '${m[1]} ${m[2]} ${m[3]} ${m[4]}',
    );
  }

  String removeWhitespaces() {
    return replaceAll(RegExp(r'\s+'), '');
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
}
