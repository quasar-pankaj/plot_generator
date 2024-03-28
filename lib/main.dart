import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plot_generator/bloc/plotto_bloc.dart';

import 'pages/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        splashColor: Colors.lightBlueAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity, colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.blueAccent).copyWith(background: Colors.lightBlue),
      ),
      home: SafeArea(
        child: BlocProvider<PlottoBloc>(
          create: (context) => PlottoBloc(),
          child: HomeScreen(),
        ),
      ),
    );
  }
}
