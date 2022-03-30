import 'package:flutter/material.dart';

class AccentInfoSection extends StatelessWidget {
  const AccentInfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.black,
      )),
      width: 200,
      height: 300,
      child: ListView(children: const [
        Center(
            child: Text(
          "Accent Codes:",
          style: TextStyle(fontSize: 16),
        )),
        _AccentInfoRow(accent: "à", unicode: "U+00E0"),
        _AccentInfoRow(accent: "á", unicode: "U+00E1"),
        _AccentInfoRow(accent: "â", unicode: "U+00E2"),
        _AccentInfoRow(accent: "ã", unicode: "U+00E3"),
        _AccentInfoRow(accent: "ä", unicode: "U+00E4"),
        _AccentInfoRow(accent: "ç", unicode: "U+00E7"),
        _AccentInfoRow(accent: "è", unicode: "U+00E8"),
        _AccentInfoRow(accent: "é", unicode: "U+00E9"),
        _AccentInfoRow(accent: "ê", unicode: "U+00EA"),
        _AccentInfoRow(accent: "ë", unicode: "U+00EB"),
        _AccentInfoRow(accent: "ì", unicode: "U+00EC"),
        _AccentInfoRow(accent: "ñ", unicode: "U+00F1"),
        _AccentInfoRow(accent: "ò", unicode: "U+00F2"),
        _AccentInfoRow(accent: "ó", unicode: "U+00F3"),
        _AccentInfoRow(accent: "ô", unicode: "U+00F4"),
        _AccentInfoRow(accent: "õ", unicode: "U+00F5"),
        _AccentInfoRow(accent: "ö", unicode: "U+00F6"),
        _AccentInfoRow(accent: "ù", unicode: "U+00F9"),
        _AccentInfoRow(accent: "û", unicode: "U+00FB"),
        _AccentInfoRow(accent: "ü", unicode: "U+00FC"),
      ]),
    );
  }
}

class _AccentInfoRow extends StatelessWidget {
  final String accent;
  final String unicode;
  const _AccentInfoRow({
    Key? key,
    required this.accent,
    required this.unicode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(accent),
      trailing: Text(unicode),
    );
  }
}
