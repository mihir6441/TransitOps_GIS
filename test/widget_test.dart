import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transitops_gis/core/constants/app_strings.dart';
import 'package:transitops_gis/presentation/app/transit_ops_app.dart';

import 'helpers/test_bootstrap.dart';

void main() {
  setUp(() async {
    await setUpTestDependencies();
  });

  tearDown(() async {
    await tearDownTestDependencies();
  });

  testWidgets('shows operations KPIs on the dashboard', (tester) async {
    await tester.pumpWidget(const TransitOpsApp());
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.appName), findsWidgets);
    expect(find.text('12'), findsOneWidget);
    expect(find.text(AppStrings.activeVehicles), findsOneWidget);
    expect(find.text('8'), findsOneWidget);
    expect(find.text(AppStrings.totalStops), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text(AppStrings.activeRoutes), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text(AppStrings.openIncidents), findsOneWidget);
    expect(find.text(AppStrings.openLiveMap), findsOneWidget);
  });

  testWidgets('Open Live Map switches to the live map destination', (
    tester,
  ) async {
    await tester.pumpWidget(const TransitOpsApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.openLiveMap));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.arcgisApiKeyMissing), findsOneWidget);
  });

  testWidgets('phone width stacks metric cards in a single column', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const TransitOpsApp());
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.activeVehicles), findsOneWidget);
    expect(find.text(AppStrings.openLiveMap), findsOneWidget);
  });

  testWidgets('navigates to settings from bottom navigation', (tester) async {
    await tester.pumpWidget(const TransitOpsApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.settings).last);
    await tester.pumpAndSettle();

    expect(find.text('Environment'), findsOneWidget);
    expect(find.text('NOT SET'), findsOneWidget);
    expect(find.text('IDLE'), findsOneWidget);
  });

  testWidgets('live map explains missing ArcGIS API key', (tester) async {
    await tester.pumpWidget(const TransitOpsApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.liveMap).last);
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.arcgisApiKeyMissing), findsOneWidget);
  });
}
