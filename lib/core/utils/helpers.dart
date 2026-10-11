import 'package:intl/intl.dart';
String formatTaka(int amount) {
  final f = NumberFormat.currency(symbol: '৳ ', decimalDigits: 0, locale: 'bn_BD');
  return f.format(amount);
}