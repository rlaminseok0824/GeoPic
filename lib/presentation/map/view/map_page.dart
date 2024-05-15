import 'package:flutter/material.dart';
import 'package:fullstack_fe/presentation/common/scaffolds/backward_scaffold.dart';
import 'package:fullstack_fe/presentation/map/view/map_view.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return BackwardScaffold(body: MapView(), appBarHeight: 35);
  }
}
