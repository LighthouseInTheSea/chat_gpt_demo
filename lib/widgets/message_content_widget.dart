import 'package:chat_gpt_demo/markdown/latex.dart';
import 'package:chat_gpt_demo/models/message.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/config/all.dart';

class MessageContentWidget  extends StatelessWidget {
  const MessageContentWidget ({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: MarkdownGenerator(
        generators: [latexGenerator],
        inlineSyntaxList: [LatexSyntax()]
      ).buildWidgets(message.content),
    );
  }
}
