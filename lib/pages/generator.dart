import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plot_generator/pages/conflict.dart';
import 'package:plot_generator/pages/generator_events.dart';
import 'package:plot_generator/pages/outcome.dart';
import 'package:plot_generator/pages/predicate.dart';
import 'package:plot_generator/pages/splash_screen.dart';
import 'package:plot_generator/pages/subject.dart';

import 'generator_bloc.dart';
import 'generator_states.dart';

class Generator extends StatelessWidget {
  const Generator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Subject subject;
    Predicate predicate;
    Outcome outcome;
    List<Conflict> conflicts = [];

    return BlocProvider(
      create: (context) => GeneratorBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Plotto: The Plot Generator',
          ),
        ),
        body: BlocBuilder<GeneratorBloc, GeneratorState>(
          builder: (context, state) {
            if (state is StartState) {
              BlocProvider.of<GeneratorBloc>(context).add(AppLoadRequested());
              return SplashScreen();
            } else if (state is LoadedState) {
              return SplashScreen();
            } else if (state is SkeletonGeneratedState) {
              subject = state.subject;
              predicate = state.predicate;
              outcome = state.outcome;
              conflicts.clear();
            } else {}
            return _buildList(subject, predicate, conflicts, outcome);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            BlocProvider.of<GeneratorBloc>(context).add(SkeletonRequested());
          },
          child: Icon(
            Icons.new_label,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.blue,
          shape: CircularNotchedRectangle(),
          child: Row(
            children: <Widget>[
              IconButton(
                tooltip: 'Open navigation menu',
                icon: const Icon(Icons.menu),
                onPressed: () {},
                color: Colors.white,
              ),
              //const Spacer(),
              IconButton(
                tooltip: 'Search',
                icon: const Icon(Icons.search),
                onPressed: () {},
                color: Colors.white,
              ),
              IconButton(
                tooltip: 'Favorite',
                icon: const Icon(Icons.favorite),
                onPressed: () {},
                color: Colors.white,
              ),
            ],
          ),
        ),
        drawer: Drawer(backgroundColor: Colors.amber),
      ),
    );
  }

  Widget _buildList(
    Subject subject,
    Predicate predicate,
    List<Conflict> conflicts,
    Outcome outcome,
  ) {
    if (conflicts.isEmpty) {
      return Center(
        child: Container(
          color: Colors.deepOrange,
          child: Text(
            'Nothing here yet. Start by clicking the FAB',
            style: TextStyle(fontSize: 40),
          ),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return ListTile(
            title: subject == null
                ? Text('Nothing here yet')
                : Text(subject.description),
          );
        } else if (index == 1) {
          return ListTile(
            title: predicate == null
                ? Text('Nothing here yet')
                : Text(predicate.description),
          );
        } else if (index == conflicts.length + 2) {
          return ListTile(
            title: outcome == null
                ? Text('Nothing here yet')
                : Text(outcome.description),
          );
        } else {
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: ListTile(
              title: Text(conflicts[index - 2].permutations[0].description),
              leading: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back,
                ),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
