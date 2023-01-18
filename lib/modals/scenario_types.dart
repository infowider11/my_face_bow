enum ScenarioType {
  UPPEROCCULSIONFRONTALORIENTATION,
  UPPEROCCULSIONLATERALORIENTATION,
  AMOUNTOFTEETHSHOWING,
  LOWEROCCLUSALFRONTALORIENTATION,
  LOWEROCCLUSALLATERALORIENTATION,
  LABIALFULLNESS,
  OUTLINETEETHPOSITION,
  VERTICALRELATION,
  FACIALPROFILE,
  RECORDINGTHECENTRALRELATION,
}

class ScenarioModal {
  String scenarioName;
  ScenarioType scenarioType;
  List<ScenarioModal> children;

  ScenarioModal(
      {required this.scenarioName,
      required this.scenarioType,
      this.children =const []});
}

List<ScenarioModal> allScenarios = [
  ScenarioModal(
      scenarioName: 'Upper Occlusion Plane Orientation',
      scenarioType: ScenarioType.UPPEROCCULSIONFRONTALORIENTATION,
      children: [
        ScenarioModal(
          scenarioName: 'Frontal',
          scenarioType: ScenarioType.UPPEROCCULSIONFRONTALORIENTATION,
        ),
        ScenarioModal(
          scenarioName: 'Lateral',
          scenarioType: ScenarioType.UPPEROCCULSIONLATERALORIENTATION,
        ),
        ScenarioModal(
          scenarioName: 'Amount Of Teeth Showing',
          scenarioType: ScenarioType.AMOUNTOFTEETHSHOWING,
        ),
      ],
  ),
  ScenarioModal(
    scenarioName: 'Lower Occlusion Plane Orientation',
    scenarioType: ScenarioType.LOWEROCCLUSALFRONTALORIENTATION,
    children: [
      ScenarioModal(
        scenarioName: 'Frontal',
        scenarioType: ScenarioType.LOWEROCCLUSALFRONTALORIENTATION,
      ),
      ScenarioModal(
        scenarioName: 'Lateral',
        scenarioType: ScenarioType.LOWEROCCLUSALLATERALORIENTATION,
      ),
    ]
  ),
  ScenarioModal(
    scenarioName: 'Labial Fullness(Naso-labial angle)',
    scenarioType: ScenarioType.LABIALFULLNESS,
  ),
  ScenarioModal(
    scenarioName: 'Outline Teeth Position',
    scenarioType: ScenarioType.OUTLINETEETHPOSITION,
  ),
  ScenarioModal(
    scenarioName: 'Vertical Relation',
    scenarioType: ScenarioType.VERTICALRELATION,
  ),
  ScenarioModal(
    scenarioName: 'Face Profile',
    scenarioType: ScenarioType.FACIALPROFILE,
  ),
  ScenarioModal(
    scenarioName: 'Face Profile',
    scenarioType: ScenarioType.RECORDINGTHECENTRALRELATION,
  ),
  // ScenarioModal(scenarioName: 'Scenario Type 8', scenarioType: ScenarioType.SCENARIO8),
  // ScenarioModal(scenarioName: 'Scenario Type 9', scenarioType: ScenarioType.SCENARIO9),
];
