import 'package:dio/dio.dart';
import 'package:ice_shield/initial_layer/Services/HumanEvaluation.dart';
// import 'package:ice_shield/initial_layer/Services/PersonHealthEvaluation.dart';

class GeminiAPICore {
  Dio dio;

  GeminiAPICore(this.dio);
}

class HumanEvaluateService {
  GeminiAPICore? geminiAPICore;

  HumanTargetValues evaluate(HumanInputValues inputValues) {
    // TODO: Implement actual evaluation logic
    return HumanTargetValues(
      humanBodyMetrics: inputValues.humanBodyMetrics,
      bloodTestMetrics: inputValues.bloodTestMetrics,
      caloriesProtocol: inputValues.caloriesProtocol,
    );
  }
}
