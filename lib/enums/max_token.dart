enum MaxTokens {
  /// Short responses (e.g., definitions)
  short(50),    
  /// Summaries (e.g., medical report summary)
  medium(150), 
  /// Detailed explanations
  long(300),    
  /// Longer responses
  extended(600), 
  /// Full research reports
  full(1000),
  ///extra full
  extraFull(2000),
  //extream full
  extreamFull(4000);
  

  final int value;
  const MaxTokens(this.value);
}
