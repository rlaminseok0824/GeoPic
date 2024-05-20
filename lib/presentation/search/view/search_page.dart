import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/presentation/common/scaffolds/backward_scaffold.dart';
import 'package:fullstack_fe/presentation/search/bloc/search_record_cubit.dart';
import 'package:fullstack_fe/presentation/search/view/search_bar.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage._();

  static Widget builder(
    BuildContext context,
    GoRouterState state,
  ) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => SearchRecordCubit()),
    ], child: const SearchPage._());
  }

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return BackwardScaffold(
        body: Container(),
        appBarHeight: 56,
        appBar: const MySearchBar(
          height: 56,
        ));
  }
}
