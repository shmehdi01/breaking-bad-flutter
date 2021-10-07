import 'package:flutter/material.dart';

import 'base_bloc.dart';

typedef BlocProviderBuilder = Widget Function(BuildContext context);

class BlocProvider extends InheritedWidget {
   BlocProvider({
    Key? key,

    required this.bloc,
    required BlocProviderBuilder builder,
  }) : super(key: key, child: Builder(builder: (context) {
        return builder(context);
  }));

  final BaseBloc bloc;

  static BlocProvider of(BuildContext context) {
    final BlocProvider? result =
        context.dependOnInheritedWidgetOfExactType<BlocProvider>();
    assert(result != null, 'No Bloc found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(BlocProvider old) => true;
}
