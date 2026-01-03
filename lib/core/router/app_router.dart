import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hyper_focused/features/auth/presentation/pages/signup_page.dart';
import 'package:hyper_focused/features/auth/presentation/controllers/auth_controller.dart';
import 'package:hyper_focused/features/auth/domain/entities/auth_entity.dart';
import 'package:hyper_focused/features/home/presentation/pages/home_page.dart';
import 'package:hyper_focused/features/settings/presentation/pages/settings_page.dart';
import 'package:hyper_focused/core/presentation/widgets/bottom_nav_bar.dart';
import 'package:hyper_focused/features/auth/presentation/pages/auth_landing_page.dart';
import 'package:hyper_focused/features/auth/presentation/pages/signup_verify_page.dart';
import 'package:hyper_focused/features/auth/presentation/pages/signup_details_page.dart';
import 'package:hyper_focused/features/splash/presentation/pages/splash_page.dart';
import 'package:hyper_focused/features/services/presentation/pages/my_services_page.dart';
import 'package:hyper_focused/features/contacts/presentation/pages/contacts_page.dart';
import 'package:hyper_focused/features/settings/presentation/pages/edit_profile_page.dart';
import 'package:hyper_focused/features/templates/presentation/pages/template_center_page.dart';
import 'package:hyper_focused/features/templates/presentation/pages/edit_template_page.dart';
import 'package:hyper_focused/features/templates/presentation/pages/create_template_page.dart';
import 'package:hyper_focused/features/templates/presentation/pages/create_template_step2_page.dart';
import 'package:hyper_focused/features/templates/presentation/pages/create_template_sub_section_page.dart';
import 'package:hyper_focused/features/templates/presentation/pages/create_template_item_page.dart';
import 'package:hyper_focused/features/templates/presentation/pages/create_template_item_details_page.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/map/presentation/pages/map_page.dart';
import '../../features/report/presentation/pages/report_page.dart';
import '../../features/report/presentation/pages/report_detail_page.dart';
import '../../features/report/presentation/pages/inspection_start_page.dart';
import '../../features/report/presentation/pages/inspection_section_page.dart';
import '../../features/report/presentation/pages/inspection_item_page.dart';
import '../../features/schedule/presentation/pages/schedule_page.dart';
import '../../features/schedule/presentation/pages/create_schedule_page.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  // Use a ValueNotifier to drive the router's refresh logic without rebuilding the router itself.
  // This prevents the router from resetting to 'initialLocation' (splash) on every auth change.
  final authStateNotifier = ValueNotifier<AsyncValue<AuthEntity?>>(const AsyncLoading());
  
  ref.onDispose(authStateNotifier.dispose);

  ref.listen(
    authControllerProvider,
    (_, next) {
      authStateNotifier.value = next;
    },
    fireImmediately: true,
  );

  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final shellNavigatorKey = GlobalKey<NavigatorState>();

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/splash',
    refreshListenable: authStateNotifier,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/landing',
        builder: (context, state) => const AuthLandingPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupPage(),
        routes: [
          GoRoute(
            path: 'verify',
            builder: (context, state) => const SignupVerifyPage(),
          ),
          GoRoute(
            path: 'details',
            builder: (context, state) => const SignupDetailsPage(),
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Scaffold(
            extendBody: true,
            body: navigationShell,
            bottomNavigationBar: BottomNavBar(navigationShell: navigationShell),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/schedule',
                builder: (context, state) => const SchedulePage(),
                routes: [
                  GoRoute(
                    path: 'create',
                    builder: (context, state) => const CreateSchedulePage(),
                    routes: [

                  ],
                ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/report',
                builder: (context, state) => const ReportPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/map',
                builder: (context, state) => const MapPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/report-detail',
        builder: (context, state) => const ReportDetailPage(),
      ),
      GoRoute(
        path: '/inspection-start',
        builder: (context, state) => const InspectionStartPage(),
      ),
      GoRoute(
        path: '/inspection-section',
        builder: (context, state) {
           final extra = state.extra as Map<String, dynamic>?;
           final categoryName = extra?['categoryName'] as String? ?? 'Section';
           return InspectionSectionPage(categoryName: categoryName);
        },
      ),
      GoRoute(
        path: '/inspection-item',
        builder: (context, state) {
           final extra = state.extra as Map<String, dynamic>?;
           final categoryName = extra?['categoryName'] as String? ?? 'Category';
           final sectionName = extra?['sectionName'] as String? ?? 'Section';
           return InspectionItemPage(categoryName: categoryName, sectionName: sectionName);
        },
      ),
      GoRoute(
        path: '/my-services',
        builder: (context, state) => const MyServicesPage(),
      ),
      GoRoute(
        path: '/contacts',
        builder: (context, state) => const ContactsPage(),
      ),
      GoRoute(
        path: '/edit-profile',
        builder: (context, state) => const EditProfilePage(),
      ),
      GoRoute(
        path: '/template-center',
        builder: (context, state) => const TemplateCenterPage(),
      ),
      GoRoute(
        path: '/edit-template',
        builder: (context, state) => const EditTemplatePage(),
      ),
      GoRoute(
        path: '/create-template',
        builder: (context, state) => const CreateTemplatePage(),
        routes: [
          GoRoute(
            path: 'step-2',
            builder: (context, state) => const CreateTemplateStep2Page(),
            routes: [
              GoRoute(
                path: 'sub-sections',
                builder: (context, state) {
                  final extra = state.extra as Map<String, dynamic>?;
                  final categoryName = extra?['categoryName'] as String? ?? 'Category';
                  return CreateTemplateSubSectionPage(categoryName: categoryName);
                },
                routes: [
                  GoRoute(
                    path: 'items',
                    builder: (context, state) {
                      final extra = state.extra as Map<String, dynamic>?;
                      final categoryName = extra?['categoryName'] as String? ?? 'Category';
                      final subCategoryName = extra?['subCategoryName'] as String? ?? 'SubCategory';
                      return CreateTemplateItemPage(
                        categoryName: categoryName,
                        subCategoryName: subCategoryName,
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'details',
                        builder: (context, state) {
                          final extra = state.extra as Map<String, dynamic>?;
                          final categoryName = extra?['categoryName'] as String? ?? 'Category';
                          final subCategoryName = extra?['subCategoryName'] as String? ?? 'SubCategory';
                          final itemName = extra?['itemName'] as String? ?? 'Item';
                          return CreateTemplateItemDetailsPage(
                            categoryName: categoryName,
                            subCategoryName: subCategoryName,
                            itemName: itemName,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final authState = authStateNotifier.value;
      final isLoggedIn = authState.value != null;
      final isLoggingIn = state.uri.path == '/login';
      final isSigningUp = state.uri.path.startsWith('/signup');
      final isLanding = state.uri.path == '/landing';
      final isSplash = state.uri.path == '/splash';

      if (authState.isLoading) {
        return null; // Let it stay wherever it is (likely splash) until loaded
      }

      if (!isLoggedIn && !isLoggingIn && !isSigningUp && !isLanding && !isSplash) {
        return '/splash';
      }

      if (isLoggedIn && (isLoggingIn || isSigningUp || isLanding || isSplash)) {
        return '/';
      }

      return null;
    },
  );
}
