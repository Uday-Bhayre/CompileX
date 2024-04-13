// ignore_for_file: avoid_print, camel_case_types

import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:highlight/languages/java.dart';
import 'package:highlight/languages/python.dart';


import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class codeEditorController extends GetxController {
  Rx<ThemeMode> currentTheme = ThemeMode.system.obs;
  double height = Get.mediaQuery.size.height;
  double width = Get.mediaQuery.size.width;
  final Rx<CodeController> codeController = CodeController().obs;
  final inputController = CodeController();
  WebSocketChannel? _channel;
  Rx<bool> isConnected = false.obs;
  Rx<TextSelection> codeFieldCursorPosition =
      TextSelection.fromPosition(const TextPosition(offset: 0)).obs;

  Rx<String> language = ''.obs;
  Rx<String> output = "".obs;
  Rx<bool> changeScreen = false.obs;
  Rx<bool> isInputRequired = false.obs;
  Rx<bool> compilationError = false.obs;
  String inputHint = 'i1n2p7u9t10';
  String comilationErrorHint = 'c10m9p7E2r1r:';
  String runTimeErrorHint = 'r10u9n7E2r1r:';
  Rx<bool> isLoading = true.obs;
  String uri = 'ws://192.168.43.191:3000';
  // String uri = 'wss://compilex-419318.el.r.appspot.com/:8080';







  void changeHighlight(String language) {
    if (language == 'c++' || language == 'c') {
      codeController.value.language = cpp;
    } else if (language == 'java') {
      codeController.value.language = java;
    } else if (language == 'python') {
      codeController.value.language = python;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    codeController.value.text = '';
    codeController.value.selection = codeFieldCursorPosition.value;
    await checkConnectivity();
    getConnectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      connectivityResult.value = result;
      getConnectivity();
    });
    if (isNetConnected) {

      _channel = IOWebSocketChannel.connect(uri);
      await _channel!.ready;
      isConnected.value = true;
      _channel!.stream.listen((message) {
        message = jsonDecode(message);
        if (message['output'] == null) {
        } else {
          isLoading.value = false;
          if (message['extraIp'] != null && message['extraIp'] >= 0) {
            isInputRequired.value = false;
            output.value += message['output'].replaceAll(inputHint, '');
          } else if (message['output'].trim().endsWith(inputHint)) {
            isInputRequired.value = true;
            output.value += message['output'].replaceAll(inputHint, '');
          } else if (message['output'].trim().contains(comilationErrorHint)) {
            compilationError.value = true;
            isInputRequired.value = false;
            output.value += message['output']
                .replaceAll(comilationErrorHint, '\nCompilation Error :- ');
          } else if (message['output'].trim().contains(runTimeErrorHint)) {
            compilationError.value = true;
            isInputRequired.value = false;
            output.value += message['output']
                .replaceAll(runTimeErrorHint, '\nRun Time Error :- ');
          } else {
            output.value += message['output'].trim();
          }
        }
      });
    }
  }

  void killProcess() {
    isLoading.value = true;
    final jsonCode = {
      "input": '',
      "isIpMode": false,
      'language': language.value,
      'closeProcess': true,
    }; // Creating JSON object
    final jsonString = json.encode(jsonCode); // Encoding JSON object to string
    if (isConnected.value) {
      _channel!.sink.add(jsonString);
    }
  }

  void submitInput() {
    final jsonCode = {
      "input": inputController.text,
      "isIpMode": true,
      'language': language.value,
      'closeProcess': false,
    }; // Creating JSON object

    output.value = '${output.value.trim()} ${inputController.text}\n';
    final jsonString = json.encode(jsonCode); // Encoding JSON object to string
    _channel!.sink.add(jsonString); // S
  }

  void compileAndRunCode() {
    isLoading.value = true;
    if (isNetConnected && isConnected.value) {
      output.value = ''; // Clear previous output
      isInputRequired.value = false;
      final jsonCode = {
        'code': codeController.value.text,
        'isIpMode': false,
        'language': language.value,
        'closeProcess': false,
      }; // Creating JSON object
      final jsonString =
          json.encode(jsonCode); // Encoding JSON object to string

      _channel!.sink.add(jsonString); // Sending JSON string to the backend
    } else {
      isLoading.value = false;
      if (isNetConnected) {
        output.value = 'Something went wrong...\nServer Error...';
      } else {
        output.value = 'Something went wrong...\nCheck internet connection... ';
      }
      compilationError.value = true;
    }
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: codeController.value.text));
    Fluttertoast.showToast(msg: 'Text copied to clipboard');
  }

  void pasteFromClipboard() {
    Clipboard.getData('text/plain').then((ClipboardData? data) {
      if (data != null && data.text != null) {
        codeController.value.text += data.text!;
        Fluttertoast.showToast(msg: 'Text pasted from clipboard');
      } else {
        Fluttertoast.showToast(msg: 'No text found in clipboard');
      }
    });
  }

  var connectivityResult = ConnectivityResult.none.obs;
  Future<void> checkConnectivity() async {
    ConnectivityResult result;
    try {
      result = await Connectivity().checkConnectivity();
    } catch (e) {
      print(e.toString());
      return;
    }
    connectivityResult.value = result;
  }

  bool isNetConnected = false;
  void getConnectivity() {
    switch (connectivityResult.value) {
      case ConnectivityResult.wifi:
        isNetConnected = true;
        return;
      case ConnectivityResult.mobile:
        isNetConnected = true;
        return;
      case ConnectivityResult.none:
        isNetConnected = false;
        return;
      default:
        isNetConnected = false;
        return;
    }
  }

  @override
  void dispose() {
    inputController.dispose();
    codeController.value.dispose();
    _channel!.sink.close();
    super.dispose();
  }
}
