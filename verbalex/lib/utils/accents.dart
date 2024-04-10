/// List of accents that are currently supported by the system
final List<String> ACCENTS = <String>[
  "Arabic",
  "Chinese",
  "Hindi",
];

/// A map of accents to their respective country codes.
/// 
/// It will be used with the [country_flags] library to display the flags in the accent selection screen.
final Map<String, String> ACCENT_CODES = {
  "Arabic": "SA",
  "Chinese": "CN",
  "Hindi": "IN",
};