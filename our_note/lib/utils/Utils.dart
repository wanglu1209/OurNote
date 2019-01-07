import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Utils {
  // md5 加密
  static String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  static showLoading(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return SpinKitPumpingHeart(
            color: Theme.of(context).primaryColor,
          );
        });
  }

  static EventBus eventBus;

  static EventBus getEventBus() {
    if (eventBus == null) {
      eventBus = EventBus();
    }
    return eventBus;
  }
}
