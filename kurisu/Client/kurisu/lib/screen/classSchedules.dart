import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kurisu/connections/connections.dart';

import '../navigations.dart';

class ClassSchedules extends StatefulWidget {
  const ClassSchedules({Key? key}) : super(key: key);

  @override
  _ClassSchedulesState createState() => _ClassSchedulesState();
}

class _ClassSchedulesState extends State<ClassSchedules> {
  Map schedules = {};
  List todaysSchedules = [];
  // List mondaysSchedules = [];
  // List tuesdaysSchedules = [];
  // List wednesdaysSchedules = [];
  // List thursdaysSchedules = [];
  // List fridaysSchedules = [];
  // List saturdaysSchedules = [];
  // List sundaysSchedules = [];

  bool schedulesRetrieved = false;

  String dropdownButtonValue = 'Monday';

  TextEditingController subjectController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  scheduleInitializer() async {
    schedules = await retrieveClassSchedules();
    DateTime today = new DateTime.now();
    String day = 'monday';
    switch (today.weekday) {
      case 1:
        day = 'monday';
        break;
      case 2:
        day = 'tuesday';
        break;
      case 3:
        day = 'wednesday';
        break;
      case 4:
        day = 'thursday';
        break;
      case 5:
        day = 'friday';
        break;
      case 6:
        day = 'saturday';
        break;
      case 7:
        day = 'sunday';
        break;
      default:
        day = 'monday';
    }

    todaysSchedules = schedules[day];
    // mondaysSchedules = schedules['monday'];
    // tuesdaysSchedules = schedules['tuesday'];
    // wednesdaysSchedules = schedules['wednesday'];
    // thursdaysSchedules = schedules['thursday'];
    // fridaysSchedules = schedules['friday'];
    // saturdaysSchedules = schedules['saturday'];
    // sundaysSchedules = schedules['sunday'];

    schedulesRetrieved = true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: scheduleInitializer(),
        builder: (context, snapshot) {
          if (schedulesRetrieved == true &&
              snapshot.connectionState == ConnectionState.done) {
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
                          trailing: Icon(Icons.arrow_forward_ios_outlined),
                          title: Center(child: Text('Class Schedules')),
                          tileColor: Colors.blue[100],
                          hoverColor: Colors.red[100],
                          onTap: () {
                            Navigator.pop(context);
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
                          'Class Schedules',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      )),
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey[900],
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0.0, 0.0),
                              blurRadius: 8.0,
                              spreadRadius: 8.0,
                              color: Colors.grey,
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16))),
                    ),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 40,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        // boxShadow: [
                                        //   BoxShadow(
                                        //     color: Colors.grey,
                                        //     offset: Offset(0, 0),
                                        //     spreadRadius: 4.0,
                                        //     blurRadius: 10.0,
                                        //   )
                                        // ],
                                        color: Colors.yellow[100],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16.0))),
                                    width: 300,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0,
                                              right: 15.0,
                                              top: 10.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: DropdownButton(
                                              itemHeight: 48.0,
                                              focusColor: Colors.green,
                                              dropdownColor: Colors.purple[50],
                                              value: dropdownButtonValue,
                                              icon: Icon(Icons
                                                  .arrow_drop_down_outlined),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  dropdownButtonValue =
                                                      newValue!;
                                                });
                                              },
                                              items: <String>[
                                                'Monday',
                                                'Tuesday',
                                                'Wednesday',
                                                'Thursday',
                                                'Friday',
                                                'Saturday',
                                                'Sunday'
                                              ]
                                                  .map<
                                                      DropdownMenuItem<
                                                          String>>((e) =>
                                                      DropdownMenuItem<String>(
                                                        value: e,
                                                        child: Text(e),
                                                      ))
                                                  .toList(),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: TextField(
                                            controller: subjectController,
                                            decoration: InputDecoration(
                                              hintText: 'Subject',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: TextField(
                                            controller: startTimeController,
                                            onTap: () async {
                                              TimeOfDay selectedTime =
                                                  await showTimePicker(
                                                        context: context,
                                                        initialTime:
                                                            TimeOfDay.now(),
                                                      ) ??
                                                      TimeOfDay.now();
                                              startTimeController.text =
                                                  selectedTime.format(context);
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Start Time',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: TextField(
                                            controller: endTimeController,
                                            onTap: () async {
                                              TimeOfDay selectedTime =
                                                  await showTimePicker(
                                                        context: context,
                                                        initialTime:
                                                            TimeOfDay.now(),
                                                      ) ??
                                                      TimeOfDay.now();
                                              endTimeController.text =
                                                  selectedTime.format(context);
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'End Time',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0,
                                              right: 15.0,
                                              bottom: 10.0),
                                          child: TextField(
                                            controller: linkController,
                                            decoration: InputDecoration(
                                              hintText: 'Link',
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () async {
                                                bool responseStatus =
                                                    await createClassSchedule(
                                                        dropdownButtonValue[0]
                                                                .toLowerCase() +
                                                            dropdownButtonValue
                                                                .substring(1),
                                                        subjectController.text,
                                                        startTimeController
                                                            .text,
                                                        endTimeController.text,
                                                        linkController.text);

                                                if (responseStatus == true) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      width: 200,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(20.0),
                                                        ),
                                                      ),
                                                      content: Container(
                                                        height: 20,
                                                        child: Center(
                                                          child: Text(
                                                              'Class schedule created!'),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }

                                                setState(() {});
                                                subjectController.text = '';
                                                startTimeController.text = '';
                                                endTimeController.text = '';
                                                linkController.text = '';
                                              },
                                              child: Icon(
                                                Icons.add_circle,
                                                size: 40.0,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16.0,
                                  top: 30.0,
                                  bottom: 10.0,
                                ),
                                child: Text(
                                  "Today's Schedule",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              // Divider(),
                              Container(
                                width: 400,
                                child: ListView.builder(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  shrinkWrap: true,
                                  itemCount: todaysSchedules.length,
                                  itemBuilder: (context, count) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Container(
                                        height: 85,
                                        decoration: BoxDecoration(
                                            color: Colors.green[100],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    todaysSchedules[count]
                                                        ['subject'],
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    3.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            Clipboard.setData(
                                                                ClipboardData(
                                                                    text: todaysSchedules[
                                                                            count]
                                                                        [
                                                                        'link']));

                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                behavior:
                                                                    SnackBarBehavior
                                                                        .floating,
                                                                width: 200,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius.circular(
                                                                        20.0),
                                                                  ),
                                                                ),
                                                                content:
                                                                    Container(
                                                                  height: 20,
                                                                  child: Center(
                                                                    child: Text(
                                                                        'Class link copied!'),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Icon(
                                                            Icons.copy,
                                                            size: 14.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    3.0),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            bool responseStatus = await deleteClassSchedule(
                                                                todaysSchedules[
                                                                        count]
                                                                    ['day'],
                                                                todaysSchedules[
                                                                        count]
                                                                    ['subject'],
                                                                todaysSchedules[
                                                                        count][
                                                                    'startTime']);
                                                            if (responseStatus ==
                                                                true) {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  behavior:
                                                                      SnackBarBehavior
                                                                          .floating,
                                                                  width: 200,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .all(
                                                                      Radius.circular(
                                                                          20.0),
                                                                    ),
                                                                  ),
                                                                  content:
                                                                      Container(
                                                                    height: 20,
                                                                    child:
                                                                        Center(
                                                                      child: Text(
                                                                          'Class deleted!'),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  behavior:
                                                                      SnackBarBehavior
                                                                          .floating,
                                                                  width: 200,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .all(
                                                                      Radius.circular(
                                                                          20.0),
                                                                    ),
                                                                  ),
                                                                  content:
                                                                      Container(
                                                                    height: 20,
                                                                    child:
                                                                        Center(
                                                                      child: Text(
                                                                          'Class deletion unsuccesful! Try again later!'),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                            setState(() {});
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .delete_outline,
                                                            size: 18.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Divider(),
                                              Text(
                                                'Start Time : ' +
                                                    todaysSchedules[count]
                                                        ['startTime'] +
                                                    '\nEnd Time : ' +
                                                    todaysSchedules[count]
                                                        ['endTime'],
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Divider(),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16.0,
                                  top: 30.0,
                                  bottom: 10.0,
                                ),
                                child: Text(
                                  "Monday's Schedule",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              containerByDay('monday'),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16.0,
                                  top: 30.0,
                                  bottom: 10.0,
                                ),
                                child: Text(
                                  "Tuesday's Schedule",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              containerByDay('tuesday'),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16.0,
                                  top: 30.0,
                                  bottom: 10.0,
                                ),
                                child: Text(
                                  "Wednesday's Schedule",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              containerByDay('wednesday'),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16.0,
                                  top: 30.0,
                                  bottom: 10.0,
                                ),
                                child: Text(
                                  "Thursday's Schedule",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              containerByDay('thursday'),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16.0,
                                  top: 30.0,
                                  bottom: 10.0,
                                ),
                                child: Text(
                                  "Friday's Schedule",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              containerByDay('friday'),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16.0,
                                  top: 30.0,
                                  bottom: 10.0,
                                ),
                                child: Text(
                                  "Saturday's Schedule",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              containerByDay('saturday'),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 16.0,
                                  top: 30.0,
                                  bottom: 10.0,
                                ),
                                child: Text(
                                  "Sunday's Schedule",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              containerByDay('sunday'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Container(
                  color: Colors.green,
                  // width: MediaQuery.of(context).size.width / 2,
                  // child: Image.asset(
                  //   'assets/images/meow.gif',
                  // )),
                ),
              ),
            );
          }
        });
  }

  Container containerByDay(String day) {
    return Container(
      width: 400,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        shrinkWrap: true,
        itemCount: schedules[day].length,
        itemBuilder: (context, count) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              height: 85,
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          schedules[day][count]['subject'],
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              child: InkWell(
                                onTap: () {
                                  Clipboard.setData(ClipboardData(
                                      text: schedules[day][count]['link']));

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      width: 200,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                      ),
                                      content: Container(
                                        height: 20,
                                        child: Center(
                                          child: Text('Class link copied!'),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.copy,
                                  size: 14.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              child: InkWell(
                                onTap: () async {
                                  bool responseStatus =
                                      await deleteClassSchedule(
                                          schedules[day][count]['day'],
                                          schedules[day][count]['subject'],
                                          schedules[day][count]['startTime']);
                                  if (responseStatus == true) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        width: 200,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20.0),
                                          ),
                                        ),
                                        content: Container(
                                          height: 20,
                                          child: Center(
                                            child: Text('Class deleted!'),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        width: 200,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20.0),
                                          ),
                                        ),
                                        content: Container(
                                          height: 20,
                                          child: Center(
                                            child: Text(
                                                'Class deletion unsuccesful! Try again later!'),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.delete_outline,
                                  size: 18.0,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(),
                    Text(
                      'Start Time : ' +
                          schedules[day][count]['startTime'] +
                          '\nEnd Time : ' +
                          schedules[day][count]['endTime'],
                      style: TextStyle(
                        fontSize: 12.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
