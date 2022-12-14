import 'package:crud/crud.dart';
import 'package:crud/page/components/email_input.dart';
import 'package:crud/page/components/pw_input.dart';
import 'package:crud/page/homepage.dart';
import 'package:crud/provider/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  bool _obsecureText = true;
  @override
  Widget build(BuildContext context) {
    return Consumer2<appColor, tColor>(
      builder: (context, appColor, tColor, child) => Scaffold(
          backgroundColor: appColor.color,
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const RoundedInput(
                    icon: Icons.email,
                    hint: '',
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Password(
                    icon: Icons.lock,
                    hint: 'Masukan Password Anda',
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => Crud()),
                          ),
                        );
                      },
                      child: Text('Login')),
                  const SizedBox(
                    height: 40,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        (MaterialPageRoute(
                          builder: ((context) => HomePage()),
                        )),
                      );
                    },
                    child: CircleAvatar(
                        child: Transform(
                      transform: Matrix4.translationValues(1, -2, 0),
                      child: Text(
                        '>',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 28,
                        ),
                      ),
                    )),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Text(
                          'LM',
                          style: TextStyle(color: tColor.warna),
                        ),
                        FlutterSwitch(
                            value: appColor.isThemeDark,
                            onToggle: (newValue) {
                              appColor.isThemeDark = newValue;
                              tColor.isTextDark = newValue;
                            }),
                        Text(
                          'DM',
                          style: TextStyle(color: tColor.warna),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
