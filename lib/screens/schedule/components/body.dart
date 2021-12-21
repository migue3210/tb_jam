import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:intl/intl.dart';
import 'package:tb_jam/configurations/constants.dart';
import 'package:tb_jam/screens/tasks/editTask/edit_task.dart';

class Body extends StatefulWidget {
  const Body(
      {Key? key, required this.selectedDate, required this.methodSelectData})
      : super(key: key);

  final DateTime selectedDate;
  final void Function(DateTime? value) methodSelectData;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DateTime get selectedDate => widget.selectedDate;
  void Function(DateTime? value) get methodSelectData =>
      widget.methodSelectData;

  final ref = FirebaseFirestore.instance
      .collection('users')
      .doc((FirebaseAuth.instance.currentUser!).uid)
      .collection('notes');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Calendar(widget: widget, methodSelectData: methodSelectData),
        Expanded(
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: StreamBuilder(
                stream: ref
                    .where('isDeleted', isEqualTo: false)
                    .orderBy('date')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Algo ha salido mal');
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Text('Cargando...');
                  }
                  final data = snapshot.requireData;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.hasData ? data.size : 0,
                    itemBuilder: (BuildContext context, int index) {
                      if (!snapshot.hasData) {
                        return const Text('No hay tareas pendientes');
                      }
                      return cardMethod(data, index);
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
        vertical: 6,
      ),
      child: ((data.docs[index]['date'].toDate() == selectedDate ||
              DateFormat("dd-MM-yyyy").format(
                    (selectedDate),
                  ) ==
                  DateFormat("dd-MM-yyyy").format(
                    (data.docs[index]['date']).toDate(),
                  )))
          ? Container(
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
                      builder: (context) =>
                          EditTask(docToEdit: data.docs[index]),
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
            )
          : null,
    );
  }
}

class Calendar extends StatelessWidget {
  const Calendar({
    Key? key,
    required this.widget,
    required this.methodSelectData,
  }) : super(key: key);

  final Body widget;
  final void Function(DateTime? value) methodSelectData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CalendarTimeline(
            initialDate: widget.selectedDate,
            firstDate: DateTime(2010),
            lastDate: DateTime(2025),
            onDateSelected: (date) => methodSelectData(date),
            leftMargin: 20,
            dayColor: Colors.teal[200],
            dayNameColor: Colors.white,
            activeDayColor: Colors.white,
            activeBackgroundDayColor: kPrimaryColor,
            dotsColor: const Color(0xFF333A47),
          ),
          const SizedBox(height: 25)
        ],
      ),
    );
  }
}
