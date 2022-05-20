class InvalidCSVHeaderException implements FormatException {
  final String row;
  @override
  String get message => "Invalid header row";

  @override
  int? get offset => 0;

  @override
  get source => "";

  InvalidCSVHeaderException(this.row);
}
