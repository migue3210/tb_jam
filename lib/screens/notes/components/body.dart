import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tb_jam/configurations/constants.dart';
import 'package:tb_jam/screens/tasks/editTask/edit_task.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final ref = FirebaseFirestore.instance
      .collection('users')
      .doc((FirebaseAuth.instance.currentUser!).uid)
      .collection('notes');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: StreamBuilder(
                stream: ref
                    .where('isDeleted', isEqualTo: false)
                    .orderBy('date', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Algo ha salido mal'));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: Text('Cargando...'));
                  } else if (!snapshot.hasData ||
                      snapshot.data!.docs
                              .every((element) => element.get('isDeleted')) ==
                          true) {
                    return const Center(child: Text('No hay notas'));
                  }
                  final data = snapshot.requireData;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.hasData ? data.size : 0,
                    itemBuilder: (BuildContext context, int index) {
                      if (snapshot.hasData) {
                        return cardMethod(data, index);
                      }
                      return const Text('No hay tareas pendientes');
                    },
                  );
                }),
          ),
        ),
      ],
    );
  }

  Padding cardMethod(QuerySnapshot<Object?> data, int index) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 6,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black12,
                style: BorderStyle.solid,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTask(docToEdit: data.docs[index]),
                ),
              );
            },
            title: data.docs[index]['title'].isNotEmpty
                ? Text(data.docs[index]['title'])
                : const SizedBox(),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (data.docs[index]['description'].isNotEmpty)
                  Text(
                    data.docs[index]['description'],
                    maxLines: 6,
                    overflow: TextOverflow.fade,
                  ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    DateFormat("dd-MM-yyyy").format(
                      (data.docs[index]['date']).toDate(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
