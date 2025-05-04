import 'dart:convert';

part 'choice.dart';
part 'completion_token_details.dart';
part 'message.dart';
part 'prompt_token_details.dart';
part 'usage.dart';

class AiResponse {
  final String? id;
  final String? object;
  final int? created;
  final String? model;
  final List<Choice>? choices;
  final Usage? usage;
  final String? serviceTier;
  final String? systemFingerprint;

  AiResponse({
    this.id,
    this.object,
    this.created,
    this.model,
    this.choices,
    this.usage,
    this.serviceTier,
    this.systemFingerprint,
  });

  factory AiResponse.fromRawJson(String str) => AiResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AiResponse.fromJson(Map<String, dynamic> json) => AiResponse(
        id: json["id"],
        object: json["object"],
        created: json["created"],
        model: json["model"],
        choices: json["choices"] == null ? [] : List<Choice>.from(json["choices"]!.map((x) => Choice.fromJson(x))),
        usage: json["usage"] == null ? null : Usage.fromJson(json["usage"]),
        serviceTier: json["service_tier"],
        systemFingerprint: json["system_fingerprint"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "created": created,
        "model": model,
        "choices": choices == null ? [] : List<dynamic>.from(choices!.map((x) => x.toJson())),
        "usage": usage?.toJson(),
        "service_tier": serviceTier,
        "system_fingerprint": systemFingerprint,
      };
}
