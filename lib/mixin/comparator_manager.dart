import 'package:diacritic/diacritic.dart';

mixin ComparatorManager {
  List<String>? sortByCharacters({
    required List<String> locList,
    String? input,
  }) {
    if (input == null || input.isEmpty) return null;

    final list = List.of(locList);

    list.sort((a, b) {
      final bool aStartsWithPrefix = a.startsWith(
        input.toUpperCase(),
      );
      final bool bStartsWithPrefix = b.startsWith(
        input.toUpperCase(),
      );

      if (aStartsWithPrefix && !bStartsWithPrefix) {
        return -1;
      } else if (!aStartsWithPrefix && bStartsWithPrefix) {
        return 1;
      } else {
        return removeDiacritics(a).compareTo(
          removeDiacritics(b),
        );
      }
    });

    return list;
  }
}
