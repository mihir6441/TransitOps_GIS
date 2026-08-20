import 'package:equatable/equatable.dart';
import 'package:transitops_gis/domain/entities/gis_enums.dart';

class SelectedGisFeature extends Equatable {
  const SelectedGisFeature({
    required this.layerType,
    required this.id,
    required this.title,
    required this.fields,
  });

  final GisLayerType layerType;
  final String id;
  final String title;
  final Map<String, String> fields;

  @override
  List<Object?> get props => [layerType, id, title, fields];
}
