import 'package:flutter/material.dart';

class PaintProvider extends ChangeNotifier{
  CustomPaint? _customPaint;
  CustomPainter? _customPainter;

  CustomPaint? get customPaint => _customPaint;


  CustomPainter? get customPainter => _customPainter;

  updateCustomPainter(CustomPaint? paint, CustomPainter? painter)async{
    _customPaint = paint;
    _customPainter = painter;
    notifyListeners();
  }

}