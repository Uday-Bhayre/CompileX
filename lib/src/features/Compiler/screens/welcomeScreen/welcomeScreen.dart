import 'package:flutter/material.dart';
import 'package:login/src/common_widgets/languageButton.dart';
import 'package:login/src/constants/colors.dart';

class welcomeScreen extends StatelessWidget {
  const welcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    double height = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(103, 0, 200, 255),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image(
                  alignment: Alignment.center,
                  image: const AssetImage("assets/images/welcomeScreenImg.png"),
                  height: height * 0.3,
                ),
              ),
              const Text(
                'Let\'s Code',
                style: TextStyle(
                  height: 1,
                  fontFamily: 'dancingScript',
                  color: LWhiteColor,
                  fontSize: 40,
                ),
              ),
              const Text(
                " Put your logic to build a program",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'lora',
                  fontSize: 17,
                  color: Color.fromARGB(255, 168, 168, 168),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                child: Row(
                  children: [
                    Text(
                      "Choose your programming language",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'lora',
                        fontSize: 20,
                        color: Color.fromARGB(255, 15, 187, 89),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                indent: 10,
                endIndent: 20,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 20,
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Spacer(),
                      Spacer(),
                      languageButton(language: 'C++'),
                      Spacer(),
                      languageButton(language: 'Java'),
                      Spacer(),
                      Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Spacer(),
                      languageButton(language: 'Python'),
                      Spacer(),
                      languageButton(language: 'C'),
                      Spacer(),
                      Spacer(),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
