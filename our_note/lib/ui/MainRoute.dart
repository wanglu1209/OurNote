import 'package:flutter/material.dart';
import 'package:our_note/common/MyIcons.dart';

class MainRoute extends StatefulWidget {
  final List<Tab> tabs = <Tab>[
    Tab(
      child: Icon(
        MyIcons.constellation,
        size: 30.0,
      ),
    ),
    Tab(
      child: Icon(
        MyIcons.memorandum,
        size: 30.0,
      ),
    ),
    Tab(
      child: Icon(
        MyIcons.todo,
        size: 30.0,
      ),
    ),
    Tab(
      child: Icon(
        MyIcons.menses,
        size: 30.0,
      ),
    ),
  ];
  @override
  _MainRouteState createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: widget.tabs.length);
    _tabController.addListener(() {
      print(_tabController.index);
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          // 去掉返回键
          automaticallyImplyLeading: false,
          title: Text('星座运势'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TabBar(
                controller: _tabController,
                indicatorColor: Theme.of(context).primaryColor,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.grey,
                indicatorWeight: 1,
                labelPadding: EdgeInsets.only(bottom: 10.0),
                tabs: widget.tabs,
                isScrollable: false,
              ),
            ),
            Expanded(
              child: TabBarView(
                  controller: _tabController,
                  children: widget.tabs
                      .map((Tab tab) => Center(child: tab.child))
                      .toList()),
            )
          ],
        ));
  }
}
