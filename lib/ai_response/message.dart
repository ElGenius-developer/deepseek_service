part of 'ai_response.dart';

class Message {
    final String? role;
    final String? content;
    final dynamic refusal;

    Message({
        this.role,
        this.content,
        this.refusal,
    });

    factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        role: json["role"],
        content: json["content"],
        refusal: json["refusal"],
    );

    Map<String, dynamic> toJson() => {
        "role": role,
        "content": content,
        "refusal": refusal,
    };
}
