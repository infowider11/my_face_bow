enum ScenarioType{
  TWOPARRALLELLINES,
  LOWEROCLUSALORIENTATION,
  LABIALFULLNESS,
  VERTICALRELATION,
  SCENARIO5,
  SCENARIO6,
  SCENARIO7,
  SCENARIO8,
  SCENARIO9,
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
  ScenarioModal(scenarioName: 'Upper Occlusion Plane Orientation(Frontal)', scenarioType: ScenarioType.TWOPARRALLELLINES),
  ScenarioModal(scenarioName: 'Upper Occlusion Plane Orientation(Lateral)', scenarioType: ScenarioType.LOWEROCLUSALORIENTATION),
  ScenarioModal(scenarioName: 'Lower Occlusion Plane Orientation(Lateral)', scenarioType: ScenarioType.LOWEROCLUSALORIENTATION),
  ScenarioModal(scenarioName: 'Labial Fullness(Naso-labial angle)', scenarioType: ScenarioType.VERTICALRELATION),
  ScenarioModal(scenarioName: 'Outline Teeth Position', scenarioType: ScenarioType.SCENARIO5),
  ScenarioModal(scenarioName: 'Vertical Relation', scenarioType: ScenarioType.SCENARIO6),
  ScenarioModal(scenarioName: 'Face Profile', scenarioType: ScenarioType.SCENARIO7),
  // ScenarioModal(scenarioName: 'Scenario Type 8', scenarioType: ScenarioType.SCENARIO8),
  // ScenarioModal(scenarioName: 'Scenario Type 9', scenarioType: ScenarioType.SCENARIO9),

];