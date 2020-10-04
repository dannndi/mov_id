extension DateTimeExtension on DateTime {
  String get shortDayName {
    switch (this.weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "None";
    }
  }

  String get fullDayName {
    switch (this.weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thuesday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "None";
    }
  }

  String get monthName {
    switch (this.month) {
      case 1:
        return "January";
      case 2:
        return "Febuary";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "Mei";
      case 6:
        return "Juny";
      case 7:
        return "July";
      case 7:
        return "August";
      case 7:
        return "September";
      case 7:
        return "Oktober";
      case 7:
        return "November";
      case 7:
        return "Desember";
      default:
        return "None";
    }
  }

  String get dateAndTime {
    return "${this.shortDayName} ${this.day}, ${this.hour}:00";
  }

  String get fullDate {
    return "${this.fullDayName}, ${this.day} ${monthName} ${this.year}";
  }
}
