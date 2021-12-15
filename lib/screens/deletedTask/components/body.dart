import 'package:cloud_firestore/cloud_firestore.dart';
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
  final ref = FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: StreamBuilder(
                stream: ref.orderBy('date', descending: true).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Algo ha salido mal'));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: Text('Cargando...'));
                  } else if (snapshot.data!.docs
                          .any((element) => element.get('isDeleted')) ==
                      false) {
                    return const Center(child: Text('La papelera está vacía'));
                  }
                  final data = snapshot.requireData;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.hasData ? data.size : 0,
                    itemBuilder: (BuildContext context, int index) {
                      if (snapshot.hasData) {
                        return cardMethod(data, index);
                      }
                      return const SizedBox();
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
        horizontal: 28,
        vertical: 2,
      ),
      child: (data.docs[index]['isDeleted'] == true)
          ? Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditTask(docToEdit: data.docs[index]),
                      ),
                    );
                  },
                  title: Text(data.docs[index]['title']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.docs[index]['description'],
                        maxLines: 6,
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        DateFormat("dd-MM-yyyy").format(
                          (data.docs[index]['date']).toDate(),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1.0,
                )
              ],
            )
          : Container(),
    );
  }
}
