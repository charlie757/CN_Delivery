import 'package:intl/intl.dart';

class TimeFormat{
 static String convertDate(String date) {
    // Define the input and output date formats
    final inputFormat = DateFormat('dd-MM-yyyy');
    final outputFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');

    // Parse the input date string to a DateTime object
    DateTime dateTime = inputFormat.parse(date);

    // Format the DateTime object to the desired output string
    String formattedDate = outputFormat.format(dateTime);

    return formattedDate;
  }

  static convertDate1(String dateString){
    DateFormat inputFormat = DateFormat("dd-MM-yyyy");
    DateTime parsedDate = inputFormat.parse(dateString);

    // Adjust the time to 00:00:00.000
    DateTime formattedDate = DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
    );

    print(formattedDate); // Output: 2024-08-09 00:00:00.000
    return formattedDate;
  }

static String convertNotificationDate(myDateTime) {
    var dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
    var utcDate = dateFormat.format(DateTime.parse(myDateTime));

    DateTime dateTime = dateFormat.parse(utcDate, true).toLocal();
    String formattedDate = DateFormat('d MMMM yyyy').format(dateTime);
    String formattedTime = DateFormat('h:mm a').format(dateTime);

    return formattedDate;
  }

}