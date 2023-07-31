import 'package:flutter/material.dart';

import 'package:task/Screens/ProductScreen.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key, required this.username});

  final String username;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    super.initState();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.ease);

    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_animation);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return FadeTransition(
      opacity: _animation,
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome to E-Shop",
                  style: TextStyle(fontSize: 40, color: Colors.white)),
              SizedBox(
                height: 50,
              ),
              Text(widget.username.toString(),
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(),
                      ),
                    );
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 170,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "GO TO PRODUCTS",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
