import 'package:flutter/material.dart';
import 'package:kurisu/navigations.dart';
import 'package:kurisu/screen/classSchedules.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[900],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        )),
                    height: 60,
                    child: Center(
                      child: Text(
                        'Menu',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                ListTile(
                  hoverColor: Colors.green[100],
                  title: Text('Schedule Manager'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                      context,
                      SCHEDULEMANAGER,
                    );
                  },
                ),
                ListTile(
                  hoverColor: Colors.green[100],
                  title: Text('Anime Tracker'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                      context,
                      ANIMETRACKER,
                    );
                  },
                ),
                ListTile(
                  title: Text('Class Schedules'),
                  hoverColor: Colors.green[100],
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                      context,
                      CLASSSCHEDULES,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Kurisu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              )),
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16))),
            )
          ],
        ),
      ),
    );
  }
}
