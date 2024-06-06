import 'package:dynatrace_flutter_plugin/dynatrace_flutter_plugin.dart';
import 'package:flutter/material.dart';

class PlaygroundPage extends StatelessWidget {
  const PlaygroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Dynatrace tests"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("Press this button to opt-in to Dynatrace monitoring."),
            ElevatedButton(
              onPressed: () {
                // Set data collection to true.
                // In a real app, we should ask the user's permission before
                // doing this (for example in a banner).
                Dynatrace().applyUserPrivacyOptions(
                    UserPrivacyOptions(DataCollectionLevel.UserBehavior, true));
              },
              child: const Text("Opt-in"),
            ),
            const SizedBox(height: 20),
            const Text("Press this button to send an event with metrics."),
            ElevatedButton(
              onPressed: () {
                // Begin the action (something the user is doing); then add
                // things to the action (events, errors or crashes) and then
                // finish the action.
                var action =
                    Dynatrace().enterAction("Playground action in Flutter");
                action.reportEvent("Playground event in Flutter");
                action.reportIntValue("Playground metric in Flutter", 5);
                action.leaveAction();
                Dynatrace().flushEvents();
              },
              child: const Text("Send event"),
            ),
            const SizedBox(height: 20),
            const Text("Press this button to send an event with an error."),
            ElevatedButton(
              onPressed: () {
                var action =
                    Dynatrace().enterAction("Playground action in Flutter");
                action.reportEvent("Playground event in Flutter");
                action.reportError("Playground error in Flutter", 500);
                action.leaveAction();
                Dynatrace().flushEvents();
              },
              child: const Text("Send event with error"),
            ),
            const SizedBox(height: 20),
            const Text("Press this button to send a business event."),
            ElevatedButton(
              onPressed: () {
                Dynatrace().sendBizEvent("Business event in Flutter", {
                  "name": "Custom event sent from Flutter",
                  "date": DateTime.now().toIso8601String(),
                  "forty": 40,
                });
              },
              child: const Text("Send business event"),
            ),
          ],
        ),
      ),
    );
  }
}
