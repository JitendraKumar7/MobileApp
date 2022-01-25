library emoji_feedback;

import 'dart:math';
import 'package:flutter/material.dart';

class EmojiModel {
  final String label;
  final String src;
  final String activeSrc;

  const EmojiModel({
    required this.src,
    required this.label,
    required this.activeSrc,
  });
}

final List<EmojiModel> reactions = <EmojiModel>[
  const EmojiModel(
    label: 'Terrible',
    src: 'assets/worried.png',
    activeSrc: 'assets/worried_big.png',
  ),
  const EmojiModel(
    label: 'Bad',
    src: 'assets/sad.png',
    activeSrc: 'assets/sad_big.png',
  ),
  const EmojiModel(
    label: 'OK',
    src: 'assets/ambitious.png',
    activeSrc: 'assets/ambitious_big.png',
  ),
  const EmojiModel(
    label: 'Good',
    src: 'assets/smile.png',
    activeSrc: 'assets/smile_big.png',
  ),
  const EmojiModel(
    label: 'Awesome',
    src: 'assets/surprised.png',
    activeSrc: 'assets/surprised_big.png',
  ),
].toList();

const emojiSize = 40.0;
const emojiRadius = emojiSize / 2.0;
const activeEmojiSize = emojiSize * 1.5;
const activeEmojiRadius = activeEmojiSize / 2.0;
const halfDiffSize = (activeEmojiSize - emojiSize) / 2.0;

class EmojiFeedback extends StatefulWidget {
  final int currentIndex;
  final Function onChange;
  final double availableWidth;

  const EmojiFeedback({
    Key? key,
    this.currentIndex = 2,
    required this.onChange,
    this.availableWidth = 320.0,
  }) : super(key: key);

  @override
  EmojiFeedbackState createState() {
    return EmojiFeedbackState();
  }
}

class EmojiFeedbackState extends State<EmojiFeedback>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  double pos = 2.0; // should be between [0, 4]

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  void moveTo(int index) {
    animation = Tween<double>(
      begin: pos,
      end: index.toDouble(),
    ).chain(CurveTween(curve: Curves.linear)).animate(controller)
      ..addListener(() {
        setState(() {
          pos = animation.value;
        });
      });
    controller.forward(from: 0.0);
    widget.onChange(index);
  }

  @override
  Widget build(BuildContext context) {
    final posTween =
        Tween<double>(begin: 0, end: widget.availableWidth - activeEmojiSize);
    List<_EmojiButton> emojiButtons = [];
    List<Widget> activeEmojis = [];
    for (var i = 0; i < reactions.length; i++) {
      final distanceTo = posTween.transform((i - pos).abs() / 4);
      var scale = 1.0;
      if (distanceTo < activeEmojiRadius) {
        scale = 0.0;
      } else {
        scale =
            min<double>((distanceTo - activeEmojiRadius) / emojiRadius, 1.0);
      }
      emojiButtons.add(_EmojiButton(
        scale: scale,
        label: reactions[i].label,
        src: reactions[i].src,
        onPressed: () {
          moveTo(i);
        },
      ));
      activeEmojis.add(
        Positioned(
          child: Opacity(
            opacity: 1.0 - scale,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    reactions[i].activeSrc,
                    package: 'emoji_feedback',
                  ),
                ),
                borderRadius: BorderRadius.circular(activeEmojiSize),
              ),
            ),
          ),
        ),
      );
    }
    return SizedBox(
      width: widget.availableWidth,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: activeEmojiRadius,
            left: activeEmojiRadius,
            right: activeEmojiRadius,
            child: Container(
              height: 1.0,
              color: Colors.grey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: emojiButtons,
          ),
          Positioned(
            left: posTween.transform(pos / 4),
            child: SizedBox(
              width: activeEmojiSize,
              height: activeEmojiSize,
              child: Stack(children: activeEmojis),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _EmojiButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final String src;
  final num scale;

  const _EmojiButton({
    Key? key,
    required this.src,
    required this.scale,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(scale >= 0 && scale <= 1);
    final offsetTop =
        Tween<double>(begin: 16.0, end: 6.0).transform(scale.toDouble());
    final realScale =
        Tween<double>(begin: 0.25, end: 1.0).transform(scale.toDouble());
    final color = ColorTween(begin: Colors.black, end: Colors.grey)
        .transform(scale.toDouble());
    return Container(
      width: activeEmojiSize,
      padding: const EdgeInsets.only(top: halfDiffSize),
      child: Column(
        children: <Widget>[
          Transform.scale(
            scale: realScale,
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: onPressed,
              child: Container(
                width: emojiSize,
                height: emojiSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(src, package: 'emoji_feedback'),
                  ),
                  borderRadius: BorderRadius.circular(emojiSize),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: offsetTop),
            child: Text(
              label,
              style:
                  Theme.of(context).textTheme.caption?.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
