import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tb_jam/drawer/drawer.dart';

import 'components/body.dart';

class TimableScreen extends StatelessWidget {
  const TimableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Horario',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: const DrawerMenu(),
      body: const Body(),
    );
  }
}
