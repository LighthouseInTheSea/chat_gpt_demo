import 'package:chat_gpt_demo/widgets/user_input_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


import 'chat_message_list.dart';

class ChatScreen extends HookConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(
            "Chat",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                // 聊天消息列表
                child: ChatMessageList(),
              ),
              // 输入框
              UserInputWidget()
            ],
          ),
        ));
  }
}
