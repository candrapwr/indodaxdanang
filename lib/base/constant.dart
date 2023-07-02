import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:html/parser.dart';

class Constant {
  static String assetImagePath = "assets/images/";
  static bool isDriverApp = false;
  static const String fontsFamily = "Lato";
  static const String fromLogin = "getFromLoginClick";
  static const String homePos = "getTabPos";
  static const int stepStatusNone = 0;
  static const int stepStatusActive = 1;
  static const int stepStatusDone = 2;
  static const int stepStatusWrong = 3;

  static double getPercentSize(double total, double percent) {
    return (percent * total) / 100;
  }

  static backToPrev(BuildContext context) {
    Navigator.of(context).pop();
  }

  static getCurrency(BuildContext context) {
    return "ETH";
  }

  static sendToNext(BuildContext context, String route, {Object? arguments}) {
    if (arguments != null) {
      Navigator.pushNamed(context, route, arguments: arguments);
    } else {
      Navigator.pushNamed(context, route);
    }
  }

  static sendToNextWithRes(BuildContext context, String route,
      {Object? arguments, Function? fun}) {
    if (arguments != null) {
      Navigator.pushNamed(context, route, arguments: arguments).then((value) {
        if (fun != null) {
          fun();
        }
      });
    } else {
      Navigator.pushNamed(context, route).then((value) {
        if (fun != null) {
          fun();
        }
      });
    }
  }

  static double getToolbarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top + kToolbarHeight;
  }

  static double getToolbarTopHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static sendToScreen(Widget widget, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => widget,
    ));
  }

  static backToFinish(BuildContext context) {
    Navigator.of(context).pop();
  }

  static closeApp() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }

  static String dateToStr(String dataIn, String format, {String lang = 'id'}) {
    // 'EEEE, d MMMM yyyy'
    initializeDateFormatting();
    Intl.defaultLocale = lang;
    return DateFormat(format).format(DateTime.parse(dataIn));
  }

  static DateTime strToDate(String dataIn, {String lang = 'id'}) {
    initializeDateFormatting();
    Intl.defaultLocale = lang;
    DateFormat format = DateFormat("d MMM yyyy");
    return format.parse(dataIn);
  }

  static bool strEmpt(input) {
    if (input != null) {
      if (input.toString() != '') {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  static String getStr(input, {String out = '-'}) {
    if (strEmpt(input)) {
      return out;
    } else {
      return input
          .toString()
          .replaceAll('<br> <i class="fa fa-check"></i>', ', ');
    }
  }

  static int getSleep() {
    int max = 3;
    return Random().nextInt(max) + 1;
  }

  static String getRouteIndex(String route) {
    Map routeIndex = {
      '/InboxTndeDetail': '/InboxTnde',
      '/AgendaTndeDetail': '/AgendaTnde',
      '/DetailBerita': '/ListBerita',
    };
    if (routeIndex.containsKey(route)) {
      return routeIndex[route];
    } else {
      return route;
    }
  }

  String htmlToTxt(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  String? getStrRate(int rate) {
    Map<int, String> strRate = {
      0: '- Belum ada ratting -',
      1: '- Sangat Tidak Puas -',
      2: '- Tidak Puas -',
      3: '- Cukup Puas -',
      4: '- Puas -',
      5: '- Sangat Puas -',
    };
    return strRate[rate];
  }
}
