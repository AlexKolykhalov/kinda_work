import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/login/BLoC/switcher_icon_cubit.dart';
import 'package:kinda_work/login/login.dart';

void main() {
  print('-->Main');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('-->MyApp');
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: cGrey,
        textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SwitcherIconCubit(),
          ),
        ],
        child: LoginPage(),
      ),
    );
  }
}
