import 'package:finance/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.house),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.moneyBillTransfer),
          label: 'Transactions',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.chartBar),
          label: 'Stats',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.gear),
          label: 'Settings',
        ),
      ],
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go(dashboardRoute);
            break;
          case 1:
            context.go(transactionsRoute);
            break;
          case 2:
            context.go(statsRoute);
            break;
          case 3:
            context.go(settingsRoute);
            break;
        }
      },
    );
  }
}
