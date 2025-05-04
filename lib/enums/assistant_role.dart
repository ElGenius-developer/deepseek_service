enum AssistantRole {
  medicalExpert,
  friendlyMedicalGuide,
  multilingualMedicalAssistant,
  professionalMedicalAdvisor,
  medicalDataSpecialist,
  system,
  user,
}

extension AssistantRoleExtension on AssistantRole {
  String get systemMessage {
    switch (this) {
      case AssistantRole.medicalExpert:
        return "You are a professional medical AI. Always provide accurate, science-backed medical information.";
      case AssistantRole.friendlyMedicalGuide:
        return "You are a friendly medical assistant who explains health topics in simple terms for everyday users.";
      case AssistantRole.multilingualMedicalAssistant:
        return "You are a multilingual medical assistant. Answer in the same language the user asks.";
      case AssistantRole.professionalMedicalAdvisor:
        return "You are an AI trained to provide expert-level medical insights. Provide detailed answers, but remind users to consult a doctor for a final diagnosis.";
      case AssistantRole.system:
        return "You are an AI assistant.";

      default:
        return "You are an AI assistant specialized in medical data.";
    }
  }
}
