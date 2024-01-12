import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rosewell_life_science/Constants/app_colors.dart';
import 'package:rosewell_life_science/Constants/app_constance.dart';
import 'package:rosewell_life_science/Constants/get_storage.dart';
import 'package:rosewell_life_science/Utils/app_sizer.dart';

class HandShakenAnimation extends StatefulWidget {
  const HandShakenAnimation({super.key});

  @override
  State<HandShakenAnimation> createState() => _HandShakenAnimationState();
}

class _HandShakenAnimationState extends State<HandShakenAnimation> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 2500), () {
          _controller.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        Future.delayed(const Duration(milliseconds: 2500), () {
          _controller.forward();
        });
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double angle = TweenSequence<double>(
              [
                TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.1), weight: 1),
                TweenSequenceItem(tween: Tween(begin: 0.1, end: -0.1), weight: 1),
                TweenSequenceItem(tween: Tween(begin: -0.1, end: 0.1), weight: 1),
                TweenSequenceItem(tween: Tween(begin: 0.1, end: -0.1), weight: 1),
                TweenSequenceItem(tween: Tween(begin: -0.1, end: 0.0), weight: 1),
              ],
            ).animate(_controller).value *
            2.0 *
            3.14159;

        return Transform.rotate(
          angle: angle,
          child: Text(
            getString(AppConstance.languageCode) != 'gu' && getString(AppConstance.languageCode) != 'hi' ? '👋' : '🙏',
            style: TextStyle(
              color: AppColors.PRIMARY_COLOR,
              fontSize: context.isPortrait ? 14.sp : 9.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        );
      },
    );
  }
}
