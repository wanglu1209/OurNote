import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'Constellation.g.dart';

@JsonSerializable()
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

  factory Constellation.fromJson(String text) =>
      _$ConstellationFromJson(json.decode(text));
  Map<String, dynamic> toJson() => _$ConstellationToJson(this);

  Constellation({
    this.date,
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
  });
}
