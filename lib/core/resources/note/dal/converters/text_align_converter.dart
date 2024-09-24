import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class TextAlignConverter implements JsonConverter<TextAlign, String> {
  const TextAlignConverter();

  @override
  TextAlign fromJson(String json) {
    switch (json) {
      case 'TextAlign.left':
        return TextAlign.left;
      case 'TextAlign.right':
        return TextAlign.right;
      case 'TextAlign.center':
        return TextAlign.center;
      case 'TextAlign.justify':
        return TextAlign.justify;
      case 'TextAlign.start':
        return TextAlign.start;
      case 'TextAlign.end':
        return TextAlign.end;
      default:
        return TextAlign.left;
    }
  }

  @override
  String toJson(TextAlign textAlign) => textAlign.toString();
}
