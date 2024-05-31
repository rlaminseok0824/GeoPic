import 'package:flutter/material.dart';
import 'package:fullstack_fe/core/resources/app_colors.dart';
import 'package:fullstack_fe/feature/search/models/location_info.dart';

class SearchPlaceCard extends StatelessWidget {
  final LocationInfo locationInfo;
  final VoidCallback onPressed;
  final VoidCallback onDelete;
  const SearchPlaceCard(
      {super.key,
      required this.locationInfo,
      required this.onPressed,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.location_on_sharp,
                  color: AppColors.secondaryPoint),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: onPressed,
                  child: Text(
                    locationInfo.place!,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              //삭제 버튼
              IconButton(onPressed: onDelete, icon: const Icon(Icons.close))
            ],
          )),
    );
  }
}
