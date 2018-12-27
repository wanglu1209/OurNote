import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:our_note/common/MyIcons.dart';

class TodayConstellationPage extends StatefulWidget {
  @override
  _TodayConstellationPageState createState() => _TodayConstellationPageState();
}

class _TodayConstellationPageState extends State<TodayConstellationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Column(children: <Widget>[
        Card(
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            elevation: 3.0,
            child: Container(
                padding: EdgeInsets.all(15),
                height: ScreenUtil.instance.setHeight(230),
                width: ScreenUtil.instance.setHeight(450),
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
                                Text('4')
                              ],
                            )),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  '契合星座: ',
                                ),
                                Text('射手座')
                              ],
                            )),
                          ],
                        ),
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
                                  '幸运颜色: ',
                                ),
                                Text('天空蓝')
                              ],
                            )),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  '幸运方位: ',
                                ),
                                Text('东南方')
                              ],
                            )),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: ScreenUtil.instance.setHeight(15)),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  '幸运时间: ',
                                ),
                                Text('20:00 - 23:00')
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ))),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Card(
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 3.0,
              child: Container(
                  padding: EdgeInsets.all(15),
                  height: ScreenUtil.instance.setHeight(230),
                  width: ScreenUtil.instance.setHeight(450),
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
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  '幸运方位: ',
                                ),
                                Text('东南方')
                              ],
                            )),
                          ],
                        ),
                      ],
                    ),
                  ))),
        )
      ]),
    );
  }
}
