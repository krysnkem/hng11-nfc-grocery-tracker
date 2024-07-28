import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocey_tag/utils/widget_extensions.dart';
import 'package:grocey_tag/widgets/apptext.dart';

import '../core/constants/app_images.dart';
import '../core/constants/pallete.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final Function(int) onItemSelected;
  final int selectedIndex;
  const AppBottomNavigationBar({super.key, required this.onItemSelected, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6
          )
        ]
      ),
      margin: const EdgeInsets.all(0),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavigationBarItem(
                  icon: AppImages.home,
                  label: 'Home',
                  isSelected: (selectedIndex == 0),
                  index: 0,
                  onTap: onItemSelected,
                ),
                _NavigationBarItem(
                  icon: AppImages.inventory,
                  label: 'Inventory',
                  isSelected: (selectedIndex == 1),
                  index: 1,
                  onTap: onItemSelected,
                ),
                _NavigationBarItem(
                  icon: AppImages.shopList,
                  label: 'Shop List',
                  isSelected: (selectedIndex == 2),
                  index: 2,
                  onTap: onItemSelected,
                ),
                _NavigationBarItem(
                  icon: AppImages.settings,
                  label: 'Settings',
                  isSelected: (selectedIndex == 3),
                  index: 3,
                  onTap: onItemSelected,
                ),
              ]
          ),
        ),
      ),
    );
  }
}


class _NavigationBarItem extends StatelessWidget {
  _NavigationBarItem({
    Key? key,
    required this.label,
    required this.icon,
    required this.index,
    this.isSelected = false,
    required this.onTap
  }) : super(key: key);

  final String label;
  final String icon;
  final int index;
  final bool isSelected;
  ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          onTap(index);
        },
        child: SizedBox(
          height: 80.sp,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 78.5.sp,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    10.sp.sbH,
                    SvgPicture.asset(icon, height: 24, color: isSelected? primaryColor : blackColor, width: 24.sp),
                    5.sp.sbH,
                    AppText(
                      label,
                      color: isSelected? primaryColor : blackColor,
                      align: TextAlign.center
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}