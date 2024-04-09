import 'package:flutter/material.dart';

ButtonStyle lightExpand = ButtonStyle(
  backgroundColor: const MaterialStatePropertyAll(
    Color(0xFFE4E4E4),
  ),
  fixedSize: const MaterialStatePropertyAll(Size.fromHeight(43.0)),
  shape: MaterialStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
);

ButtonStyle darkExpand = ButtonStyle(
  backgroundColor: const MaterialStatePropertyAll(
    Color(0xFF2E2E2E),
  ),
  fixedSize: const MaterialStatePropertyAll(Size.fromHeight(43.0)),
  shape: MaterialStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
);
