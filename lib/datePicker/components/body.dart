import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

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
            selectableDayPredicate: (date) => date.day != 23,
          ),
          const SizedBox(height: 25)
        ],
      ),
    );
  }
}


// TextFormField(
//   textAlignVertical: TextAlignVertical.center,
//   readOnly: true,
//   onTap: () => buildMaterialDatePicker(context),
//   decoration: InputDecoration(
//       border: InputBorder.none,
//       prefixIcon: const Icon(Icons.calendar_today),
//       hintText: DateFormat("dd-MM-yyyy").format(selectedDate),
//       hintStyle: const TextStyle(fontWeight: FontWeight.w600)),
// ),