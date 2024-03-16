import 'package:campus_event_reminder/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:campus_event_reminder/event.dart';

DateTime selected_date = DateTime.now();
TimeOfDay selected_time = TimeOfDay.now();

DateTime selected_date_time = DateTime(
  selected_date.year,
  selected_date.month,
  selected_date.day,
  selected_time.hour,
  selected_time.minute,
);

class Add_Event extends StatefulWidget {
  final Function(Event) addEventCallback;

  Add_Event(this.addEventCallback);

  @override
  State<Add_Event> createState() => _Add_EventState();
}

class _Add_EventState extends State<Add_Event> {
  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selected_date,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != selected_date) {
      setState(() {
        selected_date = picked;
      });
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selected_time,
    );
    if (picked != null && picked != selected_time) {
      setState(() {
        selected_time = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Event Name',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      selectDate(context);
                    },
                    child: Text('Select Date')),
                SizedBox(width: 8),
                ElevatedButton(
                    onPressed: () {
                      selectTime(context);
                    },
                    child: Text('Select Time')),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffF10606),
              ),
              onPressed: () {
                String name = nameController.text;
                String date = (selected_date.year.toString() +
                    "-" +
                    selected_date.month.toString() +
                    "-" +
                    selected_date.day.toString());
                String time = selected_time.toString();
                widget.addEventCallback(Event(name, date, time));

                DateTime notification_time =
                    selected_date_time.subtract(Duration(minutes: 15));

                Notification_Service().schedule_Notification(
                    title: ("Don't forget to attent " + name),
                    body: selected_date_time.toString(),
                    schedule_notification_date_time: notification_time);

                Navigator.pop(context);
              },
              child: Center(child: Text('Add Event')),
            ),
          ],
        ),
      ),
    );
  }
}
