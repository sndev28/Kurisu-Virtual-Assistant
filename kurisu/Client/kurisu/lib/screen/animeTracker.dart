import 'package:flutter/material.dart';

import '../navigations.dart';

class AnimeTracker extends StatefulWidget {
  const AnimeTracker({Key? key}) : super(key: key);

  @override
  _AnimeTrackerState createState() => _AnimeTrackerState();
}

class _AnimeTrackerState extends State<AnimeTracker> {
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
                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                  title: Center(child: Text('Anime Tracker')),
                  tileColor: Colors.blue[100],
                  hoverColor: Colors.red[100],
                  onTap: () {
                    Navigator.pop(context);
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
                  'Anime Tracker',
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
