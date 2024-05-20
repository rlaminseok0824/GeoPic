import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/core/resources/app_colors.dart';
import 'package:fullstack_fe/core/routers/app_routes.dart';
import 'package:fullstack_fe/presentation/search/bloc/search_record_cubit.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key, required this.height});

  final double height;

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          height: widget.height,
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
                child: Center(
                  child: BlocBuilder<SearchRecordCubit, SearchRecordState>(
                      builder: (context, state) {
                    return TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: AppColors.secondaryPoint,
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) => context
                          .read<SearchRecordCubit>()
                          .update((previous) => previous = value),
                    );
                  }),
                ),
              )
            ],
          )),
    );
  }
}
