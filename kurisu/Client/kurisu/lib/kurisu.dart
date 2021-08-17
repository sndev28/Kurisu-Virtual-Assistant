import 'package:flutter/material.dart';
import 'package:kurisu/screen/animeTracker.dart';
import 'package:kurisu/screen/classSchedules.dart';
import 'package:kurisu/screen/home.dart';
import 'package:kurisu/screen/scheduleManager.dart';

import 'navigations.dart';

class Kurisu extends StatefulWidget {
  const Kurisu({Key? key}) : super(key: key);

  @override
  _KurisuState createState() => _KurisuState();
}

class _KurisuState extends State<Kurisu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //   primaryColor: currentTheme.primaryColor,
      //   canvasColor: currentTheme.backgroundColor,
      // ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _routes(),
    );
  }

  RouteFactory _routes() {
    return (settings) {
      Widget screen;

      switch (settings.name) {
        case HOMEDIR:
          screen = HomeScreen();
          break;

        case SCHEDULEMANAGER:
          screen = ScheduleManager();
          break;

        case ANIMETRACKER:
          screen = AnimeTracker();
          break;

        case CLASSSCHEDULES:
          screen = ClassSchedules();
          break;

        default:
          return null;
      }

      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }
}
