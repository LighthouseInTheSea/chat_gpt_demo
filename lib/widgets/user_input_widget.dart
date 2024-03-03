import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../injection.dart';
import '../models/message.dart';
import '../states/chat_ui_state.dart';
import '../states/message_state.dart';

class UserInputWidget extends HookConsumerWidget {
  const UserInputWidget({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatUIState = ref.watch(chatUiProvider);
    final _textController = useTextEditingController();
    return TextField(
      enabled: !chatUIState.requestLoading,
      controller: _textController,
      decoration: InputDecoration(
          hintText: "请输入你想问的问题~",
          suffixIcon: IconButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                _sendMessage(ref, _textController);
              }
            },
            icon: const Icon(Icons.send),
          )),
    );
  }


  _sendMessage(WidgetRef ref, TextEditingController controller) {
    final content = controller.text;
    final message =
    Message(id: uuid.v4(), content: content, isUser: true, timestamp: DateTime.now());
    ref.read(messageProvider.notifier).upsertMessage(message);
    controller.clear();
    _requestChatGPT(ref, content);
  }

  _requestChatGPT(WidgetRef ref, String content) async {
    ref.read(chatUiProvider.notifier).setRequestLoading(true);
    try {
      final id = uuid.v4();
      await chatgpt.streamChat(
          content,
          onSuccess: (text) {
            final message = Message(
              id: id,
              content: text,
              isUser: false,
              timestamp: DateTime.now(),
            );
            ref.read(messageProvider.notifier).upsertMessage(message);
          }
      );
    } catch (err) {
      logger.e(err);
    } finally {
      ref.read(chatUiProvider.notifier).setRequestLoading(false);
    }
  }
}
