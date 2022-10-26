import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db/category_database/category_db.dart';
import 'package:money_manager/db/transaction_database/transaction_db.dart';
import 'package:money_manager/model/category/category_model.dart';
import 'package:money_manager/model/transaction/transaction_model.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
        return ListView.separated(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(10),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (ctx, index) {
              final value = newList[index];
              return Card(
                // color: value.type == CategoryType.income
                //     ? const Color.fromARGB(238, 135, 233, 128)
                //     : const Color.fromARGB(255, 248, 149, 114),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: value.type == CategoryType.income
                          ? const Color.fromARGB(0, 0, 255, 64)
                          : const Color.fromARGB(0, 255, 97, 69),
                      radius: 50,
                      child: Text(
                          parsedDate(
                            value.date,
                          ),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
                    title: Stack(
                      children: [
                        Text(
                          'Rs ${value.amount}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                       
                        Positioned(
                          right: 20,
                          bottom: 0,
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: value.type == CategoryType.income
                                  ? Color.fromARGB(236, 33, 209, 21)
                                  : Color.fromARGB(255, 234, 79, 22),
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      value.purpose,
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        TransactionDB.instance.deleteTransaction('${value.id}');
                      },
                      color: Colors.black,
                    )),
              );
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(height: 10);
            },
            itemCount: newList.length);
      },
    );
  }

  String parsedDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splittedDate = _date.split(' ');
    return '${_splittedDate.last}\n ${_splittedDate.first}';
  }
}
