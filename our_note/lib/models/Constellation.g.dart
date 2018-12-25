// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Constellation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Constellation _$ConstellationFromJson(Map<String, dynamic> json) {
  return Constellation(
      date: json['date'] as int,
      name: json['name'] as String,
      datetime: json['datetime'] as String,
      all: json['all'] as String,
      color: json['color'] as String,
      health: json['health'] as String,
      love: json['love'] as String,
      money: json['money'] as String,
      number: json['number'] as int,
      qFriend: json['qFriend'] as String,
      summary: json['summary'] as String,
      work: json['work'] as String,
      resultcode: json['resultcode'] as String,
      errorCode: json['errorCode'] as int);
}

Map<String, dynamic> _$ConstellationToJson(Constellation instance) =>
    <String, dynamic>{
      'date': instance.date,
      'name': instance.name,
      'datetime': instance.datetime,
      'all': instance.all,
      'color': instance.color,
      'health': instance.health,
      'love': instance.love,
      'money': instance.money,
      'number': instance.number,
      'qFriend': instance.qFriend,
      'summary': instance.summary,
      'work': instance.work,
      'resultcode': instance.resultcode,
      'errorCode': instance.errorCode
    };
