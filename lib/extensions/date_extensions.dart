import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  // Formatting
  String format(String pattern) {
    return DateFormat(pattern, 'ru').format(this);
  }

  String get dateOnly => format('dd.MM.yyyy');
  String get timeOnly => format('HH:mm');
  String get dateTime => format('dd.MM.yyyy HH:mm');
  String get fullDateTime => format('dd.MM.yyyy HH:mm:ss');
  String get monthYear => format('MMMM yyyy');
  String get dayMonth => format('dd MMMM');
  String get dayMonthYear => format('dd MMMM yyyy');
  String get weekdayFormat => format('EEEE');
  String get shortWeekday => format('EEE');
  String get monthName => format('MMMM');
  String get shortMonthName => format('MMM');

  // ISO 8601
  String get iso8601 => toIso8601String();

  // Comparisons
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }

  bool isSameYear(DateTime other) {
    return year == other.year;
  }

  bool get isToday => isSameDay(DateTime.now());
  bool get isTomorrow => isSameDay(DateTime.now().add(const Duration(days: 1)));
  bool get isYesterday => isSameDay(DateTime.now().subtract(const Duration(days: 1)));

  bool get isPast => isBefore(DateTime.now());
  bool get isFuture => isAfter(DateTime.now());
  bool get isNow => isSameDay(DateTime.now()) && hour == DateTime.now().hour && minute == DateTime.now().minute;

  // Week helpers
  bool get isWeekend => weekday == DateTime.saturday || weekday == DateTime.sunday;
  bool get isWeekday => !isWeekend;

  int get weekOfYear {
    final firstDayOfYear = DateTime(year, 1, 1);
    final daysSinceFirstDay = difference(firstDayOfYear).inDays;
    return ((daysSinceFirstDay + firstDayOfYear.weekday) / 7).ceil();
  }

  DateTime get firstDayOfWeek {
    return DateTime(year, month, day - weekday + DateTime.monday);
  }

  DateTime get lastDayOfWeek {
    return DateTime(year, month, day + DateTime.sunday - weekday);
  }

  // Month helpers
  DateTime get firstDayOfMonth {
    return DateTime(year, month, 1);
  }

  DateTime get lastDayOfMonth {
    return DateTime(year, month + 1, 0);
  }

  int get daysInMonth {
    return DateTime(year, month + 1, 0).day;
  }

  // Year helpers
  DateTime get firstDayOfYear {
    return DateTime(year, 1, 1);
  }

  DateTime get lastDayOfYear {
    return DateTime(year, 12, 31);
  }

  bool get isLeapYear {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  // Time manipulation
  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }

  DateTime get noon {
    return DateTime(year, month, day, 12, 0, 0);
  }

  DateTime get midnight {
    return DateTime(year, month, day, 0, 0, 0);
  }

  // Add/Subtract
  DateTime addYears(int years) {
    return DateTime(year + years, month, day, hour, minute, second, millisecond, microsecond);
  }

  DateTime addMonths(int months) {
    final newMonth = month + months;
    final yearsToAdd = (newMonth - 1) ~/ 12;
    final finalMonth = ((newMonth - 1) % 12) + 1;

    return DateTime(
      year + yearsToAdd,
      finalMonth,
      day.clamp(1, DateTime(year + yearsToAdd, finalMonth + 1, 0).day),
      hour,
      minute,
      second,
      millisecond,
      microsecond,
    );
  }

  DateTime addWeeks(int weeks) {
    return add(Duration(days: weeks * 7));
  }

  DateTime subtractYears(int years) => addYears(-years);
  DateTime subtractMonths(int months) => addMonths(-months);
  DateTime subtractWeeks(int weeks) => addWeeks(-weeks);

  // Copy with specific fields
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  // Time ago / from now
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${_pluralize(years, 'год', 'года', 'лет')} назад';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${_pluralize(months, 'месяц', 'месяца', 'месяцев')} назад';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${_pluralize(difference.inDays, 'день', 'дня', 'дней')} назад';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${_pluralize(difference.inHours, 'час', 'часа', 'часов')} назад';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${_pluralize(difference.inMinutes, 'минуту', 'минуты', 'минут')} назад';
    } else {
      return 'только что';
    }
  }

  String get timeUntil {
    final now = DateTime.now();
    final difference = this.difference(now);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return 'через $years ${_pluralize(years, 'год', 'года', 'лет')}';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return 'через $months ${_pluralize(months, 'месяц', 'месяца', 'месяцев')}';
    } else if (difference.inDays > 0) {
      return 'через ${difference.inDays} ${_pluralize(difference.inDays, 'день', 'дня', 'дней')}';
    } else if (difference.inHours > 0) {
      return 'через ${difference.inHours} ${_pluralize(difference.inHours, 'час', 'часа', 'часов')}';
    } else if (difference.inMinutes > 0) {
      return 'через ${difference.inMinutes} ${_pluralize(difference.inMinutes, 'минуту', 'минуты', 'минут')}';
    } else {
      return 'сейчас';
    }
  }

  // Relative date descriptions
  String get relativeDate {
    if (isToday) return 'Сегодня';
    if (isTomorrow) return 'Завтра';
    if (isYesterday) return 'Вчера';

    final daysAgo = DateTime.now().difference(this).inDays;
    if (daysAgo < 7 && daysAgo > 1) {
      return weekdayFormat;
    }

    return dateOnly;
  }

  // Age calculation
  int get age {
    final now = DateTime.now();
    int age = now.year - year;
    if (now.month < month || (now.month == month && now.day < day)) {
      age--;
    }
    return age;
  }

  // Range checking
  bool isBetween(DateTime start, DateTime end) {
    return (isAfter(start) || isAtSameMomentAs(start)) && (isBefore(end) || isAtSameMomentAs(end));
  }

  // Time of day helpers
  bool get isMorning => hour >= 6 && hour < 12;
  bool get isAfternoon => hour >= 12 && hour < 17;
  bool get isEvening => hour >= 17 && hour < 21;
  bool get isNight => hour >= 21 || hour < 6;

  String get timeOfDayGreeting {
    if (isMorning) return 'Доброе утро';
    if (isAfternoon) return 'Добрый день';
    if (isEvening) return 'Добрый вечер';
    return 'Доброй ночи';
  }

  // Helper for Russian pluralization
  static String _pluralize(int count, String one, String few, String many) {
    final mod10 = count % 10;
    final mod100 = count % 100;

    if (mod10 == 1 && mod100 != 11) {
      return one;
    } else if (mod10 >= 2 && mod10 <= 4 && (mod100 < 10 || mod100 >= 20)) {
      return few;
    } else {
      return many;
    }
  }
}
