enum DeepSeekModel {
  deepSeekV3("deepseek-chat"), //The deepseek-chat model points to DeepSeek-V3
  deepseekR1("deepseek-reasoner"), //The deepseek-reasoner model points to DeepSeek-R1.
  ;

  final String modelName;
  const DeepSeekModel(this.modelName);
}
