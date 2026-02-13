import 'package:ice_shield/data_layer/DataSources/local_database/Database.dart' hide ScoreData;
import 'package:signals/signals.dart';
import 'package:ice_shield/orchestration_layer/ReactiveBlock/Widgets/ScoreData.dart';

class ScoreBlock {
  final _score = signal<ScoreData>(ScoreData.empty());

  ScoreBlock({ScoreData? initialScore}) {
    if (initialScore != null) {
      _score.value = initialScore;
    }
  }

  ScoreData get score => _score.value;
  set score(ScoreData value) => _score.value = value;

  late final averageScore = computed(() {
    final s = _score.value;
    return (s.healthGlobalScore +
            s.socialGlobalScore +
            s.financialGlobalScore +
            s.careerGlobalScore) /
        4;
  });

  // Convenient methods to update individual scores
  void updateHealth(double value) {
    _score.value = _score.value.copyWith(healthGlobalScore: value);
  }

  void updateSocial(double value) {
    _score.value = _score.value.copyWith(socialGlobalScore: value);
  }

  void updateFinancial(double value) {
    _score.value = _score.value.copyWith(financialGlobalScore: value);
  }

  void updateCareer(double value) {
    _score.value = _score.value.copyWith(careerGlobalScore: value);
  }
  void updateScore(ScoreData score) {
    _score.value = score;
  }
  void init(ScoreDAO dao, int personID) {
    final score = dao.watchScoreByPersonID(personID);
   dao.watchScoreByPersonID(personID).listen((data) {
      map(data)=>updateScore(data);
    });
  
  }
  void dispose() {
    _score.dispose();
  }
}
