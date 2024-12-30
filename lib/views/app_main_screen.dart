import 'package:expense/views/card_view.dart';
import 'package:expense/views/home_screen_rackizer.dart';
import 'package:expense/views/spending_and_budgets.dart';
import 'package:flutter/material.dart';
import 'package:expense/Utils/color.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int selectedIndex = 0;
  final PageStorageBucket _pageStorageBucket = PageStorageBucket();
  final List<Widget> _tabs = [
    const HomeScreenRackizer(),
    const SpendingAndBudgets(),
    const Scaffold(),
    const CardView(),
  ];
  void onTabSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray,
      body: Stack(
        children: [
          PageStorage(bucket: _pageStorageBucket, child: _tabs[selectedIndex]),
          SafeArea(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.asset("assets/img/bottom_bar_bg.png"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            buildTabIcon(
                                iconPath: "assets/img/home.png", index: 0),
                            buildTabIcon(
                                iconPath: "assets/img/budgets.png", index: 1),
                            const SizedBox(
                              width: 50,
                              height: 50,
                            ),
                            buildTabIcon(
                                iconPath: "assets/img/calendar.png", index: 2),
                            buildTabIcon(
                                iconPath: "assets/img/creditcards.png",
                                index: 3)
                          ],
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            child: Image.asset(
                              "assets/img/center_btn.png",
                              width: 55,
                              height: 55,
                            ),
                          ),
                        )
                      ],
                    ),
                  )))
        ],
      ),
    );
  }

  IconButton buildTabIcon({required String iconPath, required int index}) =>
      IconButton(
          onPressed: () => onTabSelected(index),
          icon: Image.asset(
            iconPath,
            width: 23,
            height: 23,
            color: selectedIndex == index ? Colors.white : gray30,
          ));
}
