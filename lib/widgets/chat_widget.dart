import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ask_pdf/services/assets_manager.dart';
import 'package:ask_pdf/services/constants.dart';
import 'package:flutter/material.dart';

import 'text_widget.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({
    super.key,
    required this.msg,
    required this.chatIndex,
    this.shouldAnimate = false,
    required this.onLikeTap,
    required this.onDislikeTap,
  });

  final String msg;
  final int chatIndex;
  final bool shouldAnimate;
  final Function(bool) onLikeTap;
  final Function(bool) onDislikeTap;

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  bool isLiked = false;
  bool isDisliked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: widget.chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  widget.chatIndex == 0
                      ? AssetsManager.userImage
                      : AssetsManager.userImage,
                  height: 30,
                  width: 30,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: widget.chatIndex == 0
                      ? TextWidget(
                          label: widget.msg,
                        )
                      : widget.shouldAnimate
                          ? DefaultTextStyle(
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                              child: AnimatedTextKit(
                                  isRepeatingAnimation: false,
                                  repeatForever: false,
                                  displayFullTextOnTap: true,
                                  totalRepeatCount: 1,
                                  animatedTexts: [
                                    TyperAnimatedText(
                                      widget.msg.trim(),
                                    ),
                                  ]),
                            )
                          : Text(
                              widget.msg.trim(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                ),
                widget.chatIndex == 0
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (isDisliked) {
                                setState(() {
                                  isDisliked = !isDisliked;
                                });
                                widget.onDislikeTap(isDisliked);
                              }
                              setState(() {
                                isLiked = !isLiked;
                              });
                              if (isLiked) {
                                widget.onLikeTap(isLiked);
                              }
                            },
                            child: Icon(
                              isLiked
                                  ? Icons.thumb_up
                                  : Icons.thumb_up_alt_outlined,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (isLiked) {
                                setState(() {
                                  isLiked = !isLiked;
                                });
                                widget.onLikeTap(isLiked);
                              }
                              setState(() {
                                isDisliked = !isDisliked;
                              });
                              if (isDisliked) {
                                widget.onDislikeTap(isDisliked);
                              }
                            },
                            child: Icon(
                              isDisliked
                                  ? Icons.thumb_down
                                  : Icons.thumb_down_alt_outlined,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
