import 'package:flutter/material.dart';
import 'package:tb_jam/drawer/drawer.dart';
import 'package:tb_jam/screens/tasks/addTask/add_task.dart';

import 'components/body.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenu(),
      appBar: AppBar(
        title: const Text('Notas'),
        centerTitle: true,
      ),
      body: const Body(),
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
}
