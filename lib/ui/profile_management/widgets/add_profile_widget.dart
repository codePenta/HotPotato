import 'package:flutter/material.dart';
import 'package:hot_potato/data/model/profile_model.dart';
import 'package:hot_potato/ui/profile_management/view_models/profile_mangement_viewmodel.dart';
import 'package:provider/provider.dart';

class AddProfileWidget extends StatefulWidget {
  const AddProfileWidget({super.key});

  @override
  State<StatefulWidget> createState() => _AddProfileWidget();
}

class _AddProfileWidget extends State<AddProfileWidget>
    with TickerProviderStateMixin {
  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _inputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ManageProfilesViewModel>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(height: 100, width: 300),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nickname", style: const TextStyle(fontSize: 20)),
                  TextField(
                    controller: _inputController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Anakin',
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => _addProfile(context, viewModel),
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  void _addProfile(BuildContext context, ManageProfilesViewModel viewModel) {
    var newProfile = Profile(_inputController.text);
    viewModel.playerProfiles.add(newProfile);
  }
}
