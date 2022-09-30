import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'package:offline_passowrd_manager/models/list_model.dart';

class HomePageController extends GetxController with StateMixin<List<Todo>> {
  // Todo todo;
  // HomePageController(this.todo);
  // Theme icon toggle
  var themeIcon = const Icon(Icons.dark_mode).obs;

  // List to store the password and username
  RxList<Todo> pwList = (List<Todo>.of([])).obs;

  TextEditingController titleInputController = TextEditingController();
  TextEditingController userInputController = TextEditingController();
  TextEditingController pwInputController = TextEditingController();
  TextEditingController noteInputController = TextEditingController();

  // set var to store the value of random password generator criteria
  var isLetter = true.obs;
  var isNumber = true.obs;
  var isSpecialChar = true.obs;
  var isUppercase = true.obs;
  var whatPasswordLenght = (12.0).obs;

  // function to generate random password based on criteria
  randPw() {
    pwInputController.text = RandomPasswordGenerator().randomPassword(
        letters: isLetter.value,
        numbers: isNumber.value,
        specialChar: isSpecialChar.value,
        uppercase: isUppercase.value,
        passwordLength: whatPasswordLenght.value);
    debugPrint(pwInputController.text);
  }

  // function to saved the pw to the list
  savedPw() {
    pwList.add(Todo(
        title:
            titleInputController.text.isEmpty ? "" : titleInputController.text,
        username:
            userInputController.text.isEmpty ? "" : userInputController.text,
        pw: pwInputController.text.isEmpty ? "" : pwInputController.text,
        note: noteInputController.text.isEmpty ? "" : noteInputController.text,
        show: false));
    Get.back();
    Get.snackbar(titleInputController.text,
        "your username ${userInputController.text} and password ${pwInputController.text} saved.");
    titleInputController.clear();
    userInputController.clear();
    pwInputController.clear();
    noteInputController.clear();
  }

  // Store to local storage
  @override
  void onInit() {
    List? storedPw = GetStorage().read<List>('pw_list');
    // ignore: deprecated_member_use
    if (!storedPw.isNull) {
      pwList = RxList(storedPw!.map((e) => Todo.fromJson(e)).toList());
    }
    ever(pwList, (_) {
      GetStorage().write('pw_list', pwList.toList());
    });
    super.onInit();
  }
}

class ThemeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  /// Get isDarkMode info from local storage and return ThemeMode
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  /// Load isDArkMode from local storage and if it's empty, returns false (that means default theme is light)
  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  /// Save isDarkMode to local storage
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  /// Switch theme and save to local storage
  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
