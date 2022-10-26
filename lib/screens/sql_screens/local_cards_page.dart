import 'package:flutter/material.dart';
import 'package:mirea_db/model/pos_model.dart';
import 'package:mirea_db/services/db_helper.dart';
import 'package:mirea_db/widgets/pos_widget.dart';

import 'card_detail.dart';

class LocalCardsWidget extends StatefulWidget {
  const LocalCardsWidget({super.key});

  @override
  State<LocalCardsWidget> createState() => _LocalCardsWidgetState();
}

class _LocalCardsWidgetState extends State<LocalCardsWidget> {
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
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CardDetail(
                        pos: snapshot.data![index],
                      ),
                    ),
                  );
                  setState(() {});
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
                                setState(() {});
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
        }
        return const Center(
          child: Text('Пока нет записей'),
        );
      },
    );
  }
}
