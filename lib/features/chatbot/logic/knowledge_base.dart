class KnowledgeBase {
  static String getResponse(String text) {
    final lower = text.toLowerCase();
    if (lower.contains('benefit') || lower.contains('why donate')) {
      return 'Donating blood reduces risk of heart disease, burns calories, and saves lives.';
    } else if (lower.contains('age') || lower.contains('old')) {
      return 'You must be between 18 and 65 years old to donate blood.';
    } else if (lower.contains('weight')) {
      return 'You must weigh at least 50 kg to donate blood.';
    } else if (lower.contains('how often')) {
      return 'You can donate whole blood every 56 days (8 weeks).';
    } else if (lower.contains('hi') || lower.contains('hello')) {
      return 'Hello! I am the BloodNet Assistant. How can I help you today?';
    }
    return 'I am not sure how to answer that. Could you rephrase your question? If you need blood urgently, please type "I need [Blood Type] in [City]".';
  }
}
