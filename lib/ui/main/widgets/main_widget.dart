import 'package:flutter/material.dart';
import 'package:hot_potato/ui/math_challenge/view_model/math_challenge_viewmodel.dart';
import 'package:hot_potato/ui/profiles/view_model/add_profile_viewmodel.dart';
import 'package:hot_potato/ui/profiles/widgets/add_profile_widget.dart';
import 'package:hot_potato/ui/timer/view_model/timer_viewmodel.dart';
import 'package:hot_potato/ui/timer/widgets/timer_widget.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidget();
}

class _MainWidget extends State<MainWidget> {
  List<SingleChildWidget> availableProviders = List.empty(growable: true);

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    TimerWidget(),
    AddProfileWidget(),
  ];

  void _onItemTapped(int index, TimerViewModel viewModel) {
    setState(() {
      _selectedIndex = index;
      viewModel.restartTimer();
    });
  }

  @override
  void initState() {
    super.initState();
    availableProviders.add(
      ChangeNotifierProvider(
        create: (context) {
          return TimerViewModel();
        },
      ),
    );
    availableProviders.add(
      ChangeNotifierProvider(
        create: (context) {
          return MathChallengeViewModel();
        },
      ),
    );
    availableProviders.add(
      ChangeNotifierProvider(
        create: (context) {
          return AddProfileViewModel();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var timerViewModel = Provider.of<TimerViewModel>(context);
    return MultiProvider(
      providers: availableProviders,
      child: Scaffold(
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
                title: const Text('Timer'),
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
            ],
          ),
        ),
      ),
    );
  }
}
