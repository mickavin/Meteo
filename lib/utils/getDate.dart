import 'package:intl/intl.dart';

String capitalize(String word) {
  return "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}";
}

String getDate(int timestamp){
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final tomorrow = DateTime(now.year, now.month, now.day + 1);
  final datetimeMeteo = DateTime.fromMillisecondsSinceEpoch(timestamp*1000);
  final aDate = DateTime(datetimeMeteo.year, datetimeMeteo.month, datetimeMeteo.day);
  if(aDate == today) {
    return "Aujourdhui";
  } else if (aDate == tomorrow) {
    return "Demain";
  } else {
    return capitalize(DateFormat('EEEE d', 'fr').format(datetimeMeteo));
  };
}