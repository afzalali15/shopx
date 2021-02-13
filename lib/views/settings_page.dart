import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Artboard _riveArtboard;
  RiveAnimationController _controller;

  bool _isDarkTheme = false;

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/anims/git_theme.riv').then(
      (data) async {
        final file = RiveFile();

        if (file.import(data)) {
          final artboard = file.mainArtboard;

          artboard.addController(_controller = SimpleAnimation('to_light'));
          setState(() => _riveArtboard = artboard);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Icon(
                Icons.settings,
                size: 144,
                color: Colors.grey,
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Version 1.0.0'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.shop),
              title: Text('About Us'),
            ),
            Divider(),
            Flexible(
              child: Center(
                child: _riveArtboard == null
                    ? const SizedBox()
                    : Rive(artboard: _riveArtboard),
              ),
            ),
            Switch(
                value: _isDarkTheme,
                onChanged: (val) {
                  setState(() {
                    _isDarkTheme = val;
                  });
                  if (_isDarkTheme) {
                    Get.changeTheme(ThemeData.light());
                    _riveArtboard.removeController(_controller);
                    _riveArtboard.addController(
                        _controller = SimpleAnimation('to_light'));
                  } else {
                    Get.changeTheme(ThemeData.dark());
                    _riveArtboard.removeController(_controller);
                    _riveArtboard.addController(
                        _controller = SimpleAnimation('to_dark'));
                  }
                })
          ],
        ),
      ),
    );
  }
}
