import 'package:chat_gpt_demo/widgets/message_content_widget.dart';
import 'package:flutter/material.dart';

import '../models/message.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: message.isUser ? Colors.blue : Colors.grey,
          child: Text(
            message.isUser ? "A" : "GPT",
            style: const TextStyle(
                color: Colors.white
            ),
          ),
        ),
        const SizedBox(width: 8,),
        Flexible(
            child:Container(
              margin: const EdgeInsets.only(right: 48),
              child: MessageContentWidget(message: message)
            )
        )
      ],
    );
  }
}