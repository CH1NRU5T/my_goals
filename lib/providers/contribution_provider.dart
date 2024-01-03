import 'package:flutter/material.dart';
import 'package:my_goals/models/contribution_model.dart';

class ContributionProvider extends ChangeNotifier {
  List<Contribution>? _contributions;
  List<Contribution>? get contributions => _contributions;
  set contributions(List<Contribution>? contributions) {
    _contributions = contributions;
    notifyListeners();
  }
}
