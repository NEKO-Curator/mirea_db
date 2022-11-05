import 'package:flutter/material.dart';
import 'package:mirea_db/model/pos_model.dart';
import 'package:mirea_db/services/db_helper.dart';
import 'package:mirea_db/widgets/pos_widget.dart';

class LocalCardsNoRolePage extends StatefulWidget {
  const LocalCardsNoRolePage({super.key});

  @override
  State<LocalCardsNoRolePage> createState() => _LocalCardsNoRolePageState();
}

class _LocalCardsNoRolePageState extends State<LocalCardsNoRolePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pos>?>(
      future: DBHelper.getAllPos(),
      builder: (context, AsyncSnapshot<List<Pos>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          if (snapshot.data != null) {
            return ListView.builder(
              itemBuilder: (context, index) => PosWidget(
                pos: snapshot.data![index],
                onTap: () {},
                onLongPress: () {},
              ),
              itemCount: snapshot.data!.length,
            );
          }
        }
        return const Center(
          child: Text('Пока нет записей'),
        );
      },
    );
  }
}
