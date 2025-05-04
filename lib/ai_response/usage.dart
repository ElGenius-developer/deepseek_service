part of 'ai_response.dart';

class Usage {
    final int? promptTokens;
    final int? completionTokens;
    final int? totalTokens;
    final PromptTokensDetails? promptTokensDetails;
    final CompletionTokensDetails? completionTokensDetails;

    Usage({
        this.promptTokens,
        this.completionTokens,
        this.totalTokens,
        this.promptTokensDetails,
        this.completionTokensDetails,
    });

    factory Usage.fromRawJson(String str) => Usage.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Usage.fromJson(Map<String, dynamic> json) => Usage(
        promptTokens: json["prompt_tokens"],
        completionTokens: json["completion_tokens"],
        totalTokens: json["total_tokens"],
        promptTokensDetails: json["prompt_tokens_details"] == null ? null : PromptTokensDetails.fromJson(json["prompt_tokens_details"]),
        completionTokensDetails: json["completion_tokens_details"] == null ? null : CompletionTokensDetails.fromJson(json["completion_tokens_details"]),
    );

    Map<String, dynamic> toJson() => {
        "prompt_tokens": promptTokens,
        "completion_tokens": completionTokens,
        "total_tokens": totalTokens,
        "prompt_tokens_details": promptTokensDetails?.toJson(),
        "completion_tokens_details": completionTokensDetails?.toJson(),
    };
}
