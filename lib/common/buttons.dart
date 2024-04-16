import 'package:flutter/material.dart';
import 'package:unbound/common/theme.dart';

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

ButtonStyle greyExpand = ButtonStyle(
  backgroundColor: const MaterialStatePropertyAll(Color(0xFFE9E9E9)),
  fixedSize: const MaterialStatePropertyAll(Size.fromHeight(43.0)),
  shape: MaterialStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
);

ButtonStyle textExpand = ButtonStyle(
  textStyle: MaterialStatePropertyAll(unboundTheme.textTheme.bodyLarge!.copyWith(fontSize: 12.0, color: Colors.black)),
  iconColor: const MaterialStatePropertyAll(Colors.black),
  shape: MaterialStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
);
