import 'package:cloud_firestore/cloud_firestore.dart';
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
  CollectionReference ref = FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenu(),
      appBar: appBarMethod(context),
      body: Body(ref: ref),
    );
  }

  AppBar appBarMethod(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Papelera',
      ),
      actions: [
        TextButton(
            onPressed: () {
              showAlertDialog(context);
            },
            child: const Text('vaciar'))
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancelar"),
      onPressed: () => Navigator.pop(context),
    );
    Widget continueButton = TextButton(
      child: const Text("Continuar"),
      onPressed: () {
        ref.where("isDeleted", isEqualTo: true).get().then((value) {
          value.docs.forEach((element) {
            ref.doc(element.id).delete();
          });
        }).whenComplete(() => Navigator.pop(context));
      },
    );

    AlertDialog alert = AlertDialog(
      content: const Text("¿Estás seguro que deseas vaciar la papelera?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
