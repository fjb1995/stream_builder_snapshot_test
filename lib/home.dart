import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/home_controller.dart';

class Home extends GetView<HomeControllerImp> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addData();
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          StreamBuilder(
            stream: controller.notesRef.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Error when loading data');
              }
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text('${snapshot.data?.docs[index]['title']}'),
                        subtitle: Row(
                          children: [
                            Text('${snapshot.data?.docs[index]['note']}'),
                            const SizedBox(width: 10),
                            Text('${snapshot.data?.docs.length}'),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance.runTransaction(
                                (Transaction myTransaction) async {
                              myTransaction
                                  .delete(snapshot.data!.docs[index].reference);
                            });
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        leading: IconButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance.runTransaction(
                                (Transaction myTransaction) async {
                              myTransaction
                                  .delete(snapshot.data!.docs[index].reference);
                            });
                            controller.transferData(
                              snapshot.data?.docs[index]['title'],
                              snapshot.data?.docs[index]['note'],
                            );
                          },
                          icon: const Icon(Icons.done_all),
                        ),
                      ),
                    );
                  },
                );
              }
              return const Text('Loading');
            },
          ),
          const Divider(),
          StreamBuilder(
            stream: controller.archiveRef.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Error when loading data');
              }
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text('${snapshot.data?.docs[index]['title']}'),
                        subtitle: Text('${snapshot.data?.docs[index]['note']}'),
                        trailing: IconButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance.runTransaction(
                                (Transaction myTransaction) async {
                              myTransaction
                                  .delete(snapshot.data!.docs[index].reference);
                            });
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ),
                    );
                  },
                );
              }
              return const Text('Loading');
            },
          ),
        ],
      ),
    );
  }
}
