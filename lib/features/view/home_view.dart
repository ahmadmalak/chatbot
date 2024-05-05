import 'dart:developer';

import 'package:ask_pdf/features/auth/login/view/login.dart';
import 'package:ask_pdf/features/view/notifiers/query_notifier.dart';
import 'package:ask_pdf/features/view/side_menu.dart';
import 'package:ask_pdf/services/constants.dart';
import 'package:ask_pdf/widgets/category_widget.dart';
import 'package:ask_pdf/widgets/chat_widget.dart';
import 'package:ask_pdf/widgets/text_widget.dart';
import 'package:ask_pdf/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'notifiers/index_notifier.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late ScrollController _listScrollController;
  late TextEditingController textEditingController;

  late FocusNode focusNode;
  bool _isTyping = false;
  String id = box.read('userId') ?? '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(indexNotifierProvider.notifier).createAndUploadPineConeIndex();
    });
    _listScrollController = ScrollController();
    focusNode = FocusNode();
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void onLikeTap(bool value) {
    setState(() {
      // ignore: avoid_print
      print("Like tapped");
    });
  }

  void onDislikeTap(bool value) {
    setState(() {
      // ignore: avoid_print
      print("Dislike tapped");
    });
  }

  @override
  Widget build(BuildContext context) {
    final queryState = ref.watch(queryNotifierProvider);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: scaffoldBackgroundColor,
          body: SafeArea(
            child: Stack(
              children: [
                if (id.isNotEmpty)
                  Positioned(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ProfileImageWidget(
                                imageUrl: "https://picsum.photos/200/300",
                                onImageSelected: (String value) {},
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: ListView.builder(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.30,
                              right: MediaQuery.of(context).size.width * 0.10,
                            ),
                            controller: _listScrollController,
                            itemCount:
                                queryState.resultList.length, //chatList.length,
                            itemBuilder: (context, index) {
                              return ChatWidget(
                                onLikeTap: onLikeTap,
                                onDislikeTap: onDislikeTap,
                                msg: queryState.resultList[index],
                                chatIndex: 1,
                                shouldAnimate:
                                    queryState.resultList.length - 1 == index,
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.30,
                            right: MediaQuery.of(context).size.width * 0.10,
                          ),
                          child: SizedBox(
                            height: 203,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: const [
                                CategoryWidget(
                                  title: "Category 1",
                                ),
                                CategoryWidget(
                                  title: "Category 2",
                                ),
                                CategoryWidget(
                                  title: "Category 3",
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 50,
                            left: MediaQuery.of(context).size.width * 0.30,
                            right: MediaQuery.of(context).size.width * 0.10,
                          ),
                          child: Column(
                            children: [
                              if (queryState.isTyping) ...[
                                const SpinKitThreeBounce(
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ],
                              const SizedBox(
                                height: 15,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Material(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            focusNode: focusNode,
                                            style: const TextStyle(
                                                color: Colors.black),
                                            controller: textEditingController,
                                            onSubmitted: (value) async {
                                              sendMessageFCT();
                                            },
                                            decoration:
                                                InputDecoration.collapsed(
                                              hintText: "How can I help you",
                                              hintStyle: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            sendMessageFCT().then((value) {
                                              if (queryState.state ==
                                                  QueryEnum.loaded) {
                                                // historyService.addInputUser(
                                                //   queryState.resultList.last,
                                                // );
                                              } else if (queryState.state ==
                                                  QueryEnum.error) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: TextWidget(
                                                      label:
                                                          "Error in sending message",
                                                    ),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              }
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.send,
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.20,
                      left: MediaQuery.of(context).size.width * 0.40,
                      right: MediaQuery.of(context).size.width * 0.10,
                      bottom: MediaQuery.of(context).size.height * 0.20,
                    ),
                    child: const LoginPage(),
                  )
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          child: Material(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.2,
              color: const Color(0xFF515151),
              child: id.isNotEmpty
                  ? SideMenu(
                      onProfileTap: () {},
                      onHistoryTap: () {},
                      onListOfOffersTap: () {},
                    )
                  : Column(
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Image.asset(
                              AppImages.logoImage,
                              height: 70,
                            ),
                          ],
                        )
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }

  void scrollListToEND() {
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut);
  }

  Future<void> sendMessageFCT() async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "You cant send multiple messages at a time",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "Please type a message",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      print("Sending message");
      setState(() {
        _isTyping = true;
        textEditingController.clear();
        focusNode.unfocus();
      });
      ref
          .read(queryNotifierProvider.notifier)
          .queryPineConeIndex(textEditingController.text);
      setState(() {});
    } catch (error) {
      log("error $error");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: TextWidget(
          label: error.toString(),
        ),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        scrollListToEND();
        _isTyping = false;
      });
    }
  }
}
