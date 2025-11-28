import 'package:flutter/material.dart';
import 'package:hot_potato/ui/profile_management/widgets/add_profile_widget.dart';
import 'package:hot_potato/ui/profile_management/widgets/manage_profiles_widget.dart';
import 'package:hot_potato/ui/timer/view_model/timer_viewmodel.dart';
import 'package:hot_potato/ui/timer/widgets/timer_widget.dart';
import 'package:provider/provider.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidget();
}

class _MainWidget extends State<MainWidget> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    TimerWidget(),
    AddProfileWidget(),
    ManageProfilesWidget(),
  ];

  void _onItemTapped(int index, TimerViewModel viewModel) {
    setState(() {
      _selectedIndex = index;
      viewModel.restartTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    var timerViewModel = Provider.of<TimerViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hot potato'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu),
            );
          },
        ),
      ),
      body: _widgetOptions[_selectedIndex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu'),
            ),

            ListTile(
              title: const Text('Game'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0, timerViewModel);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Add player'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1, timerViewModel);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Manage players'),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2, timerViewModel);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
