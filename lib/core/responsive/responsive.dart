import 'package:flutter/widgets.dart';
import 'package:transitops_gis/core/responsive/breakpoints.dart';

class Responsive {
  const Responsive._();

  static bool isTablet(BuildContext context) {
    return MediaQuery.sizeOf(context).shortestSide >= Breakpoints.compact;
  }

  static bool isWide(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= Breakpoints.medium;
  }

  static int gridColumns(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= Breakpoints.expanded) {
      return 4;
    }
    if (width >= Breakpoints.medium) {
      return 3;
    }
    if (width >= Breakpoints.compact) {
      return 2;
    }
    return 1;
  }
}
