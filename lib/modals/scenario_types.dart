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
  ScenarioModal(scenarioName: 'Two Parallel Lines', scenarioType: ScenarioType.TWOPARRALLELLINES),
  ScenarioModal(scenarioName: 'Lower Occlusion plane orientation', scenarioType: ScenarioType.LOWEROCLUSALORIENTATION),
  ScenarioModal(scenarioName: 'Labial Fullness', scenarioType: ScenarioType.LOWEROCLUSALORIENTATION),
  ScenarioModal(scenarioName: 'Vertical Relation', scenarioType: ScenarioType.VERTICALRELATION),
  ScenarioModal(scenarioName: 'Scenario Type 5', scenarioType: ScenarioType.SCENARIO5),
  ScenarioModal(scenarioName: 'Scenario Type 6', scenarioType: ScenarioType.SCENARIO6),
  ScenarioModal(scenarioName: 'Scenario Type 7', scenarioType: ScenarioType.SCENARIO7),
  ScenarioModal(scenarioName: 'Scenario Type 8', scenarioType: ScenarioType.SCENARIO8),
  ScenarioModal(scenarioName: 'Scenario Type 9', scenarioType: ScenarioType.SCENARIO9),

];