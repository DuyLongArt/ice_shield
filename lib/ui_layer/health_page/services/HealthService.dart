import 'package:flutter/foundation.dart';
import 'package:pedometer/pedometer.dart';

class HealthService {
  /// Fetches today's step count using the Pedometer plugin.
  /// Returns 0 if permissions are denied or an error occurs.
  static Future<int> fetchStepCount() async {
    try {
      // Use pedometer stream and get the first event
      final stepCount = await Pedometer.stepCountStream.first.timeout(
        const Duration(seconds: 5),
        onTimeout: () => throw Exception('Pedometer timeout'),
      );
      return stepCount.steps;
    } catch (error) {
      debugPrint("Error fetching steps: $error");
      return 0;
    }
  }
}
