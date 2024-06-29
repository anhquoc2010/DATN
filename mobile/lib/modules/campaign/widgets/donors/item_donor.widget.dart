import 'package:flutter/material.dart';
import 'package:mobile/common/extensions/dynamic.extension.dart';
import 'package:mobile/data/models/user.model.dart';
import 'package:mobile/generated/assets.gen.dart';

class ItemDonorWidget extends StatelessWidget {
  const ItemDonorWidget({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: user.avatar.isNullOrEmpty
                ? Assets.images.imgDefautAvatar.provider()
                : NetworkImage(user.avatar!),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  user.email ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
