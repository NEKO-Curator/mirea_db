import 'package:flutter/material.dart';
import 'package:mirea_db/model/pos_model.dart';
import 'package:mirea_db/screens/sql_screens/card_detail.dart';
import 'package:mirea_db/services/db_helper.dart';
import 'package:mirea_db/widgets/pos_widget.dart';

class LocalCardsAdminPage extends StatefulWidget {
  const LocalCardsAdminPage({super.key});

  @override
  State<LocalCardsAdminPage> createState() => _LocalCardsAdminPageState();
}

class _LocalCardsAdminPageState extends State<LocalCardsAdminPage> {
  void _updateLocal() {
    setState(() {});
  }

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
                        key: UniqueKey(),
                      ),
                    ),
                  );
                  _updateLocal();
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
        }
        return const Center(
          child: Text('Пока нет записей'),
        );
      },
    );
  }
}
