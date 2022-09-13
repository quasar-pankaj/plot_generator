import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/plotto_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlottoBloc bloc = BlocProvider.of<PlottoBloc>(context);
    String masterClauseA = 'Nothing here yet';
    String masterClauseB = 'Nothing here yet';
    String masterClauseC = 'Nothing here Yet';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Plotto',
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        shape: CircularNotchedRectangle(),
        child: Row(
          children: <Widget>[
            IconButton(
              tooltip: 'Open navigation menu',
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Search',
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Favorite',
              icon: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.add(SkeletonRequested());
        },
        child: Icon(
          Icons.new_label,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: BlocBuilder<PlottoBloc, PlottoState>(
        builder: (context, state) {
          if (state is PlottoInitial) {
            bloc.add(LoadRequested());
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PlottoLoaded) {
            return Center(
              child:
                  Text('Ready! Try clicking the FAB to generate a skeleton.'),
            );
          } else if (state is PlottoGenerated) {
            return display(
              masterClauseA,
              masterClauseB,
              masterClauseC,
              state.conflicts,
              bloc,
            );
          } else if (state is SkeletonGenerated) {
            masterClauseA = state.masterClauseA;
            masterClauseB = state.masterClauseB;
            masterClauseC = state.masterClauseC;
            return display(
              masterClauseA,
              masterClauseB,
              masterClauseC,
              <String>[],
              bloc,
            );
          } else {
            return Center(
              child: Text('Please wait'),
            );
          }
        },
      ),
    );
  }

  Widget display(
    String masterClauseA,
    String masterClauseB,
    String masterClauseC,
    List<String> conflicts,
    PlottoBloc bloc,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              ListTile(
                title: Text(masterClauseA),
              ),
              ListTile(
                title: Text(masterClauseB),
              ),
              ListTile(
                title: Text(masterClauseC),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: IconButton(
                icon: Icon(Icons.arrow_left),
                onPressed: () {},
              ),
              trailing: IconButton(
                icon: Icon(Icons.arrow_right),
                onPressed: () {},
              ),
              title: Text(
                conflicts[index],
              ),
            );
          },
        ),
      ],
    );
  }
}
