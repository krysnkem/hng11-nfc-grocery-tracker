import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/pop_up.dart';
import '../../widgets/botton_nav_component.dart';
import 'home/home-screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  int selectedPage = 0;

  notifyListeners(){
    setState(() {});
  }

  void onNavigationItem(int index) {
    selectedPage = index;
    notifyListeners();
  }

  List<Widget> pages = [
    Scaffold(backgroundColor: Colors.green,),
    Scaffold(backgroundColor: Colors.green,),
    Scaffold(backgroundColor: Colors.brown,),
    Scaffold(backgroundColor: Colors.yellow,),
  ];

  Future<void> pop({bool? animated}) async {
    await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop', animated);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (val) {
        popUp("Close GroceryTag", pop);
      },
      child: Scaffold(
        body: selectedPage ==0?
        HomeScreen(onNavigationItem: onNavigationItem):
        pages[selectedPage],
        bottomNavigationBar: AppBottomNavigationBar(
        onItemSelected: onNavigationItem,
        selectedIndex: selectedPage,
      ),
      )
    );
  }
}
