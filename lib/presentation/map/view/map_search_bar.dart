import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:fullstack_fe/core/resources/app_colors.dart';
import 'package:fullstack_fe/core/routers/app_routes.dart';
import 'package:fullstack_fe/presentation/map/bloc/map_cubit.dart';

class MapSearchBar extends StatelessWidget {
  const MapSearchBar({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.search, color: AppColors.secondaryPoint),
            const SizedBox(width: 10),
            Expanded(
              child: BlocBuilder<MapCubit, MapState>(builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    const SearchRoute().push(context).then((result) => context
                        .read<MapCubit>()
                        .addMarker(NLatLng(result.latitude, result.longitude),
                            type: "hihi"));
                  },
                  child: const Text('Search',
                      style: TextStyle(
                          color: AppColors.secondaryPoint,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                );
              }),
            ),
          ],
        ));
  }
}
