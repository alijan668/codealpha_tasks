import 'package:campus_event_reminder/add_event.dart';
import 'package:campus_event_reminder/notification_service.dart';
import 'package:campus_event_reminder/event.dart';
import 'package:flutter/material.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  List<Event> events = [];

  void addEvent(Event event) {
    setState(() {
      events.add(event);
    });
  }

  @override
  void initState() {
    super.initState();
    Notification_Service().initializing_Settings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Event Reminder')),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(events[index].name),
            subtitle: Text(
                'Date: ${events[index].date} - Time: ${events[index].time}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  events.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffF10606),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Add_Event(addEvent)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
