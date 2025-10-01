import 'package:flutter/material.dart';
import 'package:himpunan_app/bloc/auth/auth_cubit.dart';
import 'core/constant/app_colors.dart';
import 'screen/splash/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<AuthCubit>(create: (_) => AuthCubit())],
      child: MaterialApp(
        title: 'Himpunan App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.hijauTosca,
          scaffoldBackgroundColor: AppColors.white,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
