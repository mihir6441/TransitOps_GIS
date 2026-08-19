import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transitops_gis/presentation/navigation/app_destination.dart';

class NavigationCubit extends Cubit<AppDestination> {
  NavigationCubit() : super(AppDestination.dashboard);

  void select(AppDestination destination) {
    if (state == destination) {
      return;
    }
    emit(destination);
  }
}
