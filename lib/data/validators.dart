import './Exceptions/invalid_language_exception.dart';
import './Exceptions/invalid_word_exception.dart';
import 'word_pair.dart';
import 'constants.dart';

bool _isLanguageValid(String s) {
  return s.length == languageCodeLength;
}

bool _isWordValid(String s) {
  return s.length <= maxWordpairWordLength;
}

bool isWordpairValid(Wordpair wp) {
  if (!_isLanguageValid(wp.languageOne)) {
    throw InvalidLanguageException(wp.languageOne);
  }
  if (!_isLanguageValid(wp.languageTwo)) {
    throw InvalidLanguageException(wp.languageTwo);
  }
  if (!_isWordValid(wp.wordOne)) {
    throw InvalidWordException(wp.wordOne, InvalidWordException.tooLong);
  }
  if (!_isWordValid(wp.wordTwo)) {
    throw InvalidWordException(wp.wordTwo, InvalidWordException.tooLong);
  }
  return true;
}

bool isImportedWordpairValid(List<String> splitString, Wordpair wp) {
  return isWordpairValid(wp);
}
