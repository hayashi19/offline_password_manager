// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:offline_passowrd_manager/controller/controller.dart';
import 'package:offline_passowrd_manager/models/list_model.dart';
import 'package:offline_passowrd_manager/pages/note_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePageController homePageController = Get.put(HomePageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Offline Password Store"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: () => ThemeService().switchTheme(),
              icon: homePageController.themeIcon.value)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Expanded(child: PwListHomePage()),
            Divider(height: 32),
            WarnHomePage()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(const NotePage()),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PwListHomePage extends StatelessWidget {
  const PwListHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePageController homePageController = Get.find();
    return Obx(() => ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 0.0),
          itemCount: homePageController.pwList.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (_) {
                Todo? removed = homePageController.pwList[index];
                homePageController.pwList.removeAt(index);
                Get.snackbar("Removed", removed.title,
                    mainButton: TextButton(
                        onPressed: () {
                          if (removed.isNull) {
                            return;
                          }
                          homePageController.pwList.insert(index, removed!);
                          removed = null;
                          if (Get.isSnackbarOpen) {
                            Get.back();
                          }
                        },
                        child: const Text("Undo")));
              },
              child: GestureDetector(
                onTap: () => Get.to(NotePageEdit(index: index)),
                child: Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Obx(() => Text(
                                  homePageController.pwList[index].title
                                      .toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )),
                            Checkbox(
                              value: homePageController.pwList[index].show,
                              onChanged: (value) {
                                var changed = homePageController.pwList[index];
                                changed.show = value!;
                                homePageController.pwList[index] = changed;
                              },
                            ),
                          ],
                        ),
                        Obx(() => Visibility(
                            visible: homePageController.pwList[index].show,
                            child: const Divider())),
                        Obx(() => Visibility(
                              visible: homePageController.pwList[index].show,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                      "Username: ${homePageController.pwList[index].username}"),
                                  IconButton(
                                    icon: const Icon(Icons.copy),
                                    iconSize: 16,
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(
                                          text: homePageController
                                              .pwList[index].username));
                                      Get.snackbar(
                                          "Username Copied",
                                          homePageController
                                              .pwList[index].username);
                                    },
                                  )
                                ],
                              ),
                            )),
                        Obx(() => Visibility(
                              visible: homePageController.pwList[index].show,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Obx(() => Text(
                                      "Password: ${homePageController.pwList[index].pw}")),
                                  IconButton(
                                    icon: const Icon(Icons.copy),
                                    iconSize: 16,
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(
                                          text: homePageController
                                              .pwList[index].pw));
                                      Get.snackbar("Password Copied",
                                          homePageController.pwList[index].pw);
                                    },
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (_, __) => const Divider(),
        ));
  }
}

class WarnHomePage extends StatelessWidget {
  const WarnHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Make sure to backup all passwords before deleting the app.",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
    );
  }
}
