import 'package:indodaxdanang/base/resizer/fetch_pixels.dart';
import 'package:indodaxdanang/base/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:indodaxdanang/base/color_data.dart';
import 'package:indodaxdanang/base/constant.dart';
import 'package:indodaxdanang/services/main_api.dart';
import 'package:indodaxdanang/services/skeleton.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BlankScreen extends StatefulWidget {
  const BlankScreen({Key? key}) : super(key: key);

  @override
  State<BlankScreen> createState() => _BlankScreenState();
}

class _BlankScreenState extends State<BlankScreen> {
  @override
  void initState() {
    super.initState();
    final prov = Provider.of<Api>(context, listen: false);
    prov.getDataIndodax(context);
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
                getToolbar(context, 'DATA INDODAX'),
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
    final prov = Provider.of<Api>(context, listen: true);
    return Expanded(
      flex: 1,
      child: (prov.dataIndodax != null)
          ? dataList(prov.dataIndodax!, 10, prov.isLGeneral)
          : loading(),
    );
  }

  Widget dataList(List<dynamic> data, double defSpace, bool loading) {
    final prov = Provider.of<Api>(context, listen: false);
    return (data.isNotEmpty)
        ? ListView.builder(
            padding:
                EdgeInsets.symmetric(vertical: FetchPixels.getPixelWidth(10)),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      prov.getLoopDetail(context, data[index]['id']);
                    },
                    contentPadding:
                        const EdgeInsets.only(bottom: 10, left: 5, right: 10),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        getCustomFont(
                            NumberFormat.decimalPattern('id_ID').format(
                                (prov.dataIndodaxDetail![data[index]['id']] !=
                                        null)
                                    ? int.tryParse(prov.dataIndodaxDetail![
                                        data[index]['id']]['low'])
                                    : 0),
                            18,
                            Colors.black,
                            2,
                            fontWeight: FontWeight.normal),
                        getCustomFont(
                            (prov.dataIndodaxDetail![data[index]['id']] != null)
                                ? 'Server Time: ${prov.dataIndodaxDetail![data[index]['id']]['server_time']}'
                                : '-',
                            14,
                            const Color.fromARGB(255, 86, 86, 86),
                            2,
                            fontWeight: FontWeight.normal),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.network(
                          data[index]['url_logo_png'],
                          height: FetchPixels.getPixelHeight(50),
                        ),
                      ],
                    ),
                    title: Transform.translate(
                      offset: const Offset(0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getCustomFont(
                              data[index]['description'], 16, Colors.black, 2,
                              fontWeight: FontWeight.bold),
                          getCustomFont(
                              (prov.dataIndodaxDetail![data[index]['id']] !=
                                      null)
                                  ? 'High: ${prov.dataIndodaxDetail![data[index]['id']]['high']}'
                                  : '-',
                              14,
                              const Color.fromARGB(255, 86, 86, 86),
                              2,
                              fontWeight: FontWeight.normal),
                          getCustomFont(
                              (prov.dataIndodaxDetail![data[index]['id']] !=
                                      null)
                                  ? 'Low: ${prov.dataIndodaxDetail![data[index]['id']]['low']}'
                                  : '-',
                              14,
                              const Color.fromARGB(255, 86, 86, 86),
                              2,
                              fontWeight: FontWeight.normal),
                          Container(padding: const EdgeInsets.only(top: 5)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          )
        : noData(context);
  }

  Widget noData(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getVerSpace(FetchPixels.getPixelHeight(40)),
          getCustomFont("Tidak ada data!", 20, Colors.black, 1,
              fontWeight: FontWeight.bold),
          getVerSpace(FetchPixels.getPixelHeight(10)),
          Center(
            child: getCustomFont(
              "Data tidak di temukan silahkan kembali. ",
              16,
              Colors.black,
              2,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
          ),
          getVerSpace(FetchPixels.getPixelHeight(30)),
        ],
      ),
    );
  }

  Widget loading() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: FetchPixels.getPixelWidth(10)),
      itemCount: 3,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
            margin: EdgeInsets.only(
                bottom: FetchPixels.getPixelHeight(10), left: 10, right: 10),
            padding: EdgeInsets.only(
                left: FetchPixels.getPixelWidth(5),
                right: FetchPixels.getPixelWidth(10),
                top: FetchPixels.getPixelHeight(10),
                bottom: FetchPixels.getPixelHeight(10)),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0.0, 4.0)),
                ],
                borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(15))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.only(left: FetchPixels.getPixelWidth(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Skeleton(width: FetchPixels.getPixelWidth(100)),
                        getVerSpace(FetchPixels.getPixelHeight(6)),
                        const Skeleton(),
                        getVerSpace(FetchPixels.getPixelHeight(4)),
                        Row(
                          children: [
                            Skeleton(width: FetchPixels.getPixelWidth(100))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
