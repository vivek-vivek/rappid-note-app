import 'dart:convert';
import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../main.dart';
import '../model/notes_model.dart';
import '../view/add_nootes_screen.dart';

final class DynamicLinkHandler {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future<void> shareNoteLink(BuildContext context, Task? task) async {
    try {
      if (task != null) {
        // Generate a dynamic link for the note
        final DynamicLinkParameters parameters = DynamicLinkParameters(
          uriPrefix:
              'rappidnotes.page.link', // Replace with your Dynamic Links domain
          link: Uri.parse(
              'https://rappidnotes.page.link/notes_screen/${task.toJson()}'),
          androidParameters: const AndroidParameters(
            packageName: 'com.example.rappid_note_app',
          ),
        );

        final shareLink = await dynamicLinks.buildLink(parameters);

        log("https://$shareLink", name: "LINK");

        await Share.share("https://$shareLink");
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  initDynamicLinks() {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      // Listen and retrieve dynamic links here
      final String deepLink = dynamicLinkData.link.toString(); // Get DEEP LINK
      // Ex: https://namnp.page.link/product/013232
      final String path = dynamicLinkData.link.path; // Get PATH
      // Ex: product/013232
      if (deepLink.isEmpty) return;
      handleDeepLink(path);
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  Future<void> initUniLinks() async {
    try {
      final initialLink = await dynamicLinks.getInitialLink();
      if (initialLink == null) return;
      handleDeepLink(initialLink.link.path);
    } catch (e) {
      // Error
    }
  }

  void handleDeepLink(String path) {
    final task = convertUrlToTask(path);

    navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) => AddNotesScreen(task: task)));
  }
}

Task? convertUrlToTask(String path) {
  try {
    // Decoding the URL-encoded string
    String jsonString = Uri.decodeFull(path.split("/notes_screen/")[1]);

    // Convert keys and string values to valid JSON format
    jsonString = jsonString.replaceAllMapped(
        RegExp(r'([a-zA-Z0-9_]+)(?=:)'), (match) => '"${match.group(0)}"');

    jsonString = jsonString.replaceAllMapped(RegExp(r':\s*([^,}]+)'), (match) {
      final value = match.group(1);
      if (value == null || value.startsWith('"')) {
        return match.group(0)!;
      }
      return ': "${value.trim()}"';
    });

    log(jsonString);

    // Parsing JSON
    Map<String, dynamic> jsonMap = json.decode(jsonString.trim());

    // Parsing JSON
    final task = Task.fromJson(jsonMap);

    // Printing the result
    return task;
  } catch (e) {
    print('Error converting URL to Task: $e');
    return Task(title: '', description: '', date: null, id: '');
  }
}
