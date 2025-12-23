import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mysivi_chat_app/core/extensions/context_extension.dart';
import 'package:flutter_mysivi_chat_app/core/themes/app_colors.dart';
import 'package:flutter_mysivi_chat_app/core/widgets/message_bubble.dart';
import 'package:flutter_mysivi_chat_app/features/chat/bloc/chat_bloc.dart';
import 'package:flutter_mysivi_chat_app/features/chat/cubit/translation_cubit.dart';

class ChatPage extends StatefulWidget {
  final String userId;
  final String userName;

  const ChatPage({super.key, required this.userId, required this.userName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ChatBloc()..add(LoadMessages(widget.userId)),
        ),
        BlocProvider(create: (context) => TranslationCubit()),
      ],
      child: BlocListener<TranslationCubit, TranslationState>(
        listener: (context, state) {
          if (state is TranslationLoaded) {
            context.showSnack("Translation: ${state.translatedText}");
          } else if (state is TranslationLoading) {
            context.showSnack("Translating...");
          } else if (state is TranslationError) {
            context.showSnack("Translation Error: ${state.message}");
          }
        },
        child: Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Text(
              widget.userName,
              style: context.bodyLarge?.copyWith(color: AppColors.onSurface),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: BlocConsumer<ChatBloc, ChatState>(
                    listener: (context, state) {
                      if (state is ChatLoaded) {
                        _scrollToBottom();
                      } else if (state is ChatError) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    },
                    builder: (context, state) {
                      if (state is ChatLoading || state is ChatInitial) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is ChatLoaded) {
                        final messages = state.messages;
                        final showTyping = state.isTyping;

                        return ListView.builder(
                          key: PageStorageKey(
                            "chatMessagesListView_//${widget.userId}",
                          ),
                          controller: _scrollController,
                          padding: const EdgeInsets.all(12),
                          itemCount: messages.length + (showTyping ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index < messages.length) {
                              final message = messages[index];
                              final isMe = message.senderId == 'me';

                              return Column(
                                crossAxisAlignment: isMe
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  MessageBubble(
                                    sender: isMe ? 'You' : widget.userName,
                                    text: message.content,
                                    isMe: isMe,
                                    onSelectionChanged: (selection, cause) {
                                      final selectedText = message.content
                                          .substring(
                                            selection.baseOffset,
                                            selection.extentOffset,
                                          );
                                      context
                                          .read<TranslationCubit>()
                                          .translateText(selectedText);
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Text(
                                      message.timestamp
                                          .toLocal()
                                          .toIso8601String()
                                          .substring(11, 16),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: isMe
                                            ? Colors.black54
                                            : Colors.black45,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }

                            return MessageBubble(
                              sender: widget.userName,
                              text: 'typing…',
                              isMe: false,
                            );
                          },
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),

                Builder(
                  builder: (innerContext) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                textInputAction: TextInputAction.send,
                                minLines: 1,
                                maxLines: 5,
                                decoration: const InputDecoration(
                                  hintText: 'Type a message',
                                  border: InputBorder.none,
                                ),
                                onSubmitted: (_) => _sendMessage(innerContext),
                              ),
                            ),

                            const SizedBox(width: 8),

                            ValueListenableBuilder<TextEditingValue>(
                              valueListenable: _controller,
                              builder: (context, value, _) {
                                final isEmpty = value.text.trim().isEmpty;

                                return GestureDetector(
                                  onTap: isEmpty
                                      ? null
                                      : () => _sendMessage(context),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: isEmpty
                                          ? AppColors.background
                                          : AppColors.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.send,
                                      size: 18,
                                      color: isEmpty
                                          ? Colors.white70
                                          : Colors.white,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _sendMessage(BuildContext context) {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    context.read<ChatBloc>().add(SendMessage(widget.userId, text));

    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
