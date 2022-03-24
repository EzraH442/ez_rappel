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
  required double width,
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

Container _wordgroupRowTextField({
  required double width,
  required TextEditingController controller,
  required int maxLength,
  required String labelText,
  required Color textColor,
  required void Function() onEditingComplete,
}) {
  return _styledTextField(
      width: width,
      controller: controller,
      maxLength: maxLength,
      labelText: labelText,
      textColor: textColor,
      onEditingComplete: onEditingComplete);
}

Container wordpairRowTextfield({
  required TextEditingController controller,
  required Color textColor,
  required String labelText,
  required void Function() onEditingComplete,
}) {
  return _styledTextField(
      width: 150,
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
      _wordgroupRowTextField(
          width: 250,
          controller: nameController,
          onEditingComplete: handleChange,
          textColor: textColor,
          maxLength: maxWordpairWordLength,
          labelText: "Name"),
      _wordgroupRowTextField(
          width: 100,
          controller: languageOneController,
          onEditingComplete: handleChange,
          textColor: textColor,
          maxLength: languageCodeLength,
          labelText: "lang 1"),
      _wordgroupRowTextField(
          width: 100,
          controller: languageTwoController,
          onEditingComplete: handleChange,
          textColor: textColor,
          maxLength: languageCodeLength,
          labelText: "lang 2"),
    ],
  );
}

mainTextButton(
    {required void Function() onPressed, required String buttonText}) {
  return TextButton(
      onPressed: onPressed, child: Text(buttonText, style: const TextStyle()));
}
