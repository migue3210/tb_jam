import 'package:flutter/material.dart';

import 'components/body.dart';

class AddTask extends StatelessWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: const [
            Icon(
              Icons.note_add_outlined,
              color: Colors.blue,
            ),
            SizedBox(width: 10),
            Text('Añádir una nueva tarea'),
          ],
        ),
      ),
      body: const Body(),
    );
  }
}
