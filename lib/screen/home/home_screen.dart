import 'package:flutter/material.dart';
import 'package:himpunan_app/screen/main-tabs/notification_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../main-tabs/beranda_screen.dart';
import '../main-tabs/auth_screen.dart';
import '../../core/constant/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PersistentTabController _controller;
  // final int inactive = 0;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 1);
  }

  List<Widget> _buildScreens() {
    return [
      const NotificationScreen(),
      const BerandaScreen(),
      const AuthScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      // beranda
      PersistentBottomNavBarItem(
        icon: Padding(
          padding: EdgeInsets.only(top: 8),
          child:
              // SvgPicture.asset(
              //   'assets/icons/ic_report.svg',
              //   height: 50,
              //   width: 50,
              // ),
              Icon(Icons.notifications, size: 35),
        ),
        title: "Notifikasi",
        activeColorPrimary: AppColors.biru,
        // activeColorPrimary: Colors.black,
        inactiveColorPrimary: AppColors.grey,
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 2,
        ),
      ),
      // notification
      PersistentBottomNavBarItem(
        // opacity: 4,
        icon: Container(
          // width: 120,
          decoration: BoxDecoration(
            border: Border.all(
              color: _controller.index == 1
                  ? AppColors.white
                  : Colors.transparent,
              width: 3,
            ),
            shape: BoxShape.circle,
            gradient: _controller.index == 1
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.biru, AppColors.hijauTosca],
                  ) // background biru saat aktif
                : LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.white, AppColors.white],
                  ),
          ),
          padding: const EdgeInsets.all(8),
          // width: 70,
          child: Icon(
            Icons.home,
            size: 40,
            color: _controller.index == 1 ? AppColors.white : AppColors.grey,
          ),
        ),
        title: "",
        activeColorPrimary: Colors.transparent,
        inactiveColorPrimary: Colors.transparent,
      ),

      /// Auth
      PersistentBottomNavBarItem(
        icon: const Padding(
          padding: EdgeInsets.only(top: 8),
          child: Icon(Icons.person, size: 35),
        ),
        title: "Auth",
        activeColorPrimary: AppColors.biru,
        inactiveColorPrimary: AppColors.grey,
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 2,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineToSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      onItemSelected: (index) {
        setState(() {
          _controller.index = index;
        });
      },
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      navBarHeight: kBottomNavigationBarHeight * 1.3,
      navBarStyle: NavBarStyle.style15,
      // margin: const EdgeInsets.only(bottom: 10),
    );
  }
}
