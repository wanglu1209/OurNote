import 'package:flutter/material.dart';

class Constellation {
  int date;
  String name;
  String datetime;
  String all;
  String color;
  String health;
  String love;
  String money;
  int number;
  String qFriend;
  String summary;
  String work;
  String resultcode;
  int errorCode;
  String loveTxt;
  String workTxt;
  int workStar;
  int moneyStar;
  String luckyColor;
  String luckyTime;
  int loveStar;
  String luckyDirection;
  int summaryStar;
  String time;
  String moneyTxt;
  String generalTxt;
  String grxz;
  String luckyNum;
  String dayNotice;
  IconData icon;

  Constellation(
      {this.date,
      this.icon,
      this.name,
      this.datetime,
      this.all,
      this.color,
      this.health,
      this.love,
      this.money,
      this.number,
      this.qFriend,
      this.summary,
      this.work,
      this.resultcode,
      this.errorCode,
      this.loveTxt,
      this.workTxt,
      this.workStar,
      this.moneyStar,
      this.luckyColor,
      this.luckyTime,
      this.loveStar,
      this.luckyDirection,
      this.summaryStar,
      this.time,
      this.moneyTxt,
      this.generalTxt,
      this.grxz,
      this.luckyNum,
      this.dayNotice});

  Constellation.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    name = json['name'];
    datetime = json['datetime'];
    all = json['all'];
    color = json['color'];
    health = json['health'];
    love = json['love'];
    money = json['money'];
    number = json['number'];
    qFriend = json['QFriend'];
    summary = json['summary'];
    work = json['work'];
    resultcode = json['resultcode'];
    errorCode = json['error_code'];
    loveTxt = json['love_txt'];
    workTxt = json['work_txt'];
    workStar = json['work_star'];
    moneyStar = json['money_star'];
    luckyColor = json['lucky_color'];
    luckyTime = json['lucky_time'];
    loveStar = json['love_star'];
    luckyDirection = json['lucky_direction'];
    summaryStar = json['summary_star'];
    time = json['time'];
    moneyTxt = json['money_txt'];
    generalTxt = json['general_txt'];
    grxz = json['grxz'];
    luckyNum = json['lucky_num'];
    dayNotice = json['day_notice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['name'] = this.name;
    data['datetime'] = this.datetime;
    data['all'] = this.all;
    data['color'] = this.color;
    data['health'] = this.health;
    data['love'] = this.love;
    data['money'] = this.money;
    data['number'] = this.number;
    data['QFriend'] = this.qFriend;
    data['summary'] = this.summary;
    data['work'] = this.work;
    data['resultcode'] = this.resultcode;
    data['error_code'] = this.errorCode;
    data['love_txt'] = this.loveTxt;
    data['work_txt'] = this.workTxt;
    data['work_star'] = this.workStar;
    data['money_star'] = this.moneyStar;
    data['lucky_color'] = this.luckyColor;
    data['lucky_time'] = this.luckyTime;
    data['love_star'] = this.loveStar;
    data['lucky_direction'] = this.luckyDirection;
    data['summary_star'] = this.summaryStar;
    data['time'] = this.time;
    data['money_txt'] = this.moneyTxt;
    data['general_txt'] = this.generalTxt;
    data['grxz'] = this.grxz;
    data['lucky_num'] = this.luckyNum;
    data['day_notice'] = this.dayNotice;
    return data;
  }
}
