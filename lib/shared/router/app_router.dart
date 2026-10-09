import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/blood_banks/screens/blood_banks_screen.dart';
import '../../features/blood_banks/screens/bank_detail_screen.dart';
import '../../features/blood_banks/screens/banks_map_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/emergency/screens/emergency_screen.dart';
import '../../features/chatbot/screens/chatbot_screen.dart';
import '../../features/admin/screens/admin_dashboard_screen.dart';
import '../../features/admin/screens/add_edit_bank_screen.dart';
import '../../features/admin/screens/manage_requests_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/profile/screens/edit_profile_screen.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  /// Takes the AuthProvider so the router re-evaluates `redirect`
  /// whenever the user logs in / out (refreshListenable).
  static GoRouter createRouter(AuthProvider authProvider) => GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    refreshListenable: authProvider,
    redirect: (BuildContext context, GoRouterState state) {
      final isLoggedIn = authProvider.currentUser != null;
      final isAdmin = authProvider.currentUser?.isAdmin ?? false;

      final protectedRoutes = ['/dashboard', '/profile', '/profile/edit'];
      final adminRoutes = ['/admin', '/admin/bank', '/admin/requests'];
      final authRoutes = ['/login', '/register'];

      final location = state.matchedLocation;

      // Redirect logged-in users away from auth screens
      if (authRoutes.contains(location) && isLoggedIn) return '/';

      // Redirect unauthenticated users away from protected screens
      if (protectedRoutes.any((r) => location.startsWith(r)) && !isLoggedIn) {
        return '/login';
      }

      // Redirect non-admins away from admin screens
      if (adminRoutes.any((r) => location.startsWith(r)) && !isAdmin) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/banks',
        builder: (context, state) => const BloodBanksScreen(),
        routes: [
          GoRoute(
            path: 'map',
            builder: (context, state) => const BanksMapScreen(),
          ),
          GoRoute(
            path: ':bankId',
            builder: (context, state) => BankDetailScreen(
              bankId: state.pathParameters['bankId']!,
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/emergency',
        builder: (context, state) => const EmergencyScreen(),
      ),
      GoRoute(
        path: '/chatbot',
        builder: (context, state) => const ChatbotScreen(),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminDashboardScreen(),
        routes: [
          GoRoute(
            path: 'bank',
            builder: (context, state) {
              final bankId = state.uri.queryParameters['bankId'];
              return AddEditBankScreen(bankId: bankId);
            },
          ),
          GoRoute(
            path: 'requests',
            builder: (context, state) => const ManageRequestsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
        routes: [
          GoRoute(
            path: 'edit',
            builder: (context, state) => const EditProfileScreen(),
          ),
        ],
      ),
    ],
  );
}

