import 'package:flutter/material.dart';
import 'package:unbound/common/theme.dart';

ButtonStyle lightExpand = ButtonStyle(
  backgroundColor: MaterialStatePropertyAll(
    white.shade400
  ),
  padding: const MaterialStatePropertyAll(EdgeInsets.all(12)),
  shape: MaterialStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
      side: BorderSide(
        color: white.shade400,
        width: 1
      )
    ),
  ),
  textStyle: MaterialStatePropertyAll(unboundTheme.textTheme.labelLarge)
);

ButtonStyle darkExpand = ButtonStyle(
  backgroundColor: MaterialStatePropertyAll(
    white.shade900
  ),
  padding: const MaterialStatePropertyAll(EdgeInsets.all(12)),
  shape: MaterialStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
  textStyle: MaterialStatePropertyAll(unboundTheme.textTheme.labelLarge!.copyWith(color: white.shade50)),
  elevation: MaterialStateProperty.resolveWith<double>(
    (states) {
    if(states.contains(MaterialState.pressed)) {
      return 10.0;
    }
    return 5.0;
  })
);

ButtonStyle greyExpand = ButtonStyle(
  backgroundColor: const MaterialStatePropertyAll(Color(0xFFE9E9E9)),
  padding: const MaterialStatePropertyAll(EdgeInsets.all(12)),
  shape: MaterialStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
);

ButtonStyle textExpand = ButtonStyle(
  textStyle: MaterialStatePropertyAll(unboundTheme.textTheme.labelLarge),
  iconColor: const MaterialStatePropertyAll(Colors.black),
  padding: const MaterialStatePropertyAll(EdgeInsets.all(12)),
  shape: MaterialStatePropertyAll(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),
);
