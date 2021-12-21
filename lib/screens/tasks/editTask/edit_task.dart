import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class EditTask extends StatefulWidget {
  const EditTask({Key? key, required this.docToEdit}) : super(key: key);

  final DocumentSnapshot docToEdit;

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc((FirebaseAuth.instance.currentUser!).uid)
      .collection('notes');
  DateTime selectedDate = DateTime.now();
  List listOfFields = <Widget>[];
  List controllers = <TextEditingController>[];
  List isChecked = <bool>[];
  List<Map<String, dynamic>> myData = [];
  // List tasks = [];

  bool isDeleted = false;

  @override
  void initState() {
    title = TextEditingController(text: widget.docToEdit.get('title'));
    description =
        TextEditingController(text: widget.docToEdit.get('description'));
    selectedDate = (widget.docToEdit.get('date') as Timestamp).toDate();
    // myData = (widget.docToEdit.get('tasks'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            widget.docToEdit.get('isDeleted') == false
                ? IconButton(
                    onPressed: () {
                      setState(() => isDeleted = true);
                      widget.docToEdit.reference.update({
                        'isDeleted': isDeleted,
                      }).whenComplete(() => Navigator.pop(context));
                    },
                    icon: const Icon(Icons.delete))
                : IconButton(
                    onPressed: () {
                      setState(() => isDeleted = false);
                      widget.docToEdit.reference.update({
                        'isDeleted': isDeleted,
                      }).whenComplete(() => Navigator.pop(context));
                    },
                    icon: const Icon(Icons.check)),
            if (widget.docToEdit.get('isDeleted') == false)
              IconButton(
                  onPressed: editDataToDB, icon: const Icon(Icons.check)),
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
          actionMethod: actionMethod,
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

  void editDataToDB() {
    widget.docToEdit.reference.update({
      'date': selectedDate,
      'title': title.text,
      'description': description.text,
      'tasks': myData,
    }).whenComplete(() => Navigator.pop(context));
  }

  void addNewField() {
    setState(() {
      listOfFields.add(TextFormField());
      controllers.add(TextEditingController());
      isChecked.add(false);
    });
  }

  void actionMethod(int index) {
    isChecked[index];
    controllers[index].text;
    Map<String, dynamic> si = {
      'task': controllers[index].text,
      'wasFinished': isChecked[index]
    };

    myData[index].update(
      si[2],
      (value) {
        value = isChecked[index];
        return value;
      },
    );

    myData.add(si);
  }
}
