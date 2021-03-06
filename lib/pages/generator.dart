import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plot_generator/pages/generator_bloc.dart';
import 'package:plot_generator/pages/generator_events.dart';
import 'package:plot_generator/pages/generator_states.dart';
import 'package:plot_generator/pages/splash_screen.dart';

class Generator extends StatelessWidget {
  final TextEditingController _controller = TextEditingController(text: '');
  GeneratorBloc _bloc;
  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<GeneratorBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Plotto: The Story Plot Generator",
        ),
      ),
      body: buildUI(context),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }

  Widget buildBody(BuildContext context) {
    return BlocBuilder<GeneratorBloc, GeneratorState>(
      builder: (BuildContext context, GeneratorState state) {
        if (state is LoadingState) {
          _bloc.add(GeneratorEvents.load);
          return SplashScreen();
        } else {
          return buildMainArea(context, state);
        }
      },
    );
  }

  Padding buildUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.indigo,
                  border: Border.all(
                    color: Colors.white,
                    width: 1.3,
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                height: 85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.indigoAccent,
                  border: Border.all(
                    color: Colors.white,
                    width: 0.4,
                  ),
                ),
              ),
            ],
          ),
          buildBody(context),
        ],
      ),
    );
  }

  Column buildMainArea(BuildContext context, GeneratorState state) {
    _controller.text = state.generatedText;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 4.0,
            left: 4.0,
            right: 4.0,
            bottom: 10.0,
          ),
          child: Text(
            '${state.description}',
            textScaleFactor: 1.2,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).splashColor,
                border: Border.all(
                  width: 1.0,
                  style: BorderStyle.solid,
                  color: Colors.white,
                ),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: null,
                maxLines: null,
                expands: true,
                controller: _controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 1,
                    horizontal: 5,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton(
                icon: Icons.electrical_services_rounded,
                text: "Lead-Ins",
                size: 32.0,
                splashColor: Theme.of(context).splashColor,
                color: Theme.of(context).buttonColor,
                callback: () {
                  _bloc.add(GeneratorEvents.lead_in);
                },
              ),
              buildButton(
                icon: Icons.restore_page_rounded,
                text: "New Plot",
                size: 48.0,
                splashColor: Theme.of(context).primaryColor,
                color: Theme.of(context).buttonColor,
                callback: () {
                  _bloc.add(GeneratorEvents.generate);
                },
              ),
              buildButton(
                icon: Icons.nat_rounded,
                text: "Carry-Ons",
                size: 32.0,
                splashColor: Theme.of(context).splashColor,
                color: Theme.of(context).buttonColor,
                callback: () {
                  _bloc.add(GeneratorEvents.carry_on);
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  RaisedButton buildButton({
    IconData icon,
    String text,
    VoidCallback callback,
    Color color,
    Color splashColor,
    double size,
  }) {
    return RaisedButton(
      color: color,
      splashColor: splashColor,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
        side: BorderSide(
          color: Colors.white,
          width: 1.0,
        ),
      ),
      onPressed: callback,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            Center(
              child: Icon(
                icon,
                size: size,
                color: Colors.white,
              ),
            ),
            Center(
              child: Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
