import 'package:flutter/material.dart';
import 'package:job_portal/ui_helper/ui_helper.dart';
import 'package:job_portal/widgets/widgets.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class RecruiterCreateQuickTicket extends StatefulWidget {
  const RecruiterCreateQuickTicket({super.key});

  @override
  State<RecruiterCreateQuickTicket> createState() =>
      _RecruiterCreateQuickTicketState();
}

class _RecruiterCreateQuickTicketState
    extends State<RecruiterCreateQuickTicket> {
  int? selectedPriorityIndex; // 0 = Low, 1 = Medium, 2 = High
  final List<String> priorities = ['Low', 'Medium', 'High'];
  TextEditingController eController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Support",
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
        )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create Quick Ticket",
              style: mTextStyle32(mColor: Colors.black),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Write and address new queries and issues",
              style: mTextStyle12(),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Customer Email",
              style: mTextStyle12(),
            ),
            SizedBox(
              height: 4,
            ),
            CustomTextField(
              controller: eController,
              hintText: "amangupta@gmail.com",
              fillColor: Color(0xffFFF7FB),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Ticket Priority",
              style: mTextStyle12(),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 46,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(priorities.length, (index) {
                  return Row(
                    children: [
                      RoundCheckBox(
                        size: 25,
                        isChecked: selectedPriorityIndex == index,
                        onTap: (selected) {
                          setState(() {
                            selectedPriorityIndex = selected! ? index : null;
                          });
                        },
                      ),
                      const SizedBox(width: 6),
                      Text(priorities[index], style: mTextStyle12()),
                      // const SizedBox(height: 6),
                    ],
                  );
                }),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Ticket Body",
              style: mTextStyle12(),
            ),
            SizedBox(
              height: 4,
            ),
            CustomTextField(
              controller: ticketController,
              hintText: "Type your issue here...",
              fillColor: Color(0xffFFF7FB),
            ),
            SizedBox(
              height: 25,
            ),
            commonRedContainer(text: "Submit", onTap: () {})
          ],
        ),
      ),
    );
  }
}
