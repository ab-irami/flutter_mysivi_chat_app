import 'package:flutter/material.dart';
import 'package:flutter_mysivi_chat_app/core/extensions/context_extension.dart';
import 'package:flutter_mysivi_chat_app/core/themes/app_colors.dart';
import 'package:flutter_mysivi_chat_app/core/utils/responsive.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.sender,
    required this.text,
    required this.isMe,
    this.onSelectionChanged,
  });

  final String text;
  final String sender;
  final bool isMe;
  final void Function(TextSelection, SelectionChangedCause?)?
  onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    final avatarLetter = isMe == true
        ? 'Y'
        : (sender.isNotEmpty ? sender[0].toUpperCase() : '?');

    final maxBubbleWidth = MediaQuery.of(context).size.width * 0.68;

    return Padding(
      padding: Responsive.padSymmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isMe == true
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isMe == false)
            CircleAvatar(
              radius: Responsive.w(16),
              backgroundColor: Colors.grey.shade300,
              child: Text(avatarLetter, style: context.bodyMedium),
            ),

          if (isMe == false) SizedBox(width: Responsive.w(3)),

          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxBubbleWidth),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Responsive.w(30)),
                  topRight: Radius.circular(Responsive.w(30)),
                  bottomLeft: isMe == true
                      ? Radius.circular(Responsive.w(30))
                      : Radius.zero,
                  bottomRight: isMe == false
                      ? Radius.circular(Responsive.w(30))
                      : Radius.zero,
                ),
                color: isMe == true ? AppColors.secondary : Colors.white,
                child: Padding(
                  padding: Responsive.padSymmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: SelectableText(
                    text,
                    onSelectionChanged: onSelectionChanged,
                    style: TextStyle(
                      color: isMe == true ? Colors.white : Colors.black87,
                      fontSize: Responsive.sp(15),
                    ),
                    contextMenuBuilder: (context, editableTextState) =>
                        const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          ),

          if (isMe == true) SizedBox(width: Responsive.w(3)),

          if (isMe == true)
            CircleAvatar(
              radius: Responsive.w(16),
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
