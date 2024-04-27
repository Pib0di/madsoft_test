import 'package:json_annotation/json_annotation.dart';

part 'json_parser.g.dart';

@JsonSerializable(createToJson: false)
class JsonParser {
  final List<Payload> payload;

  JsonParser(this.payload);

  factory JsonParser.fromJson(Map<String, dynamic> json) => _$JsonParserFromJson(json);
}

@JsonSerializable(createToJson: false)
class Payload {
  final String title;
  final int remaining_points;
  final int total_points_count;
  final List<Points> points;

  Payload(
    this.title,
    this.remaining_points,
    this.total_points_count,
    this.points,
  );

  factory Payload.fromJson(Map<String, dynamic> json) => _$PayloadFromJson(json);
}

@JsonSerializable(createToJson: false)
class Points {
  final int x;
  final int y;
  final String status;

  Points(
    this.x,
    this.y,
    this.status,
  );

  factory Points.fromJson(Map<String, dynamic> json) => _$PointsFromJson(json);

  @override
  String toString() {
    return 'Points{x: $x, y: $y, status: $status}';
  }
}
