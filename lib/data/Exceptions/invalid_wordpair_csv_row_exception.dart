class InvalidImportedWordpairException implements FormatException {
  final String row;
  final int cause;

  static const invalidLanguage = 1;
  static const extraColumn = 2;

  @override
  // TODO: implement message
  String get message => "Unexpected ";

  @override
  // TODO: implement offset
  int? get offset => throw UnimplementedError();

  @override
  // TODO: implement source
  get source => throw UnimplementedError();

  InvalidImportedWordpairException(this.row, this.cause);
}
