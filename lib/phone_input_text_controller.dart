import 'package:flutter/material.dart';

class PhoneInputTextController extends TextEditingController {
  PhoneInputTextController(
      {String text, this.pattern, @required this.onCompleted})
      : super(text: text) {
    this.text = '';
    this.addListener(() {
      var pre = this._lastString;
      if (this.text.length > pre.length) {
        _addFormater(pre, this.text[this.text.length - 1]);
      } else if (this.text.length < pre.length) {
        _deleFormater();
      }
    });
  }

  String pattern;
  String _lastString = '';
  int _cursorPos = 0;

  Function onCompleted;

  @override
  void set text(String newText) {
    if (newText.length == pattern.length) {
      onCompleted(newText);
    }

    if (super.text != newText) {
      super.text = newText;
      this.moveCursorToEnd();
    }
  }

  void moveCursorToEnd() {
    var text = this._lastString;
    this.selection = new TextSelection.fromPosition(
        new TextPosition(offset: (text ?? '').length));
  }

  void _addFormater(String pre, String newString) {
    // if _cursorPos is end then fix the text

    if (_cursorPos == pattern.length) {
      this.text = _lastString;
      return;
    }

    var pattrnChar = pattern[_cursorPos];

    if (pattrnChar == '-') {
      this.text = _lastString + '-' + newString;
    } else {
      this.text = _lastString + newString;
    }
    _cursorPos = this.text.length;
    _lastString = this.text;
  }

  void _deleFormater() {
    if (this.text.length > 0 && this.text[this.text.length - 1] == '-') {
      var tmp = this.text.substring(0, this.text.length - 1);
      this.text = tmp;
    }
    _cursorPos = this.text.length;
    _lastString = this.text;
  }
}
