import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:our_note/common/DioFactory.dart';
import 'package:our_note/custom_view/Bubbles.dart';
import 'package:our_note/models/Constellation.dart';

class ConstellationPage extends StatefulWidget {
  @override
  _ConstellationPageState createState() => _ConstellationPageState();
}

class _ConstellationPageState extends State<ConstellationPage>
    with SingleTickerProviderStateMixin {
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.8);
    // requestConstellation();
  }

  requestConstellation() async {
    Response response = await DioFactory.getDio().get(
        'http://web.juhe.cn:8080/constellation/getAll?consName=%E5%8F%8C%E5%AD%90%E5%BA%A7&type=today&key=fa8e09bf39d81506121db976accb3927');

    Constellation constellation = Constellation.fromJson(response.data);
    print(constellation.summary);
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
              margin: EdgeInsets.only(top: 80.0),
              child: Container(
                height: 450,
                color: Colors.transparent,
                child: PageView(
                  controller: _controller,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Card(
                          elevation: 5.0,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.0),
                                child: Text(
                                  '爱情运势',
                                  style: TextStyle(fontSize: 30.0),
                                ),
                              )
                            ],
                          )),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Card(
                          elevation: 5.0,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Test',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          )),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Card(
                          elevation: 5.0,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Test',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          )),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
