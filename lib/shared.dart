import 'package:flutter/material.dart';

Text heading(String text, BuildContext context) => Text(text,
    style: Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(fontWeight: FontWeight.w600));
