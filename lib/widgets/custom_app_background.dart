import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/asset_path.dart';


class CustomAppBackground extends StatelessWidget {
  const CustomAppBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AssetPath.bgSVGImage,
          fit: BoxFit.cover,
          height: double.maxFinite,
        ),
        child,
      ],
    );
  }
}