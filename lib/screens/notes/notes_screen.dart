import 'package:flutter/material.dart';
import 'package:tb_jam/drawer/drawer.dart';

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
    );
  }
}
