import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocey_tag/core/constants/app_images.dart';
import 'package:grocey_tag/screens/main/inventory/inventory.dart';
import 'package:grocey_tag/screens/main/shoppinglist.dart/shoppinglist.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:grocey_tag/widgets/apptext.dart';
import 'package:grocey_tag/widgets/empty-state.dart';
import 'package:lottie/lottie.dart';

import '../../services/nfc_service.dart';
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
        popUp("Close GroceryTag", pop);
      },
      canPop: false,
      child: FutureBuilder(
        future: checkNfcAvailable,
        builder: (context, snapshot) {
          if (snapshot.data == false) {
            return const EmptyListState(
                text: "Your Defice is not NFC enabled",
                lottieFile: AppImages.noNFC);
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
