class Audio {
  final String text;

  const Audio({required this.text});

  factory Audio.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'text': String text,
      } =>
        Audio(text: text),
      _ => throw const FormatException('Failed to load returned text from API'),
    };
  }
}
