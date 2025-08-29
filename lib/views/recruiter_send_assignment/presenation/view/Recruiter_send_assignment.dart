import 'package:flutter/material.dart';

import '../../../../UI_Helper/UI_Helper.dart';
import '../../../../Widgets/widgets.dart';

class SendAssignmentPage extends StatefulWidget {
  const SendAssignmentPage({Key? key}) : super(key: key);

  @override
  State<SendAssignmentPage> createState() => SendAssignmentPageState();
}

class SendAssignmentPageState extends State<SendAssignmentPage> {
  final TextEditingController messageController = TextEditingController(
    text:
    "Thank you for your interest in our internship opening. As a next step, we are expecting you to complete a short assignment.\n\nThanks,\nMansi",
  );
  final TextEditingController deadlineController = TextEditingController();

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        deadlineController.text =
        "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(titleText: "LOGO"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Send Assignment",
                style: mTextStyle32(mColor: Colors.black),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [

                  const Text("To:",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text("Nidhi Sharma",
                        style: TextStyle(color: Colors.black87)),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Message Box
              TextFormField(
                controller: messageController,
                maxLines: 8,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),

              // Attachment link
              InkWell(
                onTap: () {
                  // TODO: implement file picker
                },
                child: const Text(
                  "+ Attachment",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                "Maximum file size 5 MB\nOnly jpeg, jpg, png, gif, bmp, pdf, zip, xls, doc allowed",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 20),

              // Deadline picker
              TextFormField(
                controller: deadlineController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Submission deadline",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today_outlined),
                    onPressed: () => _selectDate(context),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 32),

              // Send Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Send assignment
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Send Assignment",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
