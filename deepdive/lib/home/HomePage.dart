// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:html' as html;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:deepdive/core/Utils.dart';
import 'package:deepdive/drawer/Drawer.dart';
import 'package:deepdive/home/model/SendAudioRequest.dart';
import 'package:deepdive/home/provider/SendAudioProvider.dart';
import 'package:deepdive/home/widget/ButtonExit.dart';
import 'package:deepdive/home/widget/LabelSpeaking.dart';
import 'package:deepdive/home/widget/TextAlert.dart';
import 'package:deepdive/login/provider/AuthUserProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:deepdive/core/Colors.dart';
import '../core/Assets.dart';
import 'package:deepdive/home/model/SendAudioResponse.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});

  static const route = '/home';

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final SpeechToText speechToText = SpeechToText();
  final FlutterTts textToSpeech = FlutterTts();
  bool isListening = false;
  bool havePermission = false;
  bool loading = false;
  bool isSpeaking = false;
  String? text;
  String label = '';
  List<Map<String, String>> conversations = [];

  Future speak(String text) async {
    setState(() {
      isSpeaking = true;
    });

    await textToSpeech.setLanguage("pt-BR");
    await textToSpeech.setPitch(1);
    await textToSpeech.setSpeechRate(0.8);
    await textToSpeech.speak(text);

    textToSpeech.setCompletionHandler(() {
      setState(() {
        isSpeaking = false;
      });
    });
  }

  void checkPermission() {
    html.window.navigator.mediaDevices!
        .getUserMedia({'audio': true}).then((stream) {
      setState(() {
        havePermission = true;
      });
    }).catchError((e) {
      havePermission = false;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Permissão negada'),
            content: const Text(
              'Você negou as permissões de acesso ao microfone. Para utilizar, por favor altere as configurações de permissão em seu navegador.',
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Fechar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  void addConversation(String message, String transcription) {
    setState(() {
      conversations.add({"message": message, "transcription": transcription});
    });
  }

  void startRecording() async {
    bool available = await speechToText.initialize();
    if (available) {
      setState(() {
        isListening = true;
        speechToText.listen(onResult: (result) {
          setState(() {
            text = result.recognizedWords;
            label = result.recognizedWords;
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authUserController =
        ref.read(AuthUserStateController.provider.notifier);
    final sendAudioController =
        ref.read(SendAudioStateController.provider.notifier);
    text ?? '';
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          backgroundColor: colorBackground,
          drawer: const Drawer(
            backgroundColor: Colors.transparent,
            child: DrawerPage(),
          ),
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.sort),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            toolbarHeight: 80,
            backgroundColor: Colors.transparent,
            title: SizedBox(height: 200, child: Image.asset(imgLogo)),
            actions: const [
              ButtonExit(),
            ],
          ),
          body: Center(
            child: SizedBox(
              width: 800,
              child: ListView(
                reverse: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  if (loading) const LinearProgressIndicator(),
                  TextAlert(isListening: isListening),
                  LabelSpeaking(label: label),
                  for (int i = conversations.length - 1; i >= 0; i--)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    MessageItem(
                                        conversations: conversations, i: i),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 41, 54, 61),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      padding: const EdgeInsets.all(15),
                                      margin: const EdgeInsets.only(
                                          bottom: 10, left: 50, right: 200),
                                      constraints: const BoxConstraints(
                                        maxWidth: 500,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (!isSpeaking) {
                                            speak(conversations[i]
                                                ["transcription"]!);
                                          } else {
                                            textToSpeech.stop();
                                            setState(() {
                                              isSpeaking = false;
                                            });
                                          }
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              CupertinoIcons.play_arrow_solid,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 10),
                                            Flexible(
                                              child: Text(
                                                conversations[i]
                                                    ["transcription"]!,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: AvatarGlow(
            endRadius: 65,
            animate: isListening,
            repeatPauseDuration: const Duration(milliseconds: 100),
            duration: const Duration(milliseconds: 2000),
            child: GestureDetector(
              onTapDown: (details) async {
                if (!havePermission) {
                  checkPermission();
                } else if (havePermission && !isListening) {
                  startRecording();
                }
              },
              onTapUp: (details) async {
                setState(() => isListening = false);
                SendAudioResponse response;
                if (!isNullOrEmpty(text)) {
                  if (havePermission) {
                    setState(() => loading = true);
                    String encodedText = base64.encode(utf8.encode(text!));
                    response = await sendAudioController.sendAudio(
                      SendAudioRequest(
                        transcription: text!,
                        audio: encodedText,
                        token: authUserController.user!.token!,
                        id: authUserController.user!.result!.id!,
                      ),
                    );
                    setState(() {
                      isListening = false;
                      loading = false;
                      addConversation(response.result!.transcription!,
                          response.result!.message!);
                    });
                    speak(response.result!.message!);
                  }
                }
                setState(() {
                  isListening = false;
                  text = '';
                });
                speechToText.stop();
              },
              child: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                radius: 35,
                child: Icon(
                  isListening ? CupertinoIcons.mic_fill : CupertinoIcons.mic,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.conversations,
    required this.i,
  });

  final List<Map<String, String>> conversations;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 10, 75, 59),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 10, left: 200, right: 50),
      child: Text(
        conversations[i]["message"]!,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
