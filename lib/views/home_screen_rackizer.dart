import 'package:expense/models/bill_model.dart';
import 'package:expense/models/custom_arc_painter.dart';
import 'package:expense/models/subscription_model.dart';
import 'package:expense/utils/color.dart';
import 'package:expense/widgets/subscription_items.dart';
import 'package:expense/widgets/upcoming_bill_items.dart';
import 'package:flutter/material.dart';

class HomeScreenRackizer extends StatefulWidget {
  const HomeScreenRackizer({super.key});

  @override
  State<HomeScreenRackizer> createState() => _HomeScreenRackizerState();
}

class _HomeScreenRackizerState extends State<HomeScreenRackizer> {
  bool isSuscription = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final items = isSuscription ? subscriptions : bills;
    return Scaffold(
      backgroundColor: gray,
      body: SingleChildScrollView(
        child: Column(
          children: [
            headerParts(size),
            subscriptionAndBill(),
            ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                if (isSuscription) {
                  final yourSub = items[index] as Subscription;
                  return SubscriptionItems(
                    subItems: {
                      "name": yourSub.name,
                      "icon": yourSub.icon,
                      "price": yourSub.price,
                    },
                  );
                } else {
                  final bill = items[index] as Bill;
                  return UpcomingBillItems(
                    subItems: {
                      "name": bill.name,
                      "price": bill.price,
                    },
                  );
                }
              },
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }

  Container subscriptionAndBill() {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(8),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: segmentButton(
                isActive: isSuscription,
                title: "Your subscription",
                onPressed: () {
                  setState(() {
                    isSuscription = !isSuscription;
                  });
                }),
          ),
          Expanded(
            child: segmentButton(
                isActive: !isSuscription,
                title: "Upcoming bills",
                onPressed: () {
                  setState(() {
                    isSuscription = !isSuscription;
                  });
                }),
          ),
        ],
      ),
    );
  }

  InkWell segmentButton({onPressed, required bool isActive, title}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(13),
      child: Container(
        decoration: isActive
            ? BoxDecoration(
                border: Border.all(
                  color: border.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(13))
            : null,
        alignment: Alignment.center,
        child: Text(title,
            style: TextStyle(
              color: isActive ? Colors.white : gray30,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            )),
      ),
    );
  }

  Container headerParts(Size size) {
    return Container(
      height: size.width * 1.1,
      decoration: BoxDecoration(
          color: gray70.withOpacity(0.5),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25))),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset("assets/img/home_bg.png"),
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: size.width * 0.05),
                width: size.width * 0.72,
                height: size.height * 0.72,
                child: CustomPaint(
                  painter: CustomArcPainter(end: 25),
                ),
              ),
              const Positioned(
                  right: -30,
                  top: 55,
                  child: Icon(
                    Icons.settings_outlined,
                    color: Colors.white54,
                    size: 32,
                  ))
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: size.width * 0.3,
              ),
              Image.asset(
                "assets/img/app_logo.png",
                width: size.width * 0.25,
              ),
              SizedBox(
                height: size.width * 0.07,
              ),
              const Text(
                "\₹1,235",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: size.width * 0.07,
              ),
              Text(
                "This month bills",
                style: TextStyle(
                  fontSize: 12,
                  color: gray40,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: size.width * 0.07,
              ),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: border.withOpacity(0.15),
                      ),
                      color: gray60.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15)),
                  child: const Text(
                    "See your budget",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: currentStatusButton(
                        title: "Active subs",
                        value: "18",
                        statusColor: secondary,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: currentStatusButton(
                        title: "Heighest subs",
                        value: "\₹12.89",
                        statusColor: primary10,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: currentStatusButton(
                        title: "Lowest subs",
                        value: "\₹10.90",
                        statusColor: secondaryG,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Stack currentStatusButton({title, value, statusColor}) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 70,
          decoration: BoxDecoration(
            border: Border.all(
              color: border.withOpacity(0.15),
            ),
            color: gray60.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(title,
                  style: TextStyle(
                    fontSize: 12,
                    color: gray40,
                    fontWeight: FontWeight.w600,
                  )),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        Container(
          width: 65,
          height: 1.5,
          color: statusColor,
        )
      ],
    );
  }
}
