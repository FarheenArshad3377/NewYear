import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:newyear/screen/newYearModel.dart';
import 'package:stacked/stacked.dart';
import 'package:confetti/confetti.dart';

class NewyearView extends StatelessWidget {
  const NewyearView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => Newyearmodel(),
      onModelReady: (viewModel) {
        viewModel.initializeConfetti(); // Initialize the confetti controller
      },
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Display countdown timer only if it's not finished
                  if (!viewModel.isTimerFinished)
                    TimerCountdown(
                      format: CountDownTimerFormat.secondsOnly, // Only seconds
                      endTime: DateTime.now().add(
                        Duration(seconds: 15), // Timer for 10 seconds
                      ),
                      onEnd: () {
                        viewModel.timerEnded(); // Call the method in ViewModel
                      },
                      // Custom style to show only the number without the "seconds" label
                      timeTextStyle: TextStyle(
                        fontSize: 100, // Large font size for better visibility
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  // Show "Timer finished" text and Confetti when the timer ends
                  if (viewModel.isTimerFinished)
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: ConfettiWidget(
                            confettiController: viewModel.confettiController,
                            blastDirectionality: BlastDirectionality
                                .explosive, // Blast randomly
                            shouldLoop: false, // Stop looping after one explosion
                            colors: const [
                              Colors.green,
                              Colors.blue,
                              Colors.pink,
                              Colors.orange,
                              Colors.purple
                            ], // Confetti colors
                            createParticlePath: viewModel.drawStar, // Custom shape for confetti
                          ),
                        ),
                        // Multi-colored "Happy New Year" Text
                        Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 40, // Font size
                                fontWeight: FontWeight.bold, // Make it bold
                              ),
                              children: [
                                TextSpan(
                                  text: 'H',
                                  style: TextStyle(color: Colors.red),
                                ),
                                TextSpan(
                                  text: 'a',
                                  style: TextStyle(color: Colors.orange),
                                ),
                                TextSpan(
                                  text: 'p',
                                  style: TextStyle(color: Colors.yellow),
                                ),
                                TextSpan(
                                  text: 'p',
                                  style: TextStyle(color: Colors.green),
                                ),
                                TextSpan(
                                  text: 'y',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                TextSpan(
                                  text: ' ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextSpan(
                                  text: 'N',
                                  style: TextStyle(color: Colors.purple),
                                ),
                                TextSpan(
                                  text: 'e',
                                  style: TextStyle(color: Colors.cyan),
                                ),
                                TextSpan(
                                  text: 'w',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                TextSpan(
                                  text: ' ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextSpan(
                                  text: 'Y',
                                  style: TextStyle(color: Colors.red),
                                ),
                                TextSpan(
                                  text: 'e',
                                  style: TextStyle(color: Colors.orange),
                                ),
                                TextSpan(
                                  text: 'a',
                                  style: TextStyle(color: Colors.yellow),
                                ),
                                TextSpan(
                                  text: 'r',
                                  style: TextStyle(color: Colors.green),
                                ),
                                TextSpan(
                                  text: ' ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextSpan(
                                  text: '!',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        ),
                         Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top:60.0),
                            child: Text(
                              "May your year be as bright as your smile and as lovely as your heart",
                              style: TextStyle(
                                fontSize: 8, // Font size for the small message
                                fontWeight: FontWeight.w400, // Normal weight
                                color: Colors.white, // White color for the message
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

