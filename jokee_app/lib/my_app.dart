import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/screens/home/ui/home_screen.dart';
import 'presentation/screens/home/view_model/home_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZENS',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return CupertinoPageRoute(
                builder: (context) => const HomeScreen());
        }
        return null;
      },
      builder: (context, child) {
        return child ?? const SizedBox();
      },
    );
  }

  static Widget runWidget() {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => HomeBloc(),
      ),
    ], child: const MyApp());
  }
}