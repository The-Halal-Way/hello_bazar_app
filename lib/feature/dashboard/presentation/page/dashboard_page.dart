// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hello_bazar/core/util/my_dimens.dart';

enum LogLevel { info, warning, error, debug }

class Clash {
  final String name;
  final LogLevel level;
  const Clash({required this.name, required this.level});
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  void logMessage(String message, LogLevel level) => print(message);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyDimens().getNormalAppBar("Dashboard", [], context),
      body: SafeArea(
        child: Padding(
          padding: const.all(10),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              ElevatedButton(
                onPressed: () {
                  final item = Clash(name: "jb", level: LogLevel.warning);
                  logMessage("Log Msg 1 !", .warning);
                  if (item.level == .error) print("conditionz Error");
                },
                child: Text("Submit"),
              ),
              Stack(fit: .expand, children: []),
              Container(constraints: .expand()),
              Container(decoration: BoxDecoration(shape: .circle)),
            ],
          ),
        ),
      ),
    );
  }
}
