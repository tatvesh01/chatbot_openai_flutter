class GptAnsResModel {
  GptAnsResModel({
    this.id = '',
    this.object = '',
    this.created = 0,
    this.model = '',
    this.choices = const <Choice>[],
    required this.usage,
  });

  String id;
  String object;
  int created;
  String model;
  List<Choice> choices;
  Usage usage;

  factory GptAnsResModel.fromJson(Map<String, dynamic> json) => GptAnsResModel(
        id: json["id"] ?? "",
        object: json["object"] ?? "",
        created: json["created"] ?? 0,
        model: json["model"] ?? "",
        choices: json["choices"] != null ? List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))) : [],
        usage: json["usage"] != null ? Usage.fromJson(json["usage"]) : Usage(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "created": created,
        "model": model,
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
        "usage": usage.toJson(),
      };
}

class Choice {
  Choice({
    required this.text,
    required this.index,
    this.logprobs,
    required this.finishReason,
  });

  String text;
  int index;
  dynamic logprobs;
  String finishReason;

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        text: json["text"],
        index: json["index"],
        logprobs: json["logprobs"],
        finishReason: json["finish_reason"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "index": index,
        "logprobs": logprobs,
        "finish_reason": finishReason,
      };
}

class Usage {
  Usage({
    this.promptTokens = 0,
    this.completionTokens = 0,
    this.totalTokens = 0,
  });

  int promptTokens;
  int completionTokens;
  int totalTokens;

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
        promptTokens: json["prompt_tokens"] ?? 0,
        completionTokens: json["completion_tokens"] ?? 0,
        totalTokens: json["total_tokens"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "prompt_tokens": promptTokens,
        "completion_tokens": completionTokens,
        "total_tokens": totalTokens,
      };
}
