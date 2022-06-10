import 'package:flutter/cupertino.dart';

class Utility {
  BuildContext context;

  Utility(this.context): assert (context != null);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
}