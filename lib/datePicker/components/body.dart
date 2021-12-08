import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:tb_jam/configurations/constants.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Calendar(widget: widget, methodSelectData: methodSelectData),
        Expanded(
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 2,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        onTap: () {},
                        title: const Text('Título de la Nota'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [Text('Contenido'), Text('Fecha')],
                        ),
                      ),
                      const Divider(
                        thickness: 1.0,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
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
            activeBackgroundDayColor: Colors.redAccent[100],
            dotsColor: const Color(0xFF333A47),
          ),
          const SizedBox(height: 25)
        ],
      ),
    );
  }
}
