
import 'package:breakingbad/app/ui/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';

import 'base_bloc.dart';
import 'base_state.dart';

typedef BlocWidgetBuilder = Widget Function();

// class BlocProvider<E, S extends BlocState> extends InheritedWidget {
//   final BaseBloc<E, S> bloc;
//
//   const BlocProvider({required this.bloc, required Widget child, Key? key})
//       : super(child: child, key: key);
//
//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) {
//     return true;
//   }
//
//   static B? of<B>(BuildContext context) =>
//       context.dependOnInheritedWidgetOfExactType<BlocProvider>()?.bloc as B?;
//
//   static BlocProvider ofX<B>(BuildContext context) {
//     final BlocProvider? result =
//         context.dependOnInheritedWidgetOfExactType<BlocProvider>();
//     assert(result != null, 'No FrogColor found in context');
//     return result!;
//   }
// }

typedef BlocProviderBuilder = Widget Function(BuildContext context);

class BlocProvider extends InheritedWidget {
   BlocProvider({
    Key? key,
    //required this.color,
    required this.bloc,
    required BlocProviderBuilder builder,
  }) : super(key: key, child: Builder(builder: (context) {
        return builder(context);
  }));

 // final Color color;
  final BaseBloc bloc;

  static BlocProvider of(BuildContext context) {
    final BlocProvider? result =
        context.dependOnInheritedWidgetOfExactType<BlocProvider>();
    assert(result != null, 'No FrogColor found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(BlocProvider old) => true;
}

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        bloc: HomeBloc(),
       // color: Colors.red,
          builder: (BuildContext innerContext) {
            return Center(
              child: Text(
                'Hello Frog ${BlocProvider.of(innerContext).bloc}',
                // style: TextStyle(color: FrogColor.of(innerContext).color),
              ),
            );
          },

      ),
    );
  }
}
