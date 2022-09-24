import 'package:flutter/material.dart';
import 'package:mirea_db_2/model/pos_model.dart';

class PosWidget extends StatelessWidget {
  const PosWidget(
      {Key? key,
      required this.pos,
      required this.onTap,
      required this.onLongPress})
      : super(key: key);
  final Pos pos;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        color: Colors.white,
        elevation: 2.0,
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.yellow,
            child: Icon(Icons.keyboard_arrow_right),
          ),
          title: Text(pos.title),
          subtitle: Text(pos.description),
        ),
      ),
    );
  }
}