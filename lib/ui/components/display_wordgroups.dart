import 'package:flutter/material.dart';

Widget rowFutureBuilder<T>(BuildContext context, Future<List<dynamic>> future,
    Widget Function(List<T>) buildWidget) {
  return FutureBuilder<List>(
      future: future,
      builder: (context, snapshot) => snapshot.hasData
          ? buildWidget(snapshot.data!.cast<T>())
          : const Center(
              child: CircularProgressIndicator(),
            ));
}

Container _StyledTextField({
  double? width,
  int? maxLength,
  required TextEditingController controller,
  required String labelText,
  required Color textColor,
  required void Function() onEditingComplete,
}) {
  return Container(
    width: width,
    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    child: TextField(
      controller: controller,
      maxLength: maxLength,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        labelText: labelText,
      ),
      onEditingComplete: onEditingComplete,
    ),
  );
}

Container WordpairRowTextfield({
  required TextEditingController controller,
  required Color textColor,
  required String labelText,
  required void Function() onEditingComplete,
}) {
  return _StyledTextField(
      controller: controller,
      labelText: labelText,
      textColor: textColor,
      onEditingComplete: onEditingComplete);
}

Row TagEditingRow(
    {required TextEditingController nameController,
    required void Function() handleChange,
    required Color textColor}) {
  return Row(
    children: [
      Expanded(
          flex: 3,
          child: _StyledTextField(
              controller: nameController,
              onEditingComplete: handleChange,
              textColor: textColor,
              labelText: "Name")),
    ],
  );
}

MainTextButton(
    {required void Function() onPressed, required String buttonText}) {
  return TextButton(
      onPressed: onPressed, child: Text(buttonText, style: const TextStyle()));
}

ConfirmButton({required void Function() onPressed}) {
  return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.check_circle, color: Colors.green));
}

CancelButton({required void Function() onPressed}) {
  return IconButton(
      onPressed: onPressed, icon: const Icon(Icons.cancel, color: Colors.red));
}

AddNewButton({required void Function() onPressed}) {
  return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.add,
        color: Colors.black,
      ));
}
