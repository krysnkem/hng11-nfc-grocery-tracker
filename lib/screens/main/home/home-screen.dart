import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocey_tag/core/constants/app_images.dart';
import 'package:grocey_tag/core/constants/constants.dart';
import 'package:grocey_tag/core/enums/enum.dart';
import 'package:grocey_tag/core/models/item.dart';
import 'package:grocey_tag/providers/activity_provider/activity_provider.dart';
import 'package:grocey_tag/providers/inventory_provider/inventory_provider.dart';
import 'package:grocey_tag/screens/main/add-item/add-item-screen.dart';
import 'package:grocey_tag/screens/main/edit-item/edit-item-screen.dart';
import 'package:grocey_tag/screens/main/home/widgets/activity-list-item.dart';
import 'package:grocey_tag/utils/snack_message.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:grocey_tag/widgets/app_button.dart';
import 'package:grocey_tag/widgets/apptext.dart';
import 'package:grocey_tag/widgets/scan_tag/show_read_button_sheet.dart';

import '../../../widgets/empty-state.dart';
import 'widgets/confirm_should_over_write.dart';
import 'widgets/dashboard_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final Function(int) onNavigationItem;
  const HomeScreen({super.key, required this.onNavigationItem});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<bool> checkNfcAvailable;
  String _itemName = "";
  int _itemQuantity = 0;
  double _price = 0.0;
  double _threshold = 0.0;

  @override
  void initState() {
    super.initState();

    // checkNfcAvailable = ref.read(nfcServiceProvider).isNfcAvailable();
    checkNfcAvailable = () async {
      return true;
    }();
  }

  Future<Item?> _showWriteDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Write to NFC Tag'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Item Name'),
                onChanged: (value) {
                  _itemName = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Item Quantity'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _itemQuantity = int.tryParse(value) ?? 0;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _price = double.tryParse(value) ?? 0.0;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Treshold'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _threshold = double.tryParse(value) ?? 0.0;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final item = Item(
                  name: _itemName,
                  quantity: _itemQuantity,
                  metric: Metric.unit,
                  purchaseDate: DateTime.now(),
                  expiryDate: DateTime(2027),
                  additionalNote: 'Just a test',
                  threshold: _threshold.toInt(),
                );

                Navigator.of(context).pop(item);
              },
              child: const Text('Write'),
            ),
          ],
        );
      },
    );
  }

  showOption() async {
    showReadButtonSheet(context: context).then(
      (result) async {
        log('Result: ${result.status}');
        if (result.status == NfcReadStatus.success) {
          final item = result.data as Item;
          navigationService.navigateToWidget(EditItemScreen(item: item));
          return;
        }

        if (result.status == NfcReadStatus.empty) {
          navigationService.navigateToWidget(const AddItemScreen());
          return;
        }

        if (result.status == NfcReadStatus.notForApp) {
          toast('Data is not for this app');
          final shouldOverwrite = await confirmShouldOverWrite(context);

          if (shouldOverwrite) {
            navigationService.navigateToWidget(const AddItemScreen());
          }
          return;
        }

        if (result.error != null) {
          toast(result.error!);
        }
      },
    );
  }

  bool show = true;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(inventoryProvider);
    final notifier = ref.read(inventoryProvider.notifier);
    return Scaffold(
      appBar: show
          ? AppBar(
              title: const Text("Welcome back!"),
            )
          : null,
      body: show
          ? ListView(
              padding: EdgeInsets.only(top: 0.sp, left: 16.sp, right: 16.sp),
              children: [
                AppText(
                  "Inventory Summary:",
                  size: 16.sp,
                  weight: FontWeight.w500,
                ),
                16.sp.sbH,
                Row(
                  children: [
                    DashBoardCard(
                      count: state.items.length,
                      svgImage: AppImages.inventory,
                      title: "Total items",
                      onTap: () => widget.onNavigationItem(1),
                    ),
                    16.sp.sbW,
                    DashBoardCard(
                        count: notifier.totalRunningLowItemsCount,
                        svgImage: AppImages.trend,
                        title: "Running low",
                        onTap: () => widget.onNavigationItem(2)),
                  ],
                ),
                16.sp.sbH,
                Row(
                  children: [
                    DashBoardCard(
                        count: notifier.totalExpiringItemsCount,
                        svgImage: AppImages.warning,
                        title: "Expiring soon",
                        onTap: () => widget.onNavigationItem(2)),
                    16.sp.sbW,
                    DashNavigateCard(
                      onTap: () => widget.onNavigationItem(1),
                    ),
                  ],
                ),
                30.sp.sbH,
                AppText(
                  "Quick Actions:",
                  size: 16.sp,
                  weight: FontWeight.w500,
                ),
                16.sp.sbH,
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        onTap: showOption,
                        text: "Scan Item Tag",
                      ),
                    ),
                    16.sp.sbW,
                    Expanded(
                      child: AppButton(
                        onTap: () => widget.onNavigationItem(2),
                        isOutline: true,
                        text: "View Shop List",
                      ),
                    ),
                  ],
                ),
                30.sp.sbH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      "Recent Activity:",
                      size: 16.sp,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                16.sp.sbH,
                Builder(builder: (context) {
                  final activities = ref.watch(activityProvider).activities;
                  return activities.isEmpty
                      ? EmptyListState(
                          text: "No recent activity",
                          lottieFile: AppImages.emptyInventory,
                          size: 100.sp,
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: activities.length,
                          itemBuilder: (context, index) {
                            return ActivityHistoryItem(
                              activity: activities[index],
                            );
                          });
                }),
                30.sp.sbH
              ],
            )
          : Padding(
              padding: 16.sp.padA,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppImages.noContent,
                    height: 150.sp,
                    width: 150.sp,
                  ),
                  10.sp.sbH,
                  AppText(
                    "Welcome to GroceyTag",
                    size: 22.sp,
                    isBold: true,
                  ),
                  4.sp.sbH,
                  AppText(
                    "Start managing your groceries\neffectively with NFC tags",
                    align: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  20.sp.sbH,
                  AppButton(
                    onTap: () {},
                    text: "Register Your first Item",
                  )
                ],
              ),
            ),
    );
  }
}
