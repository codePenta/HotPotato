import 'package:flutter/material.dart';
import 'package:hot_potato/ui/profile_management/view_models/profile_mangement_viewmodel.dart';
import 'package:provider/provider.dart';

class ManageProfilesWidget extends StatefulWidget {
  const ManageProfilesWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ManageProfilesWidget();
}

class _ManageProfilesWidget extends State<ManageProfilesWidget>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ManageProfilesViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Profile Management")),
      body: Center(
        child: viewModel.availableProfiles.isEmpty
            ? Text("No players added yet")
            : SingleChildScrollView(
                child: LimitedBox(
                  maxHeight: 200,
                  maxWidth: 200,
                  child: ListView.builder(
                    itemCount: viewModel.availableProfiles.length,
                    itemBuilder: (context, index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(
                            viewModel.availableProfiles[index].profileName,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
