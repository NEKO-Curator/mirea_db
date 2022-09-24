import 'package:flutter/material.dart';
import 'package:mirea_db_2/model/pos_model.dart';
import 'package:mirea_db_2/screens/card_detail.dart';

import '../services/db_helper.dart';
import '../widgets/pos_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 235, 69, 69),
          title: const Text('MYON Cafe'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await Navigator.push(
                context, MaterialPageRoute(builder: (context) => CardDetail()));
            setState(() {});
          },
          label: const Text('Добавить'),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.pink,
        ),
        body: FutureBuilder<List<Pos>?>(
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
                                          MaterialStateProperty.all(
                                              Colors.red)),
                                  onPressed: () async {
                                    await DBHelper.deletePos(
                                        snapshot.data![index]);
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
              return const Center(
                child: Text('Пока нет записей'),
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }
}
