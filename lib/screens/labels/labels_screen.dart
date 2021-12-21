import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tb_jam/drawer/drawer.dart';

import 'components/body.dart';

class LabelsScreen extends StatelessWidget {
  const LabelsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenu(),
      appBar: AppBar(
        title: Text(
          'Etiquetas',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: const Body(),
    );
  }
}
