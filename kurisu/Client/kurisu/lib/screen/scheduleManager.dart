import 'package:flutter/material.dart';

import '../navigations.dart';

class ScheduleManager extends StatefulWidget {
  const ScheduleManager({Key? key}) : super(key: key);

  @override
  _ScheduleManagerState createState() => _ScheduleManagerState();
}

class _ScheduleManagerState extends State<ScheduleManager> {
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
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                  title: Center(child: Text('Schedule Manager')),
                  tileColor: Colors.blue[100],
                  hoverColor: Colors.red[100],
                  onTap: () {
                    Navigator.pop(context);
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
                  hoverColor: Colors.green[100],
                  title: Text('Class Schedules'),
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
                  'Schedule Manager',
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
