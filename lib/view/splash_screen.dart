import 'package:flutter/material.dart';
import 'package:project1/authentication/login.dart';

import 'app_screens/main_screen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Image(
                  image: AssetImage(
                      'assets/1.jpg'),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, ),
              child: Text(
                'We provide high quality products just for you!',
                style: TextStyle(
                  color:Colors.grey[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(flex:2),
            GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder:(context)=>LoginScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Container(
                  height: 50,
                  width: 350,
                  decoration: const BoxDecoration(color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: const Center(
                    child: Text(
                      'Get Started',
                      style: TextStyle(color: Colors.white),
                    ),),),
              ),
            ),
            const Spacer(flex: 1,)
          ],
        ));
  }
}
