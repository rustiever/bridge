import 'package:flutter/widgets.dart';

double dHiegt(context) {
  MediaQueryData md = MediaQuery.of(context);
  return md.size.height;
}

double dWidth(context) {
  MediaQueryData md = MediaQuery.of(context);
  return md.size.width;
}
