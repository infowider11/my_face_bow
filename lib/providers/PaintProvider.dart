import 'package:flutter/material.dart';

class PaintProvider extends ChangeNotifier{
  CustomPaint? _customPaint;

  CustomPaint? get customPaint => _customPaint;

  updateCustomPainter(CustomPaint? paint)async{
    _customPaint = paint;
    notifyListeners();
  }

}