import 'package:flutter/material.dart';

import '../model/pos_model.dart';
import '../services/db_helper.dart';
import '../widgets/pos_widget.dart';
import 'card_detail.dart';

class LocalCardsWidget extends StatelessWidget {
  const LocalCardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pos>?>(
      future: DBHelper.getAllPos(),
      builder: (context, AsyncSnapshot<List<Pos>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          if (snapshot.data != null) {
            return ListView.builder(
              itemBuilder: (context, index) => PosWidget(
                pos: snapshot.data![index],
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CardDetail(
                                pos: snapshot.data![index],
                              )));
                },
                onLongPress: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Уверены, что хотите удалить?'),
                          actions: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              onPressed: () async {
                                await DBHelper.deletePos(snapshot.data![index]);
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              },
                              child: const Text('Да'),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Нет'),
                            ),
                          ],
                        );
                      });
                },
              ),
              itemCount: snapshot.data!.length,
            );
          }
          return const Center(
            child: Text('Пока нет записей'),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
