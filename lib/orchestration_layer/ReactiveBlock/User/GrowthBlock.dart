import 'dart:async';
import 'package:signals/signals.dart';
import 'package:ice_shield/data_layer/DataSources/local_database/Database.dart';
import 'package:ice_shield/data_layer/Protocol/User/GrowthProtocols.dart';

class GrowthBlock {
  final goals = listSignal<GoalProtocol>([]);
  final habits = listSignal<HabitProtocol>([]);
  final skills = listSignal<SkillProtocol>([]);

  StreamSubscription? _goalsSubscription;
  StreamSubscription? _habitsSubscription;
  StreamSubscription? _skillsSubscription;

  void updateGoals(List<GoalProtocol> data) => goals.value = data;
  void updateHabits(List<HabitProtocol> data) => habits.value = data;
  void updateSkills(List<SkillProtocol> data) => skills.value = data;

  void init(GrowthDAO dao, int personId) {
    _goalsSubscription?.cancel();
    _goalsSubscription = dao.watchGoals(personId).listen((data) {
      updateGoals(
        data
            .map(
              (e) => GoalProtocol(
                goalID: e.goalID,
                personID: e.personID,
                title: e.title,
                description: e.description,
                category: e.category,
                priority: e.priority,
                status: e.status,
                targetDate: e.targetDate,
                completionDate: e.completionDate,
                progressPercentage: e.progressPercentage,
              ),
            )
            .toList(),
      );
    });

    _habitsSubscription?.cancel();
    _habitsSubscription = dao.watchHabits(personId).listen((data) {
      updateHabits(
        data
            .map(
              (e) => HabitProtocol(
                habitID: e.habitID,
                personID: e.personID,
                goalID: e.goalID,
                habitName: e.habitName,
                description: e.description,
                frequency: e.frequency,
                frequencyDetails: e.frequencyDetails,
                targetCount: e.targetCount,
                isActive: e.isActive,
                startedDate: e.startedDate,
              ),
            )
            .toList(),
      );
    });

    _skillsSubscription?.cancel();
    _skillsSubscription = dao.watchSkills(personId).listen((data) {
      updateSkills(
        data
            .map(
              (e) => SkillProtocol(
                skillID: e.skillID,
                personID: e.personID,
                skillName: e.skillName,
                skillCategory: e.skillCategory,
                proficiencyLevel: e.proficiencyLevel.name,
                yearsOfExperience: e.yearsOfExperience,
                description: e.description,
                isFeatured: e.isFeatured,
              ),
            )
            .toList(),
      );
    });
  }

  void dispose() {
    _goalsSubscription?.cancel();
    _habitsSubscription?.cancel();
    _skillsSubscription?.cancel();
  }
}
