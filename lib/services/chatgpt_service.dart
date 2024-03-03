import 'package:chat_gpt_demo/env.dart';
import 'package:openai_api/openai_api.dart';

class ChatGPTService {
  final client = OpenaiClient(
      config: OpenaiConfig(
        apiKey: Env.apiKey,
        baseUrl: Env.baseUrl,
        httpProxy: Env.httpProxy
      )
  );

  Future<ChatCompletionResponse> sendChat(String content) async {
    final request = ChatCompletionRequest(
        model: Model.gpt3_5Turbo,
        messages: [
          ChatMessage(
              content: content,
              role: ChatMessageRole.user,
          )
        ]
    );
    return await client.sendChatCompletion(request);
  }

  Future streamChat(
    String content, {Function(String text) ? onSuccess}
  ) async {
    final request = ChatCompletionRequest(
        model: Model.gpt3_5Turbo,
        stream: true,
        messages: [
          ChatMessage(
            content: content,
            role: ChatMessageRole.user,
          )
        ]
    );

    return await client.sendChatCompletionStream(
      request,
      onSuccess: (res){
        final text = res.choices.first.delta?.content;
        if (text != null) {
          onSuccess?.call(text);
        }
      }
    );
  }
}