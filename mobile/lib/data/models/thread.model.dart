import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/data/models/message.model.dart';

part 'thread.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class ThreadModel {
  final int? id;
  final String? title;
  final String? description;
  final int? organizationId;
  final int? userId;
  final List<MessageModel>? messages;

  ThreadModel({
    this.id,
    this.title,
    this.description,
    this.organizationId,
    this.userId,
    this.messages,
  });

  factory ThreadModel.fromJson(Map<String, dynamic> json) =>
      _$ThreadModelFromJson(json);

  Map<String, dynamic> toJson() => _$ThreadModelToJson(this);
}
