import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditTask extends StatefulWidget {
  const EditTask({Key? key, required this.docToEdit}) : super(key: key);

  final DocumentSnapshot docToEdit;
  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool isDeleted = false;

  @override
  void initState() {
    title = TextEditingController(text: widget.docToEdit.get('title'));
    description =
        TextEditingController(text: widget.docToEdit.get('description'));
    selectedDate = (widget.docToEdit.get('date') as Timestamp).toDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          widget.docToEdit.get('isDeleted') == false
              ? IconButton(
                  onPressed: () {
                    setState(() => isDeleted = true);
                    widget.docToEdit.reference.update({
                      'isDeleted': isDeleted,
                    }).whenComplete(() => Navigator.pop(context));
                  },
                  icon: const Icon(Icons.delete))
              : IconButton(
                  onPressed: () {
                    setState(() => isDeleted = false);
                    widget.docToEdit.reference.update({
                      'isDeleted': isDeleted,
                    }).whenComplete(() => Navigator.pop(context));
                  },
                  icon: const Icon(Icons.check)),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextFormField(
                    readOnly: widget.docToEdit.get('isDeleted') == true,
                    hint: 'Título',
                    hintStyle: const TextStyle(fontSize: 26),
                    controller: title,
                    action: TextInputAction.next,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0)),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  readOnly: true,
                  onTap: widget.docToEdit.get('isDeleted') == false
                      ? () => buildMaterialDatePicker(context)
                      : () {},
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: DateFormat.yMMMMd("es").format(selectedDate),
                    hintStyle: const TextStyle(fontWeight: FontWeight.w600),
                    suffixIcon: Icon(
                      Icons.edit,
                      color: widget.docToEdit.get('isDeleted') == false
                          ? Colors.blue
                          : Colors.grey[600],
                    ),
                  ),
                ),
                CustomTextFormField(
                  readOnly: widget.docToEdit.get('isDeleted') == true,
                  hint: 'Escribe algo...',
                  controller: description,
                ),
                const SizedBox(height: 20),
                if (widget.docToEdit.get('isDeleted') == false)
                  ElevatedButton(
                    onPressed: () {
                      widget.docToEdit.reference.update({
                        'date': selectedDate,
                        'title': title.text,
                        'description': description.text,
                        'createdAt': DateTime.now(),
                      }).whenComplete(() => Navigator.pop(context));
                    },
                    child: const Text('Salvar'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent[100]),
                  )
              ],
            ),
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
    this.contentPadding,
    this.readOnly,
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
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly!,
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
