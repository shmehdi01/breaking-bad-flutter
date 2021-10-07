import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_state.dart';
import 'bloc_provider.dart';

typedef BuilderWidget<S extends BlocState> = Widget Function(
    BuildContext context, S state);

class BlocBuilder<S extends BlocState> extends StatelessWidget {
  const BlocBuilder({Key? key, required this.builder}) : super(key: key);

  final BuilderWidget<S> builder;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).bloc;

    return StreamBuilder(
      stream: bloc.state,
      builder: (BuildContext context, AsyncSnapshot<BlocState> snapshot) {

        if (!snapshot.hasData) return const Center(child: Text("Unknown State", style: TextStyle(color: Colors.redAccent),),);

        return builder(context, snapshot.data as S);
      },
    );
  }
}
