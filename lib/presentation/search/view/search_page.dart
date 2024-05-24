import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:fullstack_fe/core/resources/storage/search_storage.dart';
import 'package:fullstack_fe/presentation/common/scaffolds/backward_scaffold.dart';
import 'package:fullstack_fe/presentation/search/bloc/search_record_cubit.dart';
import 'package:fullstack_fe/presentation/search/view/search_bar.dart';
import 'package:fullstack_fe/presentation/search/view/search_place_cards.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage._();

  static Widget builder(
    BuildContext context,
    GoRouterState state,
  ) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) {
        return getIt<SearchRecordCubit>()..load();
      }),
    ], child: const SearchPage._());
  }

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void _onSubmitSucceed(BuildContext context, SearchRecordState state) {
    state.maybeWhen(
        submitSucceed: (record) => context.pop(record.locations.last),
        orElse: () => null);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchRecordCubit, SearchRecordState>(
        listener: _onSubmitSucceed,
        builder: (context, state) {
          return const BackwardScaffold(
              body: SearchPlaceCards(),
              appBarHeight: 56,
              appBar: MySearchBar(
                height: 56,
              ));
        });
  }
}
