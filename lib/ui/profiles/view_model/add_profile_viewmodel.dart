import 'package:flutter/material.dart';
import 'package:hot_potato/data/model/profile_model.dart';

class AddProfileViewModel extends ChangeNotifier {
  late List<Profile> playerProfiles = List.empty(growable: true);

  AddProfileViewModel();

  void addProfile(Profile newProfile) {
    playerProfiles.add(newProfile);
  }

  List<Profile> get availableProfiles {
    return playerProfiles;
  }
}
