import 'package:chat_gpt_demo/models/message.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessageList extends Notifier<List<Message>> {

  void addMessage(Message message) {
    state = [...state, message];
  }

  void upsertMessage(Message partialMessage) {
    final index =
    state.indexWhere((element) => element.id == partialMessage.id);
    if (index == -1) {
      state = [...state, partialMessage];
    } else {
      final msg = state[index];
      state = [...state]..[index] = partialMessage.copyWith(
          content: msg.content + partialMessage.content);
    }
  }

  @override
  List<Message> build() {
    return [];
  }
}

final messageProvider = NotifierProvider<MessageList, List<Message>>(MessageList.new);
