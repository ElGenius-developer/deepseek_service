part of 'ai_response.dart';
class CompletionTokensDetails {
    final int? reasoningTokens;
    final int? audioTokens;
    final int? acceptedPredictionTokens;
    final int? rejectedPredictionTokens;

    CompletionTokensDetails({
        this.reasoningTokens,
        this.audioTokens,
        this.acceptedPredictionTokens,
        this.rejectedPredictionTokens,
    });

    factory CompletionTokensDetails.fromRawJson(String str) => CompletionTokensDetails.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CompletionTokensDetails.fromJson(Map<String, dynamic> json) => CompletionTokensDetails(
        reasoningTokens: json["reasoning_tokens"],
        audioTokens: json["audio_tokens"],
        acceptedPredictionTokens: json["accepted_prediction_tokens"],
        rejectedPredictionTokens: json["rejected_prediction_tokens"],
    );

    Map<String, dynamic> toJson() => {
        "reasoning_tokens": reasoningTokens,
        "audio_tokens": audioTokens,
        "accepted_prediction_tokens": acceptedPredictionTokens,
        "rejected_prediction_tokens": rejectedPredictionTokens,
    };
}
