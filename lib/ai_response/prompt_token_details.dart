part of 'ai_response.dart';

class PromptTokensDetails {
    final int? cachedTokens;
    final int? audioTokens;

    PromptTokensDetails({
        this.cachedTokens,
        this.audioTokens,
    });

    factory PromptTokensDetails.fromRawJson(String str) => PromptTokensDetails.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PromptTokensDetails.fromJson(Map<String, dynamic> json) => PromptTokensDetails(
        cachedTokens: json["cached_tokens"],
        audioTokens: json["audio_tokens"],
    );

    Map<String, dynamic> toJson() => {
        "cached_tokens": cachedTokens,
        "audio_tokens": audioTokens,
    };
}
