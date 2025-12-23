import 'package:flutter/material.dart';
import 'package:flutter_mysivi_chat_app/core/extensions/context_extension.dart';

class OnlineIndicatorAvatar extends StatelessWidget {
  final String letter;
  final bool isOnline;
  final double size;

  const OnlineIndicatorAvatar({
    super.key,
    required this.letter,
    required this.isOnline,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: size / 2,
          child: Text(
            letter,
            style: context.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),

        if (isOnline)
          Positioned(
            bottom: -2,
            right: -2,
            child: Container(
              width: size * 0.3,
              height: size * 0.3,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 2,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
