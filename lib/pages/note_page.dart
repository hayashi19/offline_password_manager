// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline_passowrd_manager/controller/controller.dart';
import 'package:offline_passowrd_manager/models/list_model.dart';

class NotePage extends StatelessWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePageController homePageController = Get.put(HomePageController());
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListView(children: const <Widget>[
            TitleInputNotePage(),
            Divider(),
            UsernameInputNotePage(),
            PwInputNotePage(),
            RandomPwNotePage(),
            Divider(height: 32),
            PwSettingNotePage(),
            Divider(),
            NoteNotePage(),
            BackButtonNotePage()
          ]),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => homePageController.savedPw(),
            child: const Icon(Icons.save)));
  }
}

class NotePageEdit extends StatelessWidget {
  const NotePageEdit({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final HomePageController homePageController = Get.put(HomePageController());
    homePageController.titleInputController.text =
        homePageController.pwList[index].title;
    homePageController.userInputController.text =
        homePageController.pwList[index].username;
    homePageController.pwInputController.text =
        homePageController.pwList[index].pw;
    homePageController.noteInputController.text =
        homePageController.pwList[index].note;
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListView(children: const <Widget>[
            TitleInputNotePage(),
            Divider(),
            UsernameInputNotePage(),
            PwInputNotePage(),
            RandomPwNotePage(),
            Divider(height: 32),
            PwSettingNotePage(),
            Divider(),
            NoteNotePage(),
            BackButtonNotePage()
          ]),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (index.isNull) {
                homePageController.savedPw();
              } else {
                homePageController.pwList.insert(
                    index,
                    Todo(
                        title: homePageController.titleInputController.text,
                        username: homePageController.userInputController.text,
                        pw: homePageController.pwInputController.text,
                        note: homePageController.noteInputController.text,
                        show: false));
                homePageController.pwList.removeAt(index + 1);
                // homePageController.pwList.
                // homePageController.pwList[index].title =
                //     homePageController.titleInputController.text;
                // homePageController.pwList[index].username =
                //     homePageController.userInputController.text;
                // homePageController.pwList[index].pw =
                //     homePageController.pwInputController.text;
                // homePageController.pwList[index].note =
                //     homePageController.noteInputController.text;
                homePageController.titleInputController.clear();
                homePageController.userInputController.clear();
                homePageController.pwInputController.clear();
                homePageController.noteInputController.clear();
                Get.back();
              }
            },
            child: const Icon(Icons.save)));
  }
}

class TitleInputNotePage extends StatelessWidget {
  const TitleInputNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePageController homePageController = Get.find();
    return Padding(
        padding: const EdgeInsets.only(right: 16),
        child: TextField(
          controller: homePageController.titleInputController,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.title),
            hintText: "Title name for the password . . .",
          ),
        ));
  }
}

class UsernameInputNotePage extends StatelessWidget {
  const UsernameInputNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePageController homePageController = Get.find();
    return Card(
      elevation: 4,
      child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: TextField(
            controller: homePageController.userInputController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: "username or email . . .",
                border: InputBorder.none,
                focusedBorder: InputBorder.none),
          )),
    );
  }
}

class PwInputNotePage extends StatelessWidget {
  const PwInputNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePageController homePageController = Get.find();
    return Card(
      elevation: 4,
      child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: TextField(
            controller: homePageController.pwInputController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.password),
                hintText: "password . . .",
                border: InputBorder.none,
                focusedBorder: InputBorder.none),
          )),
    );
  }
}

class RandomPwNotePage extends StatelessWidget {
  const RandomPwNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePageController homePageController = Get.find();
    return ElevatedButton.icon(
        onPressed: () => homePageController.randPw(),
        icon: const Icon(Icons.key),
        label: const Text("Random Password"));
  }
}

class PwSettingNotePage extends StatelessWidget {
  const PwSettingNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePageController homePageController = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          "Password Settings",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Obx(() => CheckboxListTile(
            title: const Text(
              "Use Letter?",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            value: homePageController.isLetter.value,
            onChanged: (value) => homePageController.isLetter.value = value!)),
        Obx(() => CheckboxListTile(
            title: const Text(
              "Use Number?",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            value: homePageController.isNumber.value,
            onChanged: (value) => homePageController.isNumber.value = value!)),
        Obx(() => CheckboxListTile(
            title: const Text(
              "Use Special Char?",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            value: homePageController.isSpecialChar.value,
            onChanged: (value) =>
                homePageController.isSpecialChar.value = value!)),
        Obx(() => CheckboxListTile(
            title: const Text(
              "Use Uppercase?",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            value: homePageController.isUppercase.value,
            onChanged: (value) =>
                homePageController.isUppercase.value = value!)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Lenght?"),
            Obx(() => Slider(
                value: homePageController.whatPasswordLenght.value,
                max: 32,
                min: 4,
                divisions: 14,
                label: homePageController.whatPasswordLenght.round().toString(),
                onChanged: (value) =>
                    homePageController.whatPasswordLenght.value = value)),
            Obx(() => Text(
                "${homePageController.whatPasswordLenght.round().toString()} Chars"))
          ],
        )
      ],
    );
  }
}

class NoteNotePage extends StatelessWidget {
  const NoteNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePageController homePageController = Get.find();
    return Card(
      elevation: 4,
      child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: TextField(
            controller: homePageController.noteInputController,
            keyboardType: TextInputType.multiline,
            minLines: 3,
            maxLines: null,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.border_color),
                hintText: "note for this password . . .",
                border: InputBorder.none,
                focusedBorder: InputBorder.none),
          )),
    );
  }
}

class BackButtonNotePage extends StatelessWidget {
  const BackButtonNotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.back();
      },
      child: const Text("BACK"),
      // color: Colors.redAccent,
    );
  }
}
