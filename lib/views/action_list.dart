import 'package:dnd_helper/models/monster.dart' as mon;
import 'package:flutter/material.dart';

class ActionList extends StatelessWidget {
  final List<mon.Action> actions;
  final String title;
  const ActionList(this.title, this.actions, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        ListView.builder(
          itemCount: actions.length,
          primary: false,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Column(
                  children: [
                    Text(actions[index].name!),
                    Text(actions[index].desc!),
                  ],
                )
              )
            );
          },
        ),
      ],
    );
  }
}
