import 'package:campbelldecor/screens/bookingdetailsscreen.dart';
import 'package:campbelldecor/screens/homescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  BookingScreen({super.key});
  final ref = FirebaseDatabase.instance.ref('booking');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text("Fetch Data from Users"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {
                return Card(
                  color: Color.fromARGB(50, 260, 250, 254),
                  child: ListTile(
                    title: Text(snapshot.child('name').value.toString()),
                    subtitle:
                        Text(snapshot.child('bookingNo').value.toString()),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookingDetailsScreen()));
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
