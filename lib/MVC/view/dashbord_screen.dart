import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rappid_note_app/MVC/controller/dynamic_link_handler.dart';
import 'package:rappid_note_app/MVC/view/add_nootes_screen.dart';

import '../controller/providers/notes_provider.dart';
import '../model/notes_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    DynamicLinkHandler().initDynamicLinks();
    super.initState();
  }

  void popExit() {}
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NotesProvider>(context);
    return PopScope(
      onPopInvoked: (didPop) => exit(0),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notes List'),
        ),
        body: StreamBuilder<List<Task>>(
          stream: viewModel.getNote(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final tasks = snapshot.data;

            return ListView.builder(
              itemCount: tasks?.length ?? 0,
              itemBuilder: (context, index) {
                final task = tasks?[index];
                log(task!.toJson().toString());
                return ListTile(
                  title: Text(
                    task?.title ?? "",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    task?.description ?? "",
                    style: TextStyle(color: Colors.black.withOpacity(0.7)),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddNotesScreen(
                        task: task,
                      ),
                    ));
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      DynamicLinkHandler().shareNoteLink(context, task);
                    },
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddNotesScreen(),
            ));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
