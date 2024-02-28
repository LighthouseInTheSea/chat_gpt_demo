import 'package:chat_gpt_demo/states/message_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/message.dart';

class ChatScreen extends HookConsumerWidget {
  ChatScreen({super.key});

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(messageProvider);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Chat", style: TextStyle(
            color: Colors.white
          ),),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return MessageItem(message: messages[index]);
                    },
                    separatorBuilder: (context, index) => const Divider(height: 16,),
                    itemCount: messages.length
                ),
              ),
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: "请输入你想问的问题~",
                  suffixIcon: IconButton(
                    onPressed: (){
                      if(_textController.text.isNotEmpty) {
                        _sendMessage(ref, _textController.text);
                      }
                    },
                    icon: const Icon(Icons.send),
                  )
                ),
              )
            ],
          ),
        ));
  }

  _sendMessage(WidgetRef ref,String content) {
    final message =
    Message(content: content, isUser: true, timestamp: DateTime.now());
    ref.read(messageProvider.notifier).addMessage(message);
    _textController.clear();
  }
}


class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          child: Text(
              message.isUser ? "A" : "GPT",
            style: TextStyle(
              color: Colors.white
            ),
          ),
          backgroundColor: message.isUser ? Colors.blue : Colors.grey,
        ),
        const SizedBox(width: 8,),
        Text(message.content),
      ],
    );
  }
}
