import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chatbot_provider.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/chat_input_bar.dart';
import '../../../shared/widgets/app_bottom_nav.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatbotProvider(),
      child: Scaffold(
        appBar: AppBar(title: const Text('AI Assistant')),
        body: Consumer<ChatbotProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.messages.length + (provider.isTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == provider.messages.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return ChatMessageBubble(message: provider.messages[index]);
                    },
                  ),
                ),
                ChatInputBar(onSend: (text) => provider.sendMessage(text)),
              ],
            );
          },
        ),
        bottomNavigationBar: const AppBottomNav(),
      ),
    );
  }
}
