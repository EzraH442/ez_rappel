class InvalidImportedWordpairException implements FormatException {
  final String row;
  final int cause;

  static const invalidLanguage = 1;
  static const extraColumn = 2;

  @override
  String get message => "Unexpected entry";

  @override
  int? get offset => 0;

  @override
  get source => row;

  InvalidImportedWordpairException(this.row, this.cause);
}
