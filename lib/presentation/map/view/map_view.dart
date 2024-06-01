import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:fullstack_fe/core/routers/app_routes.dart';
import 'package:fullstack_fe/presentation/map/bloc/map_cubit.dart';
import 'package:fullstack_fe/presentation/map/view/article_record_bottom_sheet.dart';
import 'package:fullstack_fe/presentation/map/view/current_position_button.dart';
import 'package:geolocator/geolocator.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView>
    with AutomaticKeepAliveClientMixin<MapView> {
  @override
  bool get wantKeepAlive => true;

  void _setCurrentPosition(Position position) {
    context.read<MapCubit>().setPosition(position);
    context.read<MapCubit>().updateCamera();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<MapCubit, MapState>(builder: (context, state) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Stack(children: [
          NaverMap(
            options: const NaverMapViewOptions(),
            onMapReady: (controller) {
              context.read<MapCubit>().initMap(controller);
            },
            onMapTapped: (_, latLng) {
              context.read<MapCubit>().tapMarker(latLng).then((value) {
                if (value == null) return;
                ArticleRecordBottomSheet.show(context: context, record: value);
              });
            },
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: CurrentPositionButton(
              onPressed: () async {
                final position = await Geolocator.getCurrentPosition();
                _setCurrentPosition(position);
              },
            ),
          ),
        ]),
      );
    });
  }
}
