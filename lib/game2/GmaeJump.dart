import 'package:flutter/material.dart';

class GmaeJump extends StatefulWidget {
  const GmaeJump({Key? key}) : super(key: key);

  @override
  _GmaeJumpState createState() => _GmaeJumpState();
}

class _GmaeJumpState extends State<GmaeJump> {
  // Function to show the exit confirmation dialog
  Future<void> _showExitConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit Game'),
          content: const Text('Are you sure you want to exit?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Go back to the previous screen
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/bg2.gif'), // Replace with your GIF path
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Back button positioned at the top left corner
            Positioned(
              top: 16.0,
              left: 16.0,
              child: ElevatedButton(
                onPressed: () {
                  _showExitConfirmationDialog(); // Call the confirmation dialog
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16.0),
                  backgroundColor: Colors
                      .transparent, // Make the button background transparent
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 32.0,
                ),
              ),
            ),

            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 18),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Add rounded corners
                          ),
                          elevation: 5, // Add elevation for shadow
                          shadowColor: Color.fromARGB(255, 232, 205, 152)
                              .withOpacity(0.5), // Set shadow color
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/game2');
                        },
                        child: const Text('1'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 18),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Add rounded corners
                          ),
                          elevation: 5, // Add elevation for shadow
                          shadowColor: Color.fromARGB(255, 232, 205, 152)
                              .withOpacity(0.5), // Set shadow color
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/game2');
                        },
                        child: const Text('2'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 18),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Add rounded corners
                          ),
                          elevation: 5, // Add elevation for shadow
                          shadowColor: Color.fromARGB(255, 232, 205, 152)
                              .withOpacity(0.5), // Set shadow color
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/game2');
                        },
                        child: const Text('3'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 18),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Add rounded corners
                          ),
                          elevation: 5, // Add elevation for shadow
                          shadowColor: Color.fromARGB(255, 232, 205, 152)
                              .withOpacity(0.5), // Set shadow color
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/game2');
                        },
                        child: const Text('4'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 18),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Add rounded corners
                          ),
                          elevation: 5, // Add elevation for shadow
                          shadowColor: Color.fromARGB(255, 232, 205, 152)
                              .withOpacity(0.5), // Set shadow color
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/game2');
                        },
                        child: const Text('5'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 18),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Add rounded corners
                          ),
                          elevation: 5, // Add elevation for shadow
                          shadowColor: Color.fromARGB(255, 232, 205, 152)
                              .withOpacity(0.5), // Set shadow color
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/game2');
                        },
                        child: const Text('6'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 18),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Add rounded corners
                          ),
                          elevation: 5, // Add elevation for shadow
                          shadowColor: Color.fromARGB(255, 232, 205, 152)
                              .withOpacity(0.5), // Set shadow color
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/game2');
                        },
                        child: const Text('7'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 18),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Add rounded corners
                          ),
                          elevation: 5, // Add elevation for shadow
                          shadowColor: Color.fromARGB(255, 232, 205, 152)
                              .withOpacity(0.5), // Set shadow color
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/game2');
                        },
                        child: const Text('8'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 18),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Add rounded corners
                          ),
                          elevation: 5, // Add elevation for shadow
                          shadowColor: Color.fromARGB(255, 232, 205, 152)
                              .withOpacity(0.5), // Set shadow color
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/game2');
                        },
                        child: const Text('9'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 18),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Add rounded corners
                          ),
                          elevation: 5, // Add elevation for shadow
                          shadowColor: Color.fromARGB(255, 232, 205, 152)
                              .withOpacity(0.5), // Set shadow color
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/game2');
                        },
                        child: const Text('10'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
