import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tb_jam/configurations/constants.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    this.docToEdit,
  }) : super(key: key);

  final DocumentSnapshot? docToEdit;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController label = TextEditingController();
  TextEditingController editLabel = TextEditingController();
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc((FirebaseAuth.instance.currentUser!).uid)
      .collection('labels');
  // List listOfLabels = <Widget>[];
  // List controllers = <TextEditingController>[];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView(
            children: [
              CustomTextFormField(
                hint: 'Añadir etiqueta',
                controller: label,
                onFieldSubmitted: (v) {
                  if (label.text.isNotEmpty) {
                    addDataToDB();
                    label.clear();
                  }
                },
                icon: IconButton(
                    focusColor: kPrimaryColor,
                    onPressed: () {
                      addDataToDB();
                      label.clear();
                    },
                    icon: const Icon(
                      Icons.check,
                    )),
              ),
              StreamBuilder(
                stream: ref.orderBy('createdAt', descending: true).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Algo ha salido mal'));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: Text('Cargando...'));
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text('No hay etiquetas'));
                  }
                  final data = snapshot.requireData;

                  return ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.size,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // IconButton(
                          //   onPressed: () {},
                          //   icon: const Icon(
                          //     Icons.delete,
                          //     color: Colors.blue,
                          //   ),
                          // ),
                          isEditing == false
                              ? Text(data.docs[index]['label'])
                              : Flexible(
                                  child: CustomTextFormField(
                                    controller: editLabel,
                                  ),
                                ),
                          const Spacer(),

                          IconButton(
                            onPressed: () {
                              // setState(() {
                              //   isEditing = !isEditing;
                              // });
                              // if (isEditing == true) {
                              //   editDataToDB(data, index);
                              // }
                            },
                            icon: Icon(
                              isEditing == false ? Icons.edit : Icons.check,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addDataToDB() {
    ref.add({
      'label': label.text,
      'createdAt': DateTime.now(),
      // 'isDeleted': false,
    });
  }

  void editDataToDB(QuerySnapshot<Object?> data, int index) {
    data.docs[index].reference.update({
      'label': editLabel.text,
    });
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
  final IconButton? icon;
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
      decoration: decoration ??
          InputDecoration(
            contentPadding: contentPadding,
            hintText: hint ?? "",
            hintStyle: hintStyle,
            border: InputBorder.none,
            suffixIcon: icon,
          ),
    );
  }
}
