enum ScenarioType{
  UPPEROCCULSIONFRONTALORIENTATION,
  UPPEROCCULSIONLATERALORIENTATION,
  LOWEROCLUSALPLANEORIENTATION,
  LABIALFULLNESS,
  OUTLINETEETHPOSITION,
  VERTICALRELATION,
  FACEPROFILE,
}

class ScenarioModal{
  String scenarioName;
  ScenarioType scenarioType;

  ScenarioModal({
   required this.scenarioName,
    required this.scenarioType,
  });
}




List<ScenarioModal>  allScenarios = [
  ScenarioModal(scenarioName: 'Upper Occlusion Plane Orientation(Frontal)', scenarioType: ScenarioType.UPPEROCCULSIONFRONTALORIENTATION),
  ScenarioModal(scenarioName: 'Upper Occlusion Plane Orientation(Lateral)', scenarioType: ScenarioType.UPPEROCCULSIONLATERALORIENTATION),
  ScenarioModal(scenarioName: 'Lower Occlusion Plane Orientation(Lateral)', scenarioType: ScenarioType.UPPEROCCULSIONLATERALORIENTATION),
  ScenarioModal(scenarioName: 'Labial Fullness(Naso-labial angle)', scenarioType: ScenarioType.LABIALFULLNESS),
  ScenarioModal(scenarioName: 'Outline Teeth Position', scenarioType: ScenarioType.OUTLINETEETHPOSITION),
  ScenarioModal(scenarioName: 'Vertical Relation', scenarioType: ScenarioType.VERTICALRELATION),
  ScenarioModal(scenarioName: 'Face Profile', scenarioType: ScenarioType.FACEPROFILE),
  // ScenarioModal(scenarioName: 'Scenario Type 8', scenarioType: ScenarioType.SCENARIO8),
  // ScenarioModal(scenarioName: 'Scenario Type 9', scenarioType: ScenarioType.SCENARIO9),

];