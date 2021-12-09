import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  CollectionReference ref = FirebaseFirestore.instance.collection('notes');
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            TextFormField(
              textAlignVertical: TextAlignVertical.center,
              readOnly: true,
              onTap: () => buildMaterialDatePicker(context),
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.calendar_today),
                hintText: DateFormat("dd-MM-yyyy").format(selectedDate),
                hintStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            CustomTextFormField(
              hint: 'Título',
              hintStyle: const TextStyle(fontSize: 26),
              controller: title,
              action: TextInputAction.next,
            ),
            CustomTextFormField(
              hint: 'Escribe algo...',
              controller: description,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.add({
                  'date': selectedDate,
                  'title': title.text,
                  'description': description.text,
                  'createdAt': DateTime.now(),
                }).whenComplete(() => Navigator.pop(context));
              },
              child: const Text('Crear Tarea'),
              style: ElevatedButton.styleFrom(primary: Colors.redAccent[100]),
            )
          ],
        ),
      ),
    );
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.controller,
    this.action,
    this.onFieldSubmitted,
    this.onTap,
    this.icon,
    this.decoration,
    this.hint,
    this.hintStyle,
  }) : super(key: key);
  final TextEditingController? controller;
  final String? hint;
  final TextInputAction? action;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final Icon? icon;
  final InputDecoration? decoration;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: hintStyle,
      controller: controller,
      textInputAction: action,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      textAlignVertical: TextAlignVertical.center,
      decoration: decoration ??
          InputDecoration(
            hintText: hint ?? "",
            hintStyle: hintStyle,
            prefixIcon: icon,
            border: InputBorder.none,
          ),
    );
  }
}
