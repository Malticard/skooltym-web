extension StringUtils on String {
  // Camel case format
  String get camelCase {
    List<String> words = this.split(' ');
    String camelCase = words[0].toLowerCase();

    for (int i = 1; i < words.length; i++) {
      String word = words[i];
      camelCase += word[0].toUpperCase() + word.substring(1).toLowerCase();
    }
    return camelCase;
  }

// Snake case format
  String get snakeCase {
    return this.replaceAllMapped(
      RegExp(r'([A-Z]+)'),
      (match) => '_' + match.group(0)!,
    );
  }

// Capitalize first letter
  String get capitalize {
    List<String> words = this.split(' ');
    String camelCase =
        words[0][0].toUpperCase() + words[0].substring(1).toLowerCase();

    for (int i = 1; i < words.length; i++) {
      String word = words[i];
      camelCase +=
          " \t${word[0].toUpperCase() + word.substring(1).toLowerCase()} ";
    }

    return camelCase;
  }
}
