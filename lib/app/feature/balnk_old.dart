import 'package:indodaxdanang/base/resizer/fetch_pixels.dart';
import 'package:indodaxdanang/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:indodaxdanang/base/color_data.dart';
import 'package:indodaxdanang/base/constant.dart';

class BlankScreen extends StatefulWidget {
  const BlankScreen({Key? key}) : super(key: key);

  @override
  State<BlankScreen> createState() => _BlankScreenState();
}

class _BlankScreenState extends State<BlankScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    double defHorSpace = FetchPixels.getDefaultHorSpace(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: defHorSpace);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backGroundColor,
          body: SafeArea(
            child: Column(
              children: [
                getVerSpace(FetchPixels.getPixelHeight(20)),
                getToolbar(context, 'title'),
                dataContent(context, edgeInsets, defHorSpace)
              ],
            ),
          ),
        ),
        onWillPop: () async {
          Constant.backToPrev(context);
          return false;
        });
  }

  Expanded dataContent(
      BuildContext context, EdgeInsets edgeInsets, double defHorSpace) {
    return Expanded(
      flex: 1,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: FetchPixels.getPixelWidth(10)),
        primary: true,
        shrinkWrap: true,
        children: [
          Container(),
        ],
      ),
    );
  }
}
