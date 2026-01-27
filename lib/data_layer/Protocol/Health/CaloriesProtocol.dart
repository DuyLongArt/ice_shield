import 'package:freezed_annotation/freezed_annotation.dart';

// Standard Dart naming convention uses snake_case for file names
part 'CaloriesProtocol.freezed.dart';
part 'CaloriesProtocol.g.dart';

@freezed
abstract class CaloriesProtocol with _$CaloriesProtocol {
  const factory CaloriesProtocol({
    required int calories,
    required int protein,
    required int carbs,
    required int fat,
  }) = _CaloriesProtocol;

  factory CaloriesProtocol.fromJson(Map<String, dynamic> json) =>
      _$CaloriesProtocolFromJson(json);

  // You can keep this as a factory or a static method
  factory CaloriesProtocol.empty() {
    return const CaloriesProtocol(calories: 0, protein: 0, carbs: 0, fat: 0);
  }
}
