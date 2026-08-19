import 'package:flutter_test/flutter_test.dart';
import 'package:transitops_gis/presentation/navigation/app_destination.dart';
import 'package:transitops_gis/presentation/navigation/navigation_cubit.dart';

void main() {
  test('starts on dashboard and ignores duplicate selection', () async {
    final cubit = NavigationCubit();
    expect(cubit.state, AppDestination.dashboard);
    cubit.select(AppDestination.liveMap);
    expect(cubit.state, AppDestination.liveMap);
    cubit.select(AppDestination.liveMap);
    expect(cubit.state, AppDestination.liveMap);
    await cubit.close();
  });
}
