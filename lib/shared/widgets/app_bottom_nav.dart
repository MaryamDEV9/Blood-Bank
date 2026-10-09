import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    int currentIndex = 0;
    
    if (location.startsWith('/banks')) currentIndex = 1;
    if (location.startsWith('/emergency')) currentIndex = 2;
    if (location.startsWith('/chatbot')) currentIndex = 3;
    if (location.startsWith('/dashboard') || location.startsWith('/admin')) currentIndex = 4;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: AppColors.kRed,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/');
            break;
          case 1:
            context.go('/banks');
            break;
          case 2:
            context.go('/emergency');
            break;
          case 3:
            context.go('/chatbot');
            break;
          case 4:
            context.go('/dashboard');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.local_hospital), label: 'Banks'),
        BottomNavigationBarItem(icon: Icon(Icons.warning), label: 'Emergency'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chatbot'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
