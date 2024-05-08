import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/screens/setting_screen/theme_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    // final proVar = Provider.of<ThemeProvider>(context,listen: true);
    final providerVar = Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: (providerVar.getTheme == true)
          ? Colors.transparent
          : Color(0xff5084E9),
      appBar: AppBar(
        backgroundColor: (providerVar.getTheme == true)
            ? Colors.transparent
            : Color(0xff5084E9),
        title: Text(
          'Setting',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              CupertinoIcons.back,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Theme',
                  style: TextStyle(
                      color: (providerVar.getTheme == true)
                          ? Colors.black38
                          : Colors.black38),
                ),
                Switch(
                    value: providerVar.getTheme,
                    onChanged: (value) {
                      setState(() {
                        providerVar.setTheme = value;
                      });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
