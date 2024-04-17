import "package:flutter/material.dart";
import "package:unbound/common/theme.dart";

InputDecoration textInputDecoration = InputDecoration(
  filled: true,
  fillColor: const Color(0xFFE9E9E9),
  contentPadding: const EdgeInsets.all(12),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(width: 0, style: BorderStyle.none)
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
      width: 1,
      color: purple.shade400
    )
  ),
);
