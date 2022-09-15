import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/plotto_bloc.dart';

class WideScreen extends StatelessWidget {
  const WideScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlottoBloc, PlottoState>(
      builder: (context, state) {
        PlottoBloc bloc = BlocProvider.of(context);
        if (state is PlottoInitial) {
          bloc.add(LoadRequested());
          return Center(
            child: Text('Please Wait'),
          );
        }
        if (state is PlottoLoading) {
          return Center(
            child: Text('Loading Please Wait...'),
          );
        }
        if (state is PlottoLoaded) {
          return Center(
            child: Text('Ready! Please click the FAB ro start.'),
          );
        }
        if (state is PlottoGenerated) {
          return Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      child: ListTile(
                        title: Text(state.masterClauseA),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(state.masterClauseB),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(state.masterClauseC),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.conflicts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () =>
                              bloc.add(LeadInRequested(index: index)),
                        ),
                        title: Text(state.conflicts[index]),
                        trailing: IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () =>
                              bloc.add(CarryOnRequested(index: index)),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        }
        return Center(
          child: Text('Unknown state.'),
        );
      },
    );
  }
}
