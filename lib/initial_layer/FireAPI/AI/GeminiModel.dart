import 'package:json_annotation/json_annotation.dart';

part 'GeminiModel.g.dart';

// --- REQUEST MODELS ---

@JsonSerializable()
class GeminiRequest {
  final List<Content> contents;

  GeminiRequest({required this.contents});

  factory GeminiRequest.fromJson(Map<String, dynamic> json) => _$GeminiRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GeminiRequestToJson(this);
}

@JsonSerializable()
class Content {
  final String role;
  final List<Part> parts;

  Content({required this.role, required this.parts});

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

@JsonSerializable()
class Part {
  final String text;

  Part({required this.text});

  factory Part.fromJson(Map<String, dynamic> json) => _$PartFromJson(json);
  Map<String, dynamic> toJson() => _$PartToJson(this);
}

// --- RESPONSE MODELS ---

@JsonSerializable()
class GeminiResponse {
  final List<Candidate>? candidates;

  GeminiResponse({this.candidates});

  factory GeminiResponse.fromJson(Map<String, dynamic> json) => _$GeminiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GeminiResponseToJson(this);
}

@JsonSerializable()
class Candidate {
  final Content? content;

  Candidate({this.content});

  factory Candidate.fromJson(Map<String, dynamic> json) => _$CandidateFromJson(json);
  Map<String, dynamic> toJson() => _$CandidateToJson(this);
}