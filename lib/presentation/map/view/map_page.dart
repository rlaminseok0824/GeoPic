import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:fullstack_fe/presentation/common/scaffolds/backward_scaffold.dart';
import 'package:fullstack_fe/presentation/map/bloc/map_cubit.dart';
import 'package:fullstack_fe/presentation/map/view/map_view.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (_) => getIt<MapCubit>())],
        child: const BackwardScaffold(body: MapView(), appBarHeight: 35));
  }
}
