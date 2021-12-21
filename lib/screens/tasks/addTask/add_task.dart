import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();

  final ref = FirebaseFirestore.instance
      .collection('users')
      .doc((FirebaseAuth.instance.currentUser!).uid)
      .collection('notes');

  DateTime selectedDate = DateTime.now();
  List listOfFields = <Widget>[];
  List controllers = <TextEditingController>[];
  List isChecked = <bool>[];
  List<Map<String, dynamic>> myData = [];

  @override
  Widget build(BuildContext context) {
    print(myData);
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: addDataToDB, icon: const Icon(Icons.check))
          ],
        ),
        body: Body(
          title: title,
          description: description,
          selectedDate: selectedDate,
          listOfFields: listOfFields,
          controllers: controllers,
          isChecked: isChecked,
          myData: myData,
          selectedDateMethod: (DateTime? value) {
            setState(() {
              selectedDate = value!;
            });
          },
          addNewField: addNewField,
        ),
        bottomNavigationBar: Row(
          children: [
            IconButton(
                onPressed: addNewField,
                icon: const Icon(Icons.check_box_outlined)),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.format_paint_outlined)),
            const Spacer(),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.more_vert_outlined)),
          ],
        ));
  }

  void addDataToDB() {
    if (title.text.isNotEmpty || description.text.isNotEmpty) {
      ref.add({
        'date': selectedDate,
        'title': title.text,
        'description': description.text,
        'createdAt': DateTime.now(),
        'isDeleted': false,
        'tasks': myData,
      }).whenComplete(() => Navigator.pop(context));
    } else {
      Navigator.pop(context);
    }
  }

  void addNewField() {
    setState(() {
      listOfFields.add(TextFormField());
      controllers.add(TextEditingController());
      isChecked.add(false);
    });
  }
}
