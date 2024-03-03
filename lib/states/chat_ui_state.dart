import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatUiState {
  final bool requestLoading;

  ChatUiState({this.requestLoading = false});
}

class ChatUiStateProvider extends Notifier<ChatUiState> {

  void setRequestLoading(bool requestLoading) {
    state = ChatUiState(requestLoading: requestLoading);
  }
  @override
  ChatUiState build() {
    return ChatUiState();
  }
}

final chatUiProvider = NotifierProvider<ChatUiStateProvider, ChatUiState>(ChatUiStateProvider.new);
