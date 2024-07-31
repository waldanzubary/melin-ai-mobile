class Post {
  final String id;
  final List<Message> messages;
  final Usage usage;

  Post({
    required this.id,
    required this.messages,
    required this.usage,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    var choicesFromJson = json['choices'] as List? ?? [];
    List<Message> messageList = choicesFromJson
        .map((choice) => Message.fromJson(choice['message']))
        .toList();

    return Post(
      id: json['id'] ?? '',
      messages: messageList,
      usage: Usage.fromJson(json['usage'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'choices': messages.map((message) => {'message': message.toJson()}).toList(),
      'usage': usage.toJson(),
    };
  }
}

class Message {
  final String content;
  final String role;

  Message({
    required this.content,
    required this.role,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['content'] ?? '',
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'role': role,
    };
  }
}

class Usage {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;

  Usage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory Usage.fromJson(Map<String, dynamic> json) {
    return Usage(
      promptTokens: json['prompt_tokens'] ?? 0,
      completionTokens: json['completion_tokens'] ?? 0,
      totalTokens: json['total_tokens'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prompt_tokens': promptTokens,
      'completion_tokens': completionTokens,
      'total_tokens': totalTokens,
    };
  }
}
