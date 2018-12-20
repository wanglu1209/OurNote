import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  bool isLoading;

  _LoadingState _loadingState = _LoadingState();

  setIsLoading(bool loading) {
    this.isLoading = loading;
    _loadingState.isLoadingUpdate(isLoading);
  }

  Loading({this.isLoading = false});

  @override
  _LoadingState createState() => _loadingState;
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  isLoadingUpdate(bool isLoading) {
    setState(() {
      if (isLoading) {
        controller.forward().orCancel;
      } else {
        controller.reset();
      }
    });
  }

  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Offstage(
          offstage: !widget.isLoading,
          child: Container(
            constraints: BoxConstraints.expand(),
            color: Colors.black38,
            child: Center(
                child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white),
                ),
                SpinKitPumpingHeart(
                  color: Theme.of(context).primaryColor,
                ),
              ],
            )),
          )),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}
