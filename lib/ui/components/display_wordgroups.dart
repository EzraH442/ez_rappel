import 'package:flutter/material.dart';
import 'package:ez_rappel/database_utils.dart';

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

Container _styledTextField({
  double? width,
  required TextEditingController controller,
  required int maxLength,
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

Container wordpairRowTextfield({
  required TextEditingController controller,
  required Color textColor,
  required String labelText,
  required void Function() onEditingComplete,
}) {
  return _styledTextField(
      controller: controller,
      maxLength: maxWordgroupNameLength,
      labelText: labelText,
      textColor: textColor,
      onEditingComplete: onEditingComplete);
}

Row wordgroupEditingRow(
    {required TextEditingController nameController,
    required TextEditingController languageOneController,
    required TextEditingController languageTwoController,
    required void Function() handleChange,
    required Color textColor}) {
  return Row(
    children: [
      Expanded(
          flex: 3,
          child: _styledTextField(
              controller: nameController,
              onEditingComplete: handleChange,
              textColor: textColor,
              maxLength: maxWordpairWordLength,
              labelText: "Name")),
      Expanded(
          flex: 1,
          child: _styledTextField(
              controller: languageOneController,
              onEditingComplete: handleChange,
              textColor: textColor,
              maxLength: languageCodeLength,
              labelText: "lang 1")),
      Expanded(
          flex: 1,
          child: _styledTextField(
              controller: languageTwoController,
              onEditingComplete: handleChange,
              textColor: textColor,
              maxLength: languageCodeLength,
              labelText: "lang 2")),
    ],
  );
}

mainTextButton(
    {required void Function() onPressed, required String buttonText}) {
  return TextButton(
      onPressed: onPressed, child: Text(buttonText, style: const TextStyle()));
}

confirmButton({ required void Function() onPressed }) {
  return IconButton(onPressed: onPressed, icon: const Icon(
    Icons.check_circle,
    color: Colors.green
  ));
}

cancelButton({ required void Function() onPressed }) {
  return IconButton(onPressed: onPressed, icon: const Icon(
    Icons.cancel,
    color: Colors.red
  ));
}

addNewButton({ required void Function() onPressed }) {
  return IconButton(onPressed: onPressed, icon: const Icon(
    Icons.add,
    color: Colors.black,
  ));
}