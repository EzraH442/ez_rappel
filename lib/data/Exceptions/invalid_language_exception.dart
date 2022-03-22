class InvalidLanguageException implements FormatException {
  final String languageCode;

  @override
  String get message => "$source is an invalid language code";

  @override
  int? get offset => 0;

  @override
  String get source => languageCode;

  InvalidLanguageException(this.languageCode);
}
