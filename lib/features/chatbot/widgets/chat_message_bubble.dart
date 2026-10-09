import 'package:flutter/material.dart';
import '../providers/chatbot_provider.dart';
import 'bank_result_card.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: message.isUser ? Colors.red.shade100 : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16).copyWith(
                bottomRight: message.isUser ? const Radius.circular(0) : const Radius.circular(16),
                bottomLeft: !message.isUser ? const Radius.circular(0) : const Radius.circular(16),
              ),
            ),
            child: Text(message.text, style: const TextStyle(fontSize: 16)),
          ),
          if (message.banks != null && message.banks!.isNotEmpty)
            ...message.banks!.map((b) => BankResultCard(bank: b)).toList(),
        ],
      ),
    );
  }
}
