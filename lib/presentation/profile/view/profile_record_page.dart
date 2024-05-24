import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/core/resources/injection/injection.dart';
import 'package:fullstack_fe/presentation/profile/bloc/profile_record_cubit.dart';
import 'package:fullstack_fe/presentation/profile/view/profile_record_view.dart';

class ProfileRecordPage extends StatefulWidget {
  const ProfileRecordPage({super.key});

  @override
  State<ProfileRecordPage> createState() => _ProfileRecordPageState();
}

class _ProfileRecordPageState extends State<ProfileRecordPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<ProfileRecordCubit>()..load(),
        child: const Scaffold(body: ProfileView()));
  }
}
