import 'package:flutter/material.dart';
import 'package:mirea_db/model/pos_model.dart';

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
        color: Colors.grey,
        elevation: 2.0,
        child: ListTile(
          leading: SizedBox(
            height: 100.0,
            width: 100.0, // fixed width and height
            child: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: pos.picture != null
                  ? Image.memory(pos.picture!)
                  : const Icon(Icons.add_a_photo),
            ),
          ),
          title: Text(pos.title),
          subtitle: Text(pos.description),
        ),
      ),
    );
  }
}
