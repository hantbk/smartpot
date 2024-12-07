import 'package:flutter/foundation.dart';

class UserInfo with ChangeNotifier {
  String _name;
  String _location;
  String _plant;

  UserInfo({String name = '', String location = '', String plant = ''})
      : _name = name,
        _location = location,
        _plant = plant;

  // Getters
  String get name => _name;
  String get location => _location;
  String get plant => _plant;

  // Setters
  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setLocation(String location) {
    _location = location;
    notifyListeners();
  }

  void setPlant(String plant) {
    _plant = plant;
    notifyListeners();
  }
}
