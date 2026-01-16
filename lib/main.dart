import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hyper_focused/core/router/app_router.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';

import 'package:hyper_focused/core/utils/responsive_size.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Hyper Focused',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      routerConfig: router,
      builder: (context, child) {
        SizeConfig().init(context);
        return child!;
      },
    );
  }
}
