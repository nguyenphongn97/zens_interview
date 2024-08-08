import 'package:flutter/material.dart';
import '../../../resource/styles/app_typographys.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key, this.label, this.backgroundColor = const Color(0xff29B363), this.onPressed});
  final String? label;
  final Color backgroundColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0))),
          backgroundColor: backgroundColor,
          shadowColor: Colors.transparent,
          minimumSize: const Size(139, 36),
          padding: EdgeInsets.zero),
      onPressed: onPressed,
      child: Text(label ?? "",
          style: AppTypography.typographyCaptionMedium.copyWith(color: Colors.white),
          maxLines: 2),
    );
  }
}