import 'dart:convert';

import 'package:http/http.dart';

const BASE_URI = '192.168.1.35';
const PORT = 5000;

final Uri classScheduleUri =
    Uri(scheme: 'http', host: BASE_URI, path: '/classSchedules', port: PORT);

Future<Map> retrieveClassSchedules() async {
  Response response = await get(
    classScheduleUri,
  );

  Map schedules = jsonDecode(response.body);
  return schedules;
}

Future<bool> createClassSchedule(String day, String subject, String startTime,
    String endTime, String link) async {
  Map<String, String> body = {
    'day': day,
    'subject': subject,
    'startTime': startTime,
    'endTime': endTime,
    'link': link,
  };
  Response response = await post(
    classScheduleUri,
    body: body,
  );

  if (response.statusCode == 200)
    return true;
  else
    return false;
}

Future<bool> deleteClassSchedule(
    String day, String subject, String startTime) async {
  Map<String, String> body = {
    'day': day,
    'subject': subject,
    'startTime': startTime,
  };

  Response response = await delete(
    classScheduleUri,
    body: body,
  );

  if (response.statusCode == 200)
    return true;
  else
    return false;
}
