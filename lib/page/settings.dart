import 'package:crud/provider/uiset.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Consumer<anjaySize>(
      builder: (context, Uiset, child) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              ListTile(
                title: Text('${Uiset.fontSize.toInt()}'),
                subtitle: Slider(
                  min: 0.5,
                  value: Uiset.sliderfontSize,
                  onChanged: (newValue) {
                    Uiset.fontSize = newValue;
                  },
                ),
              ),
              Text(
                'ASW',
                style: TextStyle(fontSize: Uiset.fontSize),
              )
            ],
          ),
        ),
      ),
    );
  }
}
