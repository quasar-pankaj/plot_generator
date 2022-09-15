import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plot_generator/bloc/plotto_bloc.dart';
import 'package:plot_generator/widgets/narrow_screen.dart';

import '../widgets/wide_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlottoBloc bloc = BlocProvider.of<PlottoBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Plotto')),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.new_label,
        ),
        onPressed: () => bloc.add(SkeletonRequested()),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          MediaQueryData mediaQuery = MediaQuery.of(context);
          if (mediaQuery.size.width > 600)
            return WideScreen();
          else
            return NarrowScreen();
        },
      ),
    );
  }
}
