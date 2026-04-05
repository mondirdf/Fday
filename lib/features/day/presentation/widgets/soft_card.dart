import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class SoftCard extends StatelessWidget {
  const SoftCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(vertical: 8),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            offset: Offset(-6, -6),
            blurRadius: 12,
          ),
          BoxShadow(
            color: AppColors.shadowDark,
            offset: Offset(6, 6),
            blurRadius: 12,
          ),
        ],
      ),
      child: child,
    );
  }
}
