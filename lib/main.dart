import 'package:flutter/material.dart';
import 'package:transitops_gis/core/config/injection.dart';
import 'package:transitops_gis/presentation/app/transit_ops_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const TransitOpsApp());
}
