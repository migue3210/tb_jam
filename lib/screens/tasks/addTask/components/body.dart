import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tb_jam/configurations/constants.dart';

import '../add_task.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.title,
    required this.description,
    required this.selectedDate,
    required this.selectedDateMethod,
    required this.listOfFields,
    required this.addNewField,
    required this.checkMap,
    required this.checkMapMethod,
    required this.onChanged,
  }) : super(key: key);

  final TextEditingController title;
  final TextEditingController description;
  final DateTime selectedDate;
  final void Function(DateTime? value) selectedDateMethod;
  final List<Name>? listOfFields;
  final Name? checkMap;
  final void Function(Name? value) checkMapMethod;

  final void Function(Select? value) onChanged;
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
  List<Name>? get listOfFields => widget.listOfFields;
  Name? get checkMap => widget.checkMap;

  void Function(Name? value) get checkMapMethod => widget.checkMapMethod;
  void Function(Select? value) get onChanged => widget.onChanged;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              listOfFields!.isNotEmpty
                  ? ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listOfFields!.length,
                      itemBuilder: (BuildContext context, int index) {
                        Name listOfField = listOfFields![index];

                        TextEditingController controller =
                            TextEditingController(text: listOfField.title);

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: value,
                              onChanged: (value) {},
                            ),
                            Flexible(
                              child: TextFormField(
                                autofocus: true,
                                controller: TextEditingController(
                                    text: listOfField.title),
                                textInputAction: TextInputAction.newline,
                                onChanged: (value) {
                                  TextSelection.fromPosition(TextPosition(
                                      offset: controller.text.length));
                                  onChanged(Select(note: value, index: index));
                                },
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
                      })
                  : const SizedBox(),
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
