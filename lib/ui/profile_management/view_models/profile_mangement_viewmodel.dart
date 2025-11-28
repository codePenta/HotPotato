import 'package:flutter/material.dart';
import 'package:hot_potato/data/model/profile_model.dart';

class ManageProfilesViewModel extends ChangeNotifier {
  List<Profile> playerProfiles = List.empty(growable: true);

  ManageProfilesViewModel();

  void addProfile(Profile newProfile) {
    playerProfiles.add(newProfile);
  }

  List<Profile> get availableProfiles {
    return playerProfiles;
  }
}
