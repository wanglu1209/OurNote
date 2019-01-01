import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:our_note/common/DioFactory.dart';
import 'package:our_note/common/MyIcons.dart';
import 'package:our_note/custom_view/Bubbles.dart';
import 'package:our_note/models/Constellation.dart';
import 'package:our_note/models/ConstellationDetail.dart';
import 'package:our_note/utils/Utils.dart';

class ConstellationPage extends StatefulWidget {
  @override
  _ConstellationPageState createState() => _ConstellationPageState();
}

class _ConstellationPageState extends State<ConstellationPage>
    with AutomaticKeepAliveClientMixin {
  String summaryText = ""; // 整体描述
  double summaryRating = 0; // 整体星
  String luckyNum = ""; // 幸运数字
  String friendConstellation = ""; // 契合星座
  String luckyColor = ""; // 幸运颜色
  String luckyDirection = ""; // 幸运方向
  String luckyTime = ""; // 幸运时间
  double workRating = 0; // 工作星
  double moneyRating = 0; // 金钱星
  double loveRating = 0; // 爱情星
  String workText = ""; // 工作描述
  String moneyText = ""; // 金钱描述
  String loveText = ""; // 爱情描述

  @override
  void initState() {
    super.initState();
    requestConstellation();
    requestConstellationDetail();
  }

  /// 获取事业、金钱、爱情运势
  requestConstellationDetail() async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    String str =
        'needMonth0needTomorrow0needWeek0needYear0showapi_appid84527showapi_timestamp${timestamp}starshuangzi75aeac52a24c4bf0bd3e653d13398aff';
    String sign = Utils.generateMd5(str);
    String url =
        'https://route.showapi.com/872-1?needMonth=0&needTomorrow=0&needWeek=0&needYear=0&showapi_appid=84527&showapi_timestamp=$timestamp&star=shuangzi&showapi_sign=$sign';
    Response response = await DioFactory.getDio().get(url);

    ConstellationDetail constellation =
        ConstellationDetail.fromJson(response.data);
    Day day = constellation.showapiResBody.day;

    luckyNum = day.luckyNum;
    friendConstellation = day.grxz;
    luckyColor = day.luckyColor;
    luckyDirection = day.luckyDirection;
    luckyTime = day.luckyTime;
    workRating = day.workStar.toDouble();
    loveRating = day.loveStar.toDouble();
    moneyRating = day.moneyStar.toDouble();
    workText = day.workTxt;
    loveText = day.loveTxt;
    moneyText = day.moneyTxt;
    setState(() {});
  }

  /// 获取整体运势
  requestConstellation() async {
//    showLoading()
    Response response = await DioFactory.getDio().get(
        'http://web.juhe.cn:8080/constellation/getAll?consName=%E5%8F%8C%E5%AD%90%E5%BA%A7&type=today&key=fa8e09bf39d81506121db976accb3927');
    Constellation constellation =
        Constellation.fromJson(json.decode(response.data));
    if (constellation.all != null) {
      summaryText = constellation.summary ?? "";
      summaryRating = double.parse(constellation.all.substring(0, 1)) / 2;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Bubbles(),
          Container(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                color: Colors.transparent,
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    Container(
                      height: 10,
                    ),
                    Card(
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        elevation: 3.0,
                        child: Container(
                            padding: EdgeInsets.all(15),
                            child: DefaultTextStyle(
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: ScreenUtil.instance.setSp(28),
                                  color: Colors.white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '今日',
                                    style: TextStyle(
                                        fontSize: ScreenUtil.instance.setSp(32),
                                        color: Colors.white),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil.instance.setHeight(15)),
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      children: <Widget>[
                                        Expanded(
                                            child: Row(
                                          children: <Widget>[
                                            Text(
                                              '幸运数字: ',
                                            ),
                                            Text(luckyNum)
                                          ],
                                        )),
                                        Expanded(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              '契合星座: ',
                                            ),
                                            Text(friendConstellation)
                                          ],
                                        )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil.instance.setHeight(8)),
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      children: <Widget>[
                                        Expanded(
                                            child: Row(
                                          children: <Widget>[
                                            Text(
                                              '幸运颜色: ',
                                            ),
                                            Text(luckyColor)
                                          ],
                                        )),
                                        Expanded(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              '幸运方位: ',
                                            ),
                                            Text(luckyDirection)
                                          ],
                                        )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil.instance.setHeight(8)),
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              '幸运时间: ',
                                            ),
                                            Text(luckyTime)
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ))),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Card(
                          color: Color(0xFFCB3C84),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          elevation: 3.0,
                          child: Container(
                              padding: EdgeInsets.all(15),
                              child: DefaultTextStyle(
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: ScreenUtil.instance.setSp(28),
                                    color: Colors.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flex(
                                      direction: Axis.horizontal,
                                      children: <Widget>[
                                        Expanded(
                                            child: Row(
                                          children: <Widget>[
                                            Icon(
                                              MyIcons.smile,
                                              color: Colors.white,
                                            ),
                                            Text('  整体运势')
                                          ],
                                        )),
                                        Container(
                                            child: StarRating(
                                          rating: summaryRating,
                                          color: Colors.white,
                                          size: 18,
                                        )),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: ScreenUtil.instance
                                              .setHeight(15)),
                                      child: Text(summaryText),
                                    )
                                  ],
                                ),
                              ))),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Card(
                          color: Color(0xFF9845B5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          elevation: 3.0,
                          child: Container(
                              padding: EdgeInsets.all(15),
                              child: DefaultTextStyle(
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: ScreenUtil.instance.setSp(28),
                                    color: Colors.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flex(
                                      direction: Axis.horizontal,
                                      children: <Widget>[
                                        Expanded(
                                            child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.work,
                                              color: Colors.white,
                                            ),
                                            Text('  事业运势')
                                          ],
                                        )),
                                        Container(
                                            child: StarRating(
                                          rating: workRating,
                                          color: Colors.white,
                                          size: 18,
                                        )),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: ScreenUtil.instance
                                              .setHeight(15)),
                                      child: Text(workText),
                                    )
                                  ],
                                ),
                              ))),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Card(
                          color: Color(0xFF744CD7),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          elevation: 3.0,
                          child: Container(
                              padding: EdgeInsets.all(15),
                              child: DefaultTextStyle(
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: ScreenUtil.instance.setSp(28),
                                    color: Colors.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flex(
                                      direction: Axis.horizontal,
                                      children: <Widget>[
                                        Expanded(
                                            child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.monetization_on,
                                              color: Colors.white,
                                            ),
                                            Text('  金钱运势')
                                          ],
                                        )),
                                        Container(
                                            child: StarRating(
                                          rating: moneyRating,
                                          color: Colors.white,
                                          size: 18,
                                        )),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: ScreenUtil.instance
                                              .setHeight(15)),
                                      child: Text(moneyText),
                                    )
                                  ],
                                ),
                              ))),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Card(
                          color: Color(0xFF5551F6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          elevation: 3.0,
                          child: Container(
                              padding: EdgeInsets.all(15),
                              child: DefaultTextStyle(
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: ScreenUtil.instance.setSp(28),
                                    color: Colors.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flex(
                                      direction: Axis.horizontal,
                                      children: <Widget>[
                                        Expanded(
                                            child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.favorite,
                                              color: Colors.white,
                                            ),
                                            Text('  爱情运势')
                                          ],
                                        )),
                                        Container(
                                            child: StarRating(
                                          rating: loveRating,
                                          color: Colors.white,
                                          size: 18,
                                        )),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: ScreenUtil.instance
                                              .setHeight(15)),
                                      child: Text(loveText),
                                    )
                                  ],
                                ),
                              ))),
                    ),
                  ]),
                ),
              )),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
