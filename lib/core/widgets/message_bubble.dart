import 'package:flutter/material.dart';
import 'package:flutter_mysivi_chat_app/core/extensions/context_extension.dart';
import 'package:flutter_mysivi_chat_app/core/themes/app_colors.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, this.sender, this.text, this.isMe});

  final String? text;
  final String? sender;
  final bool? isMe;

  @override
  Widget build(BuildContext context) {
    final avatarLetter = isMe == true
        ? 'Y'
        : (sender != null && sender!.isNotEmpty
              ? sender![0].toUpperCase()
              : '?');

    final maxBubbleWidth = MediaQuery.of(context).size.width * 0.68;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isMe == true
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isMe == false)
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey.shade300,
              child: Text(avatarLetter, style: context.bodyMedium),
            ),

          if (isMe == false) const SizedBox(width: 3),

          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxBubbleWidth),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(30),
                  topRight: const Radius.circular(30),
                  bottomLeft: isMe == true
                      ? const Radius.circular(30)
                      : Radius.zero,
                  bottomRight: isMe == false
                      ? const Radius.circular(30)
                      : Radius.zero,
                ),
                color: isMe == true ? AppColors.secondary : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Text(
                    text ?? '',
                    softWrap: true,
                    style: TextStyle(
                      color: isMe == true ? Colors.white : Colors.black87,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),

          if (isMe == true) const SizedBox(width: 3),

          if (isMe == true)
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.secondary,
              child: Text(
                'Y',
                style: context.bodyMedium?.copyWith(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
