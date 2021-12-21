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
  List<Name>? listOfFields = <Name>[];

  Name? checkMap = Name();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            listOfFields!.length.toString(),
          ),
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
          checkMapMethod: (Name? value) {
            checkMap = value!;
          },
          checkMap: checkMap,
          onChanged: (Select? select) => setState(() {
            listOfFields?[select!.index!].title = select.note;
          }),
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
      listOfFields?.add(checkMap!);
    });
  }
}

class Name {
  String? title;
  bool? boolean;

  Name({this.title, this.boolean});
}

class Select {
  String? note;
  int? index;

  Select({this.note, this.index});
}
