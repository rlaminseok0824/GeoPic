import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_bottom_navigation_bar_state.dart';
part 'home_bottom_navigation_bar_cubit.freezed.dart';

@injectable
class HomeBottomNavigationBarCubit extends Cubit<HomeBottomNavigationBarState> {
  HomeBottomNavigationBarCubit()
      : super(const HomeBottomNavigationBarState(currentIndex: 0));

  void moveTo(int nextIndex) {
    return emit(HomeBottomNavigationBarState(currentIndex: nextIndex));
  }
}
