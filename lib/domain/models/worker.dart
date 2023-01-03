import 'package:json_annotation/json_annotation.dart';

part 'worker.g.dart';

@JsonSerializable()
class Worker {
  final int id;
  @JsonKey(name: 'username')
  final String userName;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;

  Worker({
    required this.id,
    required this.userName,
    required this.firstName,
    required this.lastName,
  });

  factory Worker.fromJson(Map<String, Object?> json) => _$WorkerFromJson(json);

  Map<String, Object?> toJson() => _$WorkerToJson(this);
}
