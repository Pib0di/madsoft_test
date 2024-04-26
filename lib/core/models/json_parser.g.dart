// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_parser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonParser _$JsonParserFromJson(Map<String, dynamic> json) => JsonParser(
      (json['payload'] as List<dynamic>)
          .map((e) => Payload.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Payload _$PayloadFromJson(Map<String, dynamic> json) => Payload(
      json['title'] as String,
      (json['remaining_points'] as num).toInt(),
      (json['total_points_count'] as num).toInt(),
      (json['points'] as List<dynamic>)
          .map((e) => Points.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Points _$PointsFromJson(Map<String, dynamic> json) => Points(
      (json['x'] as num).toInt(),
      (json['y'] as num).toInt(),
      json['status'] as String,
    );
