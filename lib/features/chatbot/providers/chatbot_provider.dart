import 'package:flutter/material.dart';
import '../../../core/services/blood_bank_service.dart';
import '../../../core/models/blood_bank_model.dart';
import '../logic/intent_engine.dart';
import '../logic/knowledge_base.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final List<BloodBankModel>? banks;

  ChatMessage({required this.text, required this.isUser, this.banks});
}

class ChatbotProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [
    ChatMessage(text: 'Hello! I am the BloodNet assistant. How can I help you today?', isUser: false)
  ];
  List<ChatMessage> get messages => _messages;
  
  bool _isTyping = false;
  bool get isTyping => _isTyping;

  final BloodBankService _bankService = BloodBankService();

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    
    _messages.add(ChatMessage(text: text, isUser: true));
    _isTyping = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1)); // simulate typing

    if (IntentEngine.hasNeedSignal(text)) {
      final bloodType = IntentEngine.extractBloodType(text);
      final gov = IntentEngine.extractGovernorate(text);
      
      if (bloodType != null) {
        final banks = await _bankService.searchBanks(bloodType, gov);
        if (banks.isNotEmpty) {
          _messages.add(ChatMessage(
            text: 'I found ${banks.length} blood bank(s) with $bloodType available${gov != null ? ' in $gov' : ''}:',
            isUser: false,
            banks: banks,
          ));
        } else {
          _messages.add(ChatMessage(text: 'Sorry, I couldn\'t find any banks with $bloodType right now.', isUser: false));
        }
      } else {
        _messages.add(ChatMessage(text: 'Please specify the blood type you need (e.g., A+, O-).', isUser: false));
      }
    } else {
      final response = KnowledgeBase.getResponse(text);
      _messages.add(ChatMessage(text: response, isUser: false));
    }
    
    _isTyping = false;
    notifyListeners();
  }
}
