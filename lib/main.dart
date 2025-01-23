import 'package:only_tix/presentation/misc/constants.dart';
import 'package:only_tix/presentation/providers/router/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(
    child: MainApp(),
  ));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        physics: const ClampingScrollPhysics(),
      ),
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
              seedColor: brightCyan,
              background: backgroundPage,
              brightness: Brightness.light),
          useMaterial3: true,
          textTheme: TextTheme(
              bodyMedium: GoogleFonts.poppins(color: brightCyan),
              bodyLarge: GoogleFonts.poppins(color: grey),
              labelLarge: GoogleFonts.poppins(color: grey))),
      debugShowCheckedModeBanner: false,
      routeInformationParser: ref.watch(routerProvider).routeInformationParser,
      routeInformationProvider:
          ref.watch(routerProvider).routeInformationProvider,
      routerDelegate: ref.watch(routerProvider).routerDelegate,
    );
  }
}
