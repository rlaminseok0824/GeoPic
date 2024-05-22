import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:fullstack_fe/core/resources/storage/search_storage.dart';
import 'package:fullstack_fe/feature/search/models/location_info.dart';
import 'package:fullstack_fe/presentation/search/bloc/search_record_cubit.dart';
import 'package:fullstack_fe/presentation/search/view/search_place_card.dart';

class SearchPlaceCards extends StatelessWidget {
  const SearchPlaceCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchRecordCubit, SearchRecordState>(
      builder: (context, state) {
        return state.maybeMap(
          initial: (initialState) =>
              _buildListView(context, initialState.reocrd.locations),
          submitSucceed: (submitSucceedState) =>
              _buildListView(context, submitSucceedState.reocrd.locations),
          orElse: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget _buildListView(BuildContext context, List<LocationInfo> locations) {
    return Column(
      children: [
        locations.isEmpty
            ? const Center(child: Text('No locations found.'))
            : const SizedBox(height: 20),
        for (final location in locations)
          SearchPlaceCard(
            locationInfo: location,
            onPressed: () {
              context.read<SearchRecordCubit>().onPressed(location);
            },
            onDelete: () {
              context.read<SearchRecordCubit>().update(
                    (previous) => previous.copyWith(
                      locations: previous.locations
                          .where((element) => element != location)
                          .toList(),
                    ),
                  );
              getIt<SearchStorage>().deleteSearchRecord(location);
            },
          ),
      ],
    );

    // if (locations.isEmpty) {
    //   return const Center(child: Text('No locations found.'));
    // }
    // return Column(
    //   children: [
    //     const SizedBox(height: 20),
    //     for (final location in locations)
    //       SearchPlaceCard(
    //         locationInfo: location,
    //         onPressed: () {
    //           context.read<SearchRecordCubit>().onPressed(location);
    //         },
    //         onDelete: () {
    //           context.read<SearchRecordCubit>().update(
    //                 (previous) => previous.copyWith(
    //                   locations: previous.locations
    //                       .where((element) => element != location)
    //                       .toList(),
    //                 ),
    //               );
    //           getIt<SearchStorage>().deleteSearchRecord(location);
    //         },
    //       ),
    //   ],
    // );
  }
}
