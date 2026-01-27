// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GeminiModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeminiRequest _$GeminiRequestFromJson(Map<String, dynamic> json) =>
    GeminiRequest(
      contents: (json['contents'] as List<dynamic>)
          .map((e) => Content.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GeminiRequestToJson(GeminiRequest instance) =>
    <String, dynamic>{'contents': instance.contents};

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
  role: json['role'] as String,
  parts: (json['parts'] as List<dynamic>)
      .map((e) => Part.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
  'role': instance.role,
  'parts': instance.parts,
};

Part _$PartFromJson(Map<String, dynamic> json) =>
    Part(text: json['text'] as String);

Map<String, dynamic> _$PartToJson(Part instance) => <String, dynamic>{
  'text': instance.text,
};

GeminiResponse _$GeminiResponseFromJson(Map<String, dynamic> json) =>
    GeminiResponse(
      candidates: (json['candidates'] as List<dynamic>?)
          ?.map((e) => Candidate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GeminiResponseToJson(GeminiResponse instance) =>
    <String, dynamic>{'candidates': instance.candidates};

Candidate _$CandidateFromJson(Map<String, dynamic> json) => Candidate(
  content: json['content'] == null
      ? null
      : Content.fromJson(json['content'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CandidateToJson(Candidate instance) => <String, dynamic>{
  'content': instance.content,
};
