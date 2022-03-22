class InvalidWordException implements FormatException {
  final String word;
  final int cause;
  InvalidWordException(this.word, this.cause);

  static const int tooLong = 1;

  @override
  String get message {
    if (cause == tooLong) return "$word has more than 50 characters";
    return "";
  }

  @override
  int? get offset {
    if (cause == tooLong) return 50;
    return null;
  }

  @override
  get source => word;
}
