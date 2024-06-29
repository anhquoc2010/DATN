// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      id: (json['id'] as num?)?.toInt(),
      threadId: (json['thread_id'] as num?)?.toInt(),
      isBot: json['is_bot'] as bool?,
      isUser: json['is_user'] as bool?,
      message: json['message'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('thread_id', instance.threadId);
  writeNotNull('is_bot', instance.isBot);
  writeNotNull('is_user', instance.isUser);
  writeNotNull('message', instance.message);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  return val;
}
