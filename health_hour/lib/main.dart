import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_hour/features/auhtenticate/signin/landing_page.dart';
import 'package:health_hour/features/home/bottom_navbar.dart';
import 'package:health_hour/features/onboarding/provider/onboarding_provider.dart';
import 'package:health_hour/features/onboarding/views/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

bool onBoarded = false;

void main() async {
 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final sharedPreferences = await SharedPreferences.getInstance();
  // onBoarded = sharedPreferences.getBool('onBoarded')?? false;
  runApp(ProviderScope(overrides: [
    sharedPreferencesProvider.overrideWithValue(sharedPreferences),
  ], child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completed =
        ref.watch(onboardingRepositoryProvider).onboardingComplete();
    return ScreenUtilInit(
        designSize: const Size(360, 900),
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Health Hour',
            theme: ThemeData(
              //  primaryColor: const Color(0xFF2F195A),
              colorScheme:
                  ColorScheme.fromSeed(seedColor: const Color(0xFF2F195A)),
              appBarTheme: AppBarTheme(
                  backgroundColor: Colors.white,
                  titleTextStyle:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
                  centerTitle: true),
              textTheme: GoogleFonts.plusJakartaSansTextTheme(),
              useMaterial3: true,
            ),
            home: completed? const LandingPage(): const OnboardingPage(),
            // initialRoute: '/',

          );
        });
  }
}
