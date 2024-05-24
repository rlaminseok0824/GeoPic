import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fullstack_fe/presentation/common/buttons/app_elevated_button.dart';
import 'package:fullstack_fe/presentation/common/text_fields/app_text_area.dart';
import 'package:fullstack_fe/presentation/profile/bloc/profile_record_cubit.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 56),
          const SizedBox(height: 56),
          Row(
            children: [
              // Default Profile Image
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                    color: Colors.grey,
                    child: const Icon(Icons.person, size: 100)),
              ),
              const SizedBox(width: 16),
              // TextField
              Expanded(
                  child: Column(
                children: [
                  BlocBuilder<ProfileRecordCubit, ProfileRecordState>(
                      builder: (context, state) {
                    return AppTextArea(
                      initialValue: state.name,
                      onChanged: (value) {
                        context.read<ProfileRecordCubit>().update(value);
                      },
                    );
                  }),
                  const SizedBox(height: 16),
                  AppElevatedButton(
                      onPressed: () =>
                          context.read<ProfileRecordCubit>().submit(),
                      text: '저장',
                      isDisabled: false,
                      isLoading: false)
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }
}
