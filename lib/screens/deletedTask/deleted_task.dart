import 'package:flutter/material.dart';
import 'package:tb_jam/drawer/drawer.dart';

import 'components/body.dart';

class DeletedTask extends StatefulWidget {
  const DeletedTask({Key? key}) : super(key: key);

  @override
  _DeletedTaskState createState() => _DeletedTaskState();
}

class _DeletedTaskState extends State<DeletedTask> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenu(),
      appBar: appBarMethod(context),
      body: const Body(),
    );
  }

  AppBar appBarMethod(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Papelera',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
