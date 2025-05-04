import 'dart:developer';

import 'package:deepseek_service/enums/deepseek_model.dart';
import 'package:deepseek_service/enums/max_token.dart';
import 'package:deepseek_service/ai_response/ai_response.dart';
import 'package:deepseek_service/networking/api_error/api_error_handler.dart';
import 'package:deepseek_service/networking/api_response/api_response.dart';

import 'enums/assistant_role.dart';

export 'package:deepseek_service/enums/deepseek_model.dart';
export 'package:deepseek_service/enums/max_token.dart';
export 'package:deepseek_service/ai_response/ai_response.dart';
export 'package:deepseek_service/networking/api_error/api_error_handler.dart';
export 'package:deepseek_service/networking/api_response/api_response.dart';

export 'enums/assistant_role.dart';

class DeepSeekService {
  final String apiKey;
  static final Dio _dio = Dio();
  static const String apiUrl = 'https://api.deepseek.com/v1/chat/completions';

  DeepSeekService(this.apiKey) {
    // Set headers for the request
    _dio.options.headers = {"Authorization": "Bearer $apiKey", "Content-Type": "application/json"};
  }

  /// Makes a request to the OpenAI API to generate a response given a prompt.
  ///
  /// Parameters:
  /// - [prompt]: The text to generate a response for.
  /// - [role]: The role of the assistant. Defaults to [AssistantRole.medicalExpert].
  /// - [model]: The DeepSeek model to use. Defaults to [DeepSeekModel.deepSeekV3].
  /// - [maxTokens]: The maximum number of tokens to generate. Defaults to [MaxTokens.extended].
  /// - [temperature]: The temperature to use for the request. Defaults to 0.3.
  /// Lower values (0.1 - 0.3) → More focused, predictable, and factual responses.
  /// Higher values (0.7 - 1.0) → More creative, diverse, and random responses.
  Future<ApiResponse<AiResponse>> sendRequest(String prompt,
      {AssistantRole role = AssistantRole.medicalExpert,
      DeepSeekModel? model,
      MaxTokens? maxTokens,
      double temperature = 0.3}) async {
    try {
      final data = {
        "model": model?.modelName ?? DeepSeekModel.deepSeekV3.modelName,
        "messages": [
          {"role": "system", "content": role.systemMessage},
          {"role": "user", "content": prompt}
        ],
        "max_tokens": maxTokens?.value ?? _determineMaxTokens(prompt).value,
        "temperature": temperature,
      };
      Response response = await _dio.post(
        apiUrl,
        data: data
      );

      if (response.statusCode != 200) {
        log("Error on request : ${response.data}");
        final error = ApiErrors.getApiErrorByCode(response.statusCode ?? 0);
        return ApiResponse.failure(ErrorHandler.handle(error));
      }
      final AiResponse aiResponse = AiResponse.fromJson(response.data);
      return ApiResponse.success(aiResponse);
    } catch (e) {
      log("Error on request DeepSeek: $e");
      return ApiResponse.failure(ErrorHandler.handle(e));
    }
  }

  /// Extracts and summarizes the main points from medical records.
  ///
  /// This function analyzes the provided text to identify the medical condition,
  /// main points, and any important data related to the patient.
  ///
  /// Parameters:
  /// - [text]: The medical records text to be analyzed.
  /// - [role]: The role of the assistant. Defaults to [AssistantRole.medicalExpert].
  /// - [model]: The DeepSeek model to use. Defaults to [DeepSeekModel.deepSeekV3].
  /// - [maxTokens]: The maximum number of tokens to generate. Defaults to [MaxTokens.extended].
  /// - [prompt]: Custom prompt for the request. Defaults to a generic prompt for extracting main points.
  ///
  /// Returns a [Future] that completes with an [ApiResponse] containing a [AiResponse].
  Future<ApiResponse<AiResponse>> getMedicalRecordsMainPoints(String text,
      {AssistantRole role = AssistantRole.medicalExpert,
      DeepSeekModel? model,
      MaxTokens? maxTokens,
      String? prompt}) async {
    // Construct the default prompt if not provided
    prompt ??=
        "Check the following information and extract the main medical condition, key points, and critical data:\n$text";

    // Send the request using the constructed or provided prompt
    return sendRequest(prompt, role: role, model: model, maxTokens: maxTokens);
  }

  /// Translate medical data
  ///
  /// This function translates the provided [text] from the original language
  /// to the [targetLanguage].
  ///
  /// Parameters:
  /// - [text]: The text to translate. Must be a [String].
  /// - [targetLanguage]: The target language to translate to. Must be a [String].
  /// - [prompt]: Custom prompt for the request. Defaults to a generic prompt for translating text. Must be a [String].
  /// - [role]: The role of the assistant. Defaults to [AssistantRole.medicalExpert]. Must be an [AssistantRole].
  /// - [model]: The DeepSeek model to use. Defaults to [DeepSeekModel.deepSeekV3]. Must be a [DeepSeekModel].
  /// - [maxTokens]: The maximum number of tokens to generate. Defaults to [MaxTokens.extended]. Must be a [MaxTokens].
  ///
  /// Returns a [Future<ApiResponse<DeepSeekResponse>>] that completes with an [ApiResponse] containing a [AiResponse].
  Future<ApiResponse<AiResponse>> translateMedicalData(String text, String targetLanguage,
      {String? prompt,
      AssistantRole role = AssistantRole.medicalExpert,
      DeepSeekModel? model,
      MaxTokens? maxTokens}) async {
    prompt ??= "Translate the following to $targetLanguage. Output only in $targetLanguage:\n$text";
    return sendRequest(prompt, role: role, model: model, maxTokens: maxTokens);
  }

  /// Summarize medical data
  ///
  /// This function summarizes the provided  for medical visists[text]
  ///
  /// Parameters:
  /// - [text]:  The text to summarize. Must be a [String].
  /// - [prompt]: Custom prompt for the request. Defaults to a generic prompt for translating text. Must be a [String].
  /// - [role]: The role of the assistant. Defaults to [AssistantRole.medicalExpert]. Must be an [AssistantRole].
  /// - [model]: The DeepSeek model to use. Defaults to [DeepSeekModel.DeepSeek4oMini]. Must be a [DeepSeekModel].
  /// - [maxTokens]: The maximum number of tokens to generate. Defaults to [MaxTokens.medium]. Must be a [MaxTokens].
  ///
  /// Returns a [Future<ApiResponse<DeepSeekResponse>>] that completes with an [ApiResponse] containing a [AiResponse].
  Future<ApiResponse<AiResponse>> summarizeMedicalData(
      {String? text,
      String? prompt,
      AssistantRole role = AssistantRole.system,
      MaxTokens? maxTokens,
      DeepSeekModel? model}) async {
    if (prompt == null && text == null) throw Exception("You must provide either prompt or text");

    prompt ??= "Summarize this medical information in bullet points:\n$text";
    return sendRequest("\n$text", role: role, model: model, maxTokens: maxTokens);
  }

  /// Simplify medical data for normal users
  ///
  /// This function takes a medical text and simplifies it.
  ///
  /// Parameters:
  /// - [text]: The medical text to simplify. Must be a [String].
  /// - [role]: The role of the assistant. Defaults to [AssistantRole.medicalExpert]. Must be an [AssistantRole].
  /// - [model]: The DeepSeek model to use. Defaults to [DeepSeekModel.deepSeekV3]. Must be a [DeepSeekModel].
  ///
  /// Returns a [Future<ApiResponse<DeepSeekResponse>>] that completes with an [ApiResponse] containing a [AiResponse].
  Future<ApiResponse<AiResponse>> simplifyMedicalData(String text,
      {AssistantRole role = AssistantRole.medicalExpert, MaxTokens? maxTokens, DeepSeekModel? model}) async {
    return sendRequest("Simplify this medical information for normal user:\n$text",
        role: role, model: model, maxTokens: maxTokens);
  }

  /// Determine the appropriate [MaxTokens] for a given text length
  MaxTokens _determineMaxTokens(String text) {
    final tokenCount = text.length / 4;

    if (tokenCount < 512) return MaxTokens.short;
    if (tokenCount < 1024) return MaxTokens.medium;
    if (tokenCount < 2048) return MaxTokens.long;
    if(tokenCount< 4096) return MaxTokens.extreamFull;
    return MaxTokens.extended;
  }

  ///
}
