import 'package:flutter/material.dart';
import 'package:our_note/common/DioFactory.dart';
import 'package:dio/dio.dart';
import 'package:our_note/common/MyIcons.dart';
import 'dart:convert';
import 'package:our_note/models/Constellation.dart';
import 'package:our_note/ui/ConstellationItemPage.dart';

class ConstellationPage extends StatefulWidget {
  @override
  _ConstellationPageState createState() => _ConstellationPageState();
}

class _ConstellationPageState extends State<ConstellationPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tab> tabs = <Tab>[
    Tab(
      child: Icon(
        MyIcons.dot,
        size: 15.0,
      ),
    ),
    Tab(
      child: Icon(
        MyIcons.dot,
        size: 15.0,
      ),
    ),
    Tab(
      child: Icon(
        MyIcons.dot,
        size: 15.0,
      ),
    ),
    Tab(
      child: Icon(
        MyIcons.dot,
        size: 15.0,
      ),
    ),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 4, vsync: this);
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
      margin: EdgeInsets.only(top: 50.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: TabBarView(controller: _tabController, children: <Widget>[
                ConstellationItemPage(title: '爱情运势', progress: 30),
                ConstellationItemPage(title: '工作状况', progress: 40),
                ConstellationItemPage(title: '投资理财', progress: 20),
                ConstellationItemPage(title: '健康指数', progress: 25),
              ]),
            ),
          ),
          Container(
            constraints: BoxConstraints.tight(Size(90, 100)),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Theme.of(context).primaryColor,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorWeight: 1,
              tabs: tabs,
              isScrollable: false,
            ),
          )
        ],
      ),
    );
  }
}
