import 'package:cloud_firestore/cloud_firestore.dart';
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
  CollectionReference ref = FirebaseFirestore.instance.collection('notes');
  DateTime selectedDate = DateTime.now();
  List listOfFields = <Widget>[];

  @override
  Widget build(BuildContext context) {
    listOfFields.forEach((element) {
      print(element);
    });
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: addDataToDB, icon: const Icon(Icons.check))
          ],
        ),
        body: Body(
          title: title,
          selectedDateMethod: (DateTime? value) {
            setState(() {
              selectedDate = value!;
            });
          },
          selectedDate: selectedDate,
          description: description,
          listOfFields: listOfFields,
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
    ref.add({
      'date': selectedDate,
      'title': title.text,
      'description': description.text,
      'createdAt': DateTime.now(),
      'isDeleted': false,
    }).whenComplete(() => Navigator.pop(context));
  }

  void addNewField() {
    setState(() {
      listOfFields.add(TextFormField());
    });
  }
}
