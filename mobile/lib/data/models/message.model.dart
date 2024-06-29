import 'package:json_annotation/json_annotation.dart';

part 'message.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  includeIfNull: false,
)
class MessageModel {
  final int? id;
  final int? threadId;
  final bool? isBot;
  final bool? isUser;
  final String? message;
  final DateTime? createdAt;

  MessageModel({
    this.id,
    this.threadId,
    this.isBot,
    this.isUser,
    this.message,
    this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
