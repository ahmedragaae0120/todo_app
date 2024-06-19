import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/layout/home/provider/home_provider.dart';
import 'package:todo_app/model/settings_model.dart';
import 'package:todo_app/shared/providers/auth_provider.dart';
import 'package:todo_app/shared/remote/firestore/firestore_helper.dart';

class settingsTab extends StatefulWidget {
  const settingsTab({super.key});

  @override
  State<settingsTab> createState() => _settingsTabState();
}

class _settingsTabState extends State<settingsTab> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    authprovider provider = Provider.of<authprovider>(context);
    homeProvider providerhome = Provider.of<homeProvider>(context);
    settingsModel settings = settingsModel();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.2,
        title: Text("Settings", style: TextStyle(fontSize: 25)),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Language",
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary, fontSize: 24),
        ),
        SizedBox(height: height * 0.02),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              border: Border.all(color: Theme.of(context).colorScheme.primary)),
          child: DropdownButton(
            value: providerhome.dropdownLanguage,
            isExpanded: true,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary, fontSize: 20),
            padding: EdgeInsets.symmetric(horizontal: 50),
            items: [
              DropdownMenuItem(
                value: "en",
                child: Text("English"),
                onTap: () {},
              ),
              DropdownMenuItem(
                value: "ar",
                child: Text("Arabic"),
                onTap: () {},
              ),
            ],
            onChanged: (String? newLanguage) {
              setState(() {
                providerhome.changedropdownLanguage(newLanguage!);
                firestoreHelper.editSettings(
                  userid: provider.firebaseAuthUser!.uid,
                  settingsId: settingsModel.settingsID!,
                  settingsUser: settingsModel(
                      language: providerhome.dropdownLanguage,
                      theme: providerhome.dropdownMode),
                );
              });
            },
            borderRadius: BorderRadius.circular(10),
            dropdownColor: Theme.of(context).colorScheme.onPrimary,
            elevation: 10,
          ),
        ),
        SizedBox(height: height * 0.02),
        Text(
          "Mode",
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary, fontSize: 24),
        ),
        SizedBox(height: height * 0.02),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              border: Border.all(color: Theme.of(context).colorScheme.primary)),
          child: DropdownButton(
            value: providerhome.dropdownMode,
            isExpanded: true,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary, fontSize: 20),
            padding: EdgeInsets.symmetric(horizontal: 50),
            items: [
              DropdownMenuItem(
                value: "Light",
                child: Text("Light"),
                onTap: () {},
              ),
              DropdownMenuItem(
                value: "dark",
                child: Text("dark"),
                onTap: () {},
              ),
            ],
            onChanged: (String? newMode) {
              setState(() {
                providerhome.changedropdownMode(newMode!);
                firestoreHelper.editSettings(
                  userid: provider.firebaseAuthUser!.uid,
                  settingsId: settingsModel.settingsID!,
                  settingsUser: settingsModel(
                      theme: providerhome.dropdownMode,
                      language: providerhome.dropdownLanguage),
                );
              });
              print(providerhome.dropdownMode);
            },
            borderRadius: BorderRadius.circular(10),
            dropdownColor: Theme.of(context).colorScheme.onPrimary,
            elevation: 10,
          ),
        ),
      ]),
    );
  }
}
