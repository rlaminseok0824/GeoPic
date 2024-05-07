import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@prod
@singleton
class AppBlocObserver extends BlocObserver {
  final Logger _logger;
  AppBlocObserver(this._logger);

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (!_isLogRequired(bloc, change)) return;
    _logBloc(bloc, change);
  }

  void _logBloc(BlocBase bloc, Change<dynamic> change) {
    switch (bloc.runtimeType) {
      default:
        _logOnlyType(bloc, change);
    }
  }

  void _logOnlyType(BlocBase bloc, Change<dynamic> change) {
    _logger.d('⛵️ currentState: '
        '$bloc.${change.currentState.runtimeType}'
        '->  '
        'nextState: '
        '$bloc.${change.nextState.runtimeType}');
  }

  bool _isLogRequired(BlocBase bloc, Change change) {
    switch (bloc.runtimeType) {
      default:
        return true;
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _logger.d('⛵ $error, $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
