import 'package:flutter/material.dart';
import 'package:money_manager/screen/category/category_add_popup.dart';
import 'package:money_manager/screen/category/screen_catogory.dart';
import 'package:money_manager/screen/home/widgets/bottom_nav_bar.dart';
import 'package:money_manager/screen/transaction/screen_transaction.dart';

import '../transaction/screen_add_transaction.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [
    ScreenTransaction(),
    ScreenCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: const Text(
          'MONEY MANAGER',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        toolbarHeight: 75,
        elevation: 0,
        backgroundColor: Colors.blueGrey[50],
      ),
      bottomNavigationBar: const BottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updatedIndex, Widget? _) {
            return _pages[updatedIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            Navigator.of(context).pushNamed(ScreenAddTransaction.routeName);
          } else {
            showCategoryAddPopup(context);

            // final _samplecategory = CategoryModel(
            //     id: DateTime.now().millisecondsSinceEpoch.toString(),
            //     name: 'Travel',
            //     type: CategoryType.expense);
            // CategoryDB().insertCategory(_samplecategory);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
