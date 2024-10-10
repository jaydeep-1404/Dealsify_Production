// ignore_for_file: non_constant_identifier_names, file_names, prefer_typing_uninitialized_variables, must_be_immutable
import 'dart:convert';
import 'package:flutter/foundation.dart';

extension UrlExtractors on String {
  /// Extracts the full domain from a URL, including subdomains.
  String get websiteName {
    try {
      final uri = Uri.parse(this);
      String host = uri.host;
      return host;
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return '';
    }
  }
}

extension BoolCheck on bool {
  bool get isTrue => this == true;
  bool get isFalse => this == false;
}

extension DynamicExtensions on dynamic {
  void show() {
    if (kDebugMode) {
      return print(toString());
    }
  }

  void printFormattedJson() {
    if (kDebugMode){
      try {
        final prettyJson = const JsonEncoder.withIndent('  ').convert(this);
        prettyJson.split('\n').forEach((line) => print(line));
      } catch (e) {
        'Error While formatting JSON: $e'.show();
      }
    }
  }

}

extension StringExtensions2 on String? {
  double toDoubleOrDefault() {
    if (this == null || this!.isEmpty) {
      return 0.0;
    }
    return double.tryParse(this!) ?? 0.0;
  }
}

extension StringExtensions on String {

  bool get isValidMail {
    final regex = RegExp(r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])');
    return regex.hasMatch(this);
  }

  bool get isValidGST {
    final RegExp regExp = RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z][1-9A-Z]Z[0-9A-Z]$');
    return regExp.hasMatch(this);
  }

  bool get isValidWebsite {
    final RegExp urlRegExp = RegExp(r"^(http://www\.|https://www\.|http://|https://)?[a-zA-Z0-9]+([\-.][a-zA-Z0-9]+)*\.[a-zA-Z]{2,5}(:[0-9]{1,5})?(/.*)?$");
    return urlRegExp.hasMatch(this);
  }

  String convertMessage() {
    if (isEmpty) {
      return this;
    }
    return substring(0, 1).toUpperCase() + substring(1).toLowerCase();
  }

}
