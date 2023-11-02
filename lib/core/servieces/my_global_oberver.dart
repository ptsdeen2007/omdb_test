
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppGlobalObserver extends BlocObserver{

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('Bloc type ${bloc.runtimeType} Event $event');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {

    super.onError(bloc, error, stackTrace);
    debugPrint('Bloc type ${bloc.runtimeType} Event $stackTrace');
  }

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    debugPrint('Bloc type ${bloc.runtimeType} Event $transition');
//
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
super.onChange(bloc, change);
debugPrint('Bloc type ${bloc.runtimeType} change $change');
  }
}