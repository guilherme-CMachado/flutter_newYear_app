import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isPlaying = false;
  final _controller = ConfettiController();

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        isPlaying = _controller.state == ConfettiControllerState.playing;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(alignment: Alignment.center, children: <Widget>[
        Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              const Spacer(),
              isPlaying
                  ? const Text(
                      'Happy new year!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    )
                  : const SizedBox.shrink(),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  child: Text(isPlaying ? 'Stop 🥳' : 'Celebrate 🥳'),
                  onPressed: () {
                    if (isPlaying) {
                      _controller.stop();
                    } else {
                      _controller.play();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        ConfettiWidget(
          confettiController: _controller,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: true,
        )
      ]),
    );
  }
}
