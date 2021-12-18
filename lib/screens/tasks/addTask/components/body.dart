import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tb_jam/configurations/constants.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.title,
    required this.description,
    required this.selectedDate,
    required this.selectedDateMethod,
    required this.listOfFields,
    required this.addNewField,
    required this.controllers,
    required this.isChecked,
  }) : super(key: key);

  final TextEditingController title;
  final TextEditingController description;
  final DateTime selectedDate;
  final void Function(DateTime? value) selectedDateMethod;
  final List listOfFields;
  final List controllers;
  final List isChecked;

  final void Function() addNewField;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController get title => widget.title;
  TextEditingController get description => widget.description;
  DateTime get selectedDate => widget.selectedDate;
  void Function(DateTime? value) get selectedDateMethod =>
      widget.selectedDateMethod;
  void Function() get addNewField => widget.addNewField;
  List get listOfFields => widget.listOfFields;
  List get controllers => widget.controllers;
  List get isChecked => widget.isChecked;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool value = false;
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView(
            children: [
              CustomTextFormField(
                  hint: 'Título',
                  hintStyle: const TextStyle(fontSize: 26),
                  controller: title,
                  action: TextInputAction.next,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0)),
              TextFormField(
                textAlignVertical: TextAlignVertical.center,
                readOnly: true,
                onTap: () => buildMaterialDatePicker(context),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: DateFormat.yMMMMd("es").format(selectedDate),
                  hintStyle: const TextStyle(fontWeight: FontWeight.w600),
                  suffixIcon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                ),
              ),
              CustomTextFormField(
                hint: 'Escribe algo...',
                controller: description,
              ),
              const SizedBox(height: 20),
              if (listOfFields.isNotEmpty)
                Text(
                    '${isChecked.where((check) => check == true).length}/${listOfFields.length}'),
              ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: listOfFields.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        onChanged: (checked) {
                          setState(
                            () {
                              isChecked[index] = checked;
                            },
                          );
                        },
                        value: isChecked[index],
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: controllers[index],
                          autofocus: true,
                          textInputAction: TextInputAction.newline,
                          style: TextStyle(
                              decoration: isChecked[index] == true
                                  ? TextDecoration.lineThrough
                                  : null),
                          onFieldSubmitted: (v) {
                            addNewField();
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
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
      selectedDateMethod(picked);
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
    this.contentPadding,
  }) : super(key: key);
  final TextEditingController? controller;
  final String? hint;
  final TextInputAction? action;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  final Icon? icon;
  final InputDecoration? decoration;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: hintStyle,
      controller: controller,
      textInputAction: action,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      textAlignVertical: TextAlignVertical.center,
      maxLines: null,
      // keyboardType: TextInputType.multiline,
      decoration: decoration ??
          InputDecoration(
            contentPadding: contentPadding,
            hintText: hint ?? "",
            hintStyle: hintStyle,
            prefixIcon: icon,
            border: InputBorder.none,
          ),
    );
  }
}
