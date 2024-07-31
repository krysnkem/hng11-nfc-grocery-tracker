import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocey_tag/screens/main/inventory/inventory.dart';
import 'package:grocey_tag/screens/main/shoppinglist.dart/shoppinglist.dart';

import '../../utils/pop_up.dart';
import '../../widgets/botton_nav_component.dart';
import 'home/home-screen.dart';

class BottomNavigation extends ConsumerStatefulWidget {
  const BottomNavigation({super.key});

  @override
  ConsumerState<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends ConsumerState<BottomNavigation> {
  late Future<bool> checkNfcAvailable;

  @override
  void initState() {
    super.initState();

    ///@Udoh please refactor this part, there should be a non dismissible dialog that is shown
    /// if nfc is not enabled on the device
    // checkNfcAvailable = ref.read(nfcServiceProvider).isNfcAvailable();
    checkNfcAvailable = () async {
      return true;
    }();
  }

  int selectedPage = 0;

  notifyListeners() {
    setState(() {});
  }

  void onNavigationItem(int index) {
    selectedPage = index;
    notifyListeners();
  }

  List<Widget> pages = [
    const Scaffold(
      backgroundColor: Colors.green,
    ),
    Inventory(
      onNavigationItem: (int) {},
    ),
    const ShoppingList(),
    const Scaffold(
      backgroundColor: Colors.yellow,
    ),
  ];

  Future<void> pop({bool? animated}) async {
    await SystemChannels.platform
        .invokeMethod<void>('SystemNavigator.pop', animated);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (val) {
        popUp("Close GroceyTag", pop);
      },
      canPop: false,
      child: FutureBuilder(
        future: checkNfcAvailable,
        builder: (context, snapshot) {
          if (snapshot.data == false) {
            ///@Udoh please refactor this part, there should be a non dismissible dialog that is shown
            /// if nfc is not enabled on the device
            return const Scaffold(
              body: Center(
                child: Text("NFC not available"),
              ),
            );
          }
          return Scaffold(
            body: selectedPage == 0
                ? HomeScreen(onNavigationItem: onNavigationItem)
                : pages[selectedPage],
            bottomNavigationBar: AppBottomNavigationBar(
              onItemSelected: onNavigationItem,
              selectedIndex: selectedPage,
            ),
          );
        },
      ),
    );
  }
}
