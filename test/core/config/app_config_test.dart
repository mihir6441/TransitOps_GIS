import 'package:flutter_test/flutter_test.dart';
import 'package:transitops_gis/core/config/app_config.dart';
import 'package:transitops_gis/core/config/app_environment.dart';
import 'package:transitops_gis/core/responsive/breakpoints.dart';

void main() {
  test('AppConfig.fromEnvironment uses safe defaults', () {
    final config = AppConfig.fromEnvironment();
    expect(config.environment, AppEnvironment.development);
    expect(config.arcgisApiKey, isEmpty);
    expect(config.hasArcgisApiKey, isFalse);
    expect(config.arcgisPortalUrl, 'https://www.arcgis.com');
  });

  test('breakpoints follow compact / medium / expanded widths', () {
    expect(Breakpoints.compact, 600);
    expect(Breakpoints.medium, 840);
    expect(Breakpoints.expanded, 1200);
  });
}
