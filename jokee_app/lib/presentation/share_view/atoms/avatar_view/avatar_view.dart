import 'package:flutter/material.dart';
import '../../../resource/styles/app_typographys.dart';

class AvatarView extends StatelessWidget {
  const AvatarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Handicrafted by", style: AppTypography.typographyCaptionSmall.copyWith(color: const Color(0xff646464))),
            const Text("Jim HLS", style: AppTypography.typographyCaptionSmall),
          ],
        ),
        const CircleAvatar(backgroundImage: AssetImage("assets/images/avatar.webp"))
      ],
    );
  }
}
