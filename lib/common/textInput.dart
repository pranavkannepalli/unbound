import "package:flutter/material.dart";
import "package:unbound/common/theme.dart";

InputDecoration textInputDecoration = InputDecoration(
  fillColor: const Color(0xFFE9E9E9),
  filled: true,
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
  ),
  floatingLabelStyle: unboundTheme.textTheme.bodyLarge!.copyWith(fontSize: 12.0),
  labelStyle: unboundTheme.textTheme.bodyLarge!.copyWith(fontSize: 12.0),
  isDense: true,
);
