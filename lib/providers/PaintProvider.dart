import 'package:flutter/material.dart';

class PaintProvider extends ChangeNotifier{
  CustomPaint? _customPaint;
  CustomPainter? _customPainter;

  CustomPaint? get customPaint => _customPaint;


  CustomPainter? get customPainter => _customPainter;




  CustomPaint? _customPaintForWax;
  CustomPainter? _customPainterForWax;
  CustomPaint? _customPaintForWithoutWax;
  CustomPainter? _customPainterForWithoutWax;


  CustomPaint? get customPaintForWax => _customPaintForWax;

  CustomPainter? get customPainterForWax => _customPainterForWax;

  CustomPaint? get customPaintForWithoutWax => _customPaintForWithoutWax;

  CustomPainter? get customPainterForWithoutWax => _customPainterForWithoutWax;
  updateCustomPainter(CustomPaint? paint, CustomPainter? painter)async{
    _customPaint = paint;
    _customPainter = painter;
    notifyListeners();
  }


  updateCustomPainterForWax(CustomPaint? paint, CustomPainter? painter)async{
    _customPaintForWax = paint;
    _customPainterForWax = painter;
    notifyListeners();
  }

  updateCustomPainterForWithoutWax(CustomPaint? paint, CustomPainter? painter)async{
    _customPaintForWithoutWax = paint;
    _customPainterForWithoutWax = painter;
    notifyListeners();
  }


}