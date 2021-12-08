import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tb_jam/addTask/add_task.dart';
import 'package:tb_jam/configurations/constants.dart';
import 'package:tb_jam/drawer/drawer.dart';

import 'components/body.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfafafaff),
      drawer: const Drawer(
        child: DrawerMenu(),
      ),
      appBar: appBarMethod(context),
      body: Body(
          methodSelectData: (DateTime? value) =>
              setState(() => selectedDate = value!),
          selectedDate: selectedDate),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTask(),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.redAccent[100],
      ),
    );
  }

  AppBar appBarMethod(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        DateFormat.MMMM("es").format(selectedDate).capitalizeIt(),
        style: const TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(
            onPressed: () => buildMaterialDatePicker(context),
            icon: const Icon(Icons.calendar_today))
      ],
    );
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
