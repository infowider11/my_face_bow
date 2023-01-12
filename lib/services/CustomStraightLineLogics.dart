class StraightLineModal{
  double tangent;
  double constant;

  StraightLineModal({
   required this.tangent,
    required this.constant,
  });
}


class CustomPoint{
  double x;
  double y;

  CustomPoint({
    required this.x,
    required this.y,
  });
}

class CustomStraightLineLogics{

  static StraightLineModal getTangentAndConstantBetweenTwoPoints(CustomPoint p1, CustomPoint p2, ){
    print('all the points are(${p1.x}, ${p1.y}) and (${p2.x}, ${p2.y})');

    double m = (p2.y - p1.y) / (p2.x - p1.x);
    double c = p1.y - (m * p1.x);
    return StraightLineModal(tangent: m, constant: c);
  }


  drawLineBetweenTwoPoints(CustomPoint p1, CustomPoint p2,{double extendSizeLeft = 0,double extendSizeRight = 0, }){

    StraightLineModal straightLineModal = getTangentAndConstantBetweenTwoPoints(p1, p2);

  }


}