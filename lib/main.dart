import 'package:assesment_elt/config/app_router.dart';
import 'package:assesment_elt/config/currency_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:assesment_elt/core/providers/theme_provider.dart'; // Import the theme provider

void main() {
  CurrencyConfig.setCurrencySymbol(
      CurrencySymbol.rupee); // Set the desired currency symbol
  runApp(
      const ProviderScope(child: MyApp())); // Wrap the app with ProviderScope
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the themeProvider to get the current theme
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      routerConfig: AppRouter().router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(), // You can customize the dark theme here
      themeMode: themeMode, // Dynamically change theme using the provider
      debugShowCheckedModeBanner: false, // Disable the debug banner
    );
  }
}



// import 'package:assesment_elt/config/app_router.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       routerConfig: AppRouter().router,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//     );
//   }
// }
