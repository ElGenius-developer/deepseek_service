part of 'ai_response.dart';


class Choice {
    final int? index;
    final Message? message;
    final dynamic logprobs;
    final String? finishReason;

    Choice({
        this.index,
        this.message,
        this.logprobs,
        this.finishReason,
    });

    factory Choice.fromRawJson(String str) => Choice.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        index: json["index"],
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
        logprobs: json["logprobs"],
        finishReason: json["finish_reason"],
    );

    Map<String, dynamic> toJson() => {
        "index": index,
        "message": message?.toJson(),
        "logprobs": logprobs,
        "finish_reason": finishReason,
    };
}
