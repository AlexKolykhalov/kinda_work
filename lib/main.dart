import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kinda_work/BLoC/transition_bloc.dart';
import 'package:kinda_work/cards/bloc/cards_bloc.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/login/login_page.dart';

void main() {
  print('***Main***');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('***MyApp***');
    return MultiBlocProvider(
      providers: [
        BlocProvider<TransitionBloc>(create: (context) => TransitionBloc()),
        BlocProvider<CardsBloc>(create: (context) => CardsBloc())
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: cGrey,
          textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),
        ),
        home: LoginPage(),
      ),
    );
  }
}
