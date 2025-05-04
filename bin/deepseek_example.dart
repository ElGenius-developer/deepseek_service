import 'dart:convert';

import 'package:deepseek_service/deepseek_service.dart';

import 'visits/visits_list.dart';

Future<void> main(List<String> arguments) async {
  final apiKey = "<YOUR_API_KEY>";
  final service = DeepSeekService(apiKey);
  // final result = await service.summarizeMedicalData(visits.map((e) => e.toJson()).toString());

  // print("Summary: $result");
  final visitsList = visits.map((e) => jsonEncode(e.toJson())).toString();
  final checkData = await service.getMedicalRecordsMainPoints(
    visitsList,
    role: AssistantRole.friendlyMedicalGuide,
    maxTokens: MaxTokens.full
  );
  checkData.when(success: (data) async {
    print("checkData: ${data.choices?[0].message?.content}");

    final summry = await service.summarizeMedicalData(text: data.choices?[0].message?.content ?? '');
    summry.whenOrNull(success: (data) async {
      print("summry: ${data.choices?[0].message?.content}");
      final summary = data.choices?[0].message?.content;
      if (summary == null) return;
      final translatedSummry = await service.translateMedicalData(summary, 'Arabic');
      translatedSummry.whenOrNull(success: (data) {
        print("translatedSummry: ${data.choices?[0].message?.content}");
      });
    });
  }, failure: (errorHandler) {
    print("Error: ${errorHandler.apiErrorModel.message}");
  });
}
