import 'package:deepseek_service/deepseek_service.dart';

Future<void> main(List<String> arguments) async {
  final apiKey = "<YOUR_API_KEY>";
  final service = DeepSeekService(apiKey);

  final result = await service.askQuestion("Can I tak Aspirin with Paracetamol?");
  result.when(
    success: (data) {
      print("Answer: ${data.choices?[0].message?.content}");
    },
    failure: (errorHandler) {
      print("Error: ${errorHandler.apiErrorModel.message}");
    },
  );

  // print("Summary: $result");
  // final visitsList = visits.map((e) => jsonEncode(e.toJson())).toString();
  // final checkData = await service.getMedicalRecordsMainPoints(
  //   visitsList,
  //   role: AssistantRole.friendlyMedicalGuide,
  //   maxTokens: MaxTokens.full
  // );
  // checkData.when(success: (data) async {
  //   print("checkData: ${data.choices?[0].message?.content}");

  //   final summry = await service.summarizeMedicalData(text: data.choices?[0].message?.content ?? '');
  //   summry.whenOrNull(success: (data) async {
  //     print("summry: ${data.choices?[0].message?.content}");
  //     final summary = data.choices?[0].message?.content;
  //     if (summary == null) return;
  //     final translatedSummry = await service.translateMedicalData(summary, 'Arabic');
  //     translatedSummry.whenOrNull(success: (data) {
  //       print("translatedSummry: ${data.choices?[0].message?.content}");
  //     });
  //   });
  // }, failure: (errorHandler) {
  //   print("Error: ${errorHandler.apiErrorModel.message}");
  // });
}
