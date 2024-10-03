import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../componants/job_card.dart';

class UploadJobScreen extends StatefulWidget {
  const UploadJobScreen({super.key});

  @override
  State<UploadJobScreen> createState() => _UploadJobScreenState();
}

class _UploadJobScreenState extends State<UploadJobScreen> {

  TextEditingController _jobCategoryController = TextEditingController(text: "Select Job Category");
  TextEditingController _jobTitleController = TextEditingController();
  TextEditingController _jobDescriptionController = TextEditingController();
  TextEditingController _jobDeadLineDateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  Widget _textTitles({required String lable}){
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        lable,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _textFormFeilds({
    required String valuekey,
    required TextEditingController controller,
    required bool enable,
    required Function fct,
    required int maxLength,
}){
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: (){
          fct();
        },
        child: TextFormField(
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Value is missing';
            }
            return null;
          },
          key: ValueKey(valuekey),
          style: const TextStyle(
            color: Colors.white,
          ),
          maxLines: valuekey == "JobDescription" ? 3 : 1,
          maxLength: maxLength,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.black54,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }

  // Function to show the date picker and format the selected date
  Future<void> _pickDateDialog() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // Can't pick a date in the past
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      setState(() {
        _jobDeadLineDateController.text = formattedDate; // Set the selected date in the text field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Upload Job",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Card(
                color: Colors.white38,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Please fill all your feilds",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(thickness: 1),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _textTitles(lable: "Job category :"),
                              _textFormFeilds(
                                valuekey: 'JobCategory',
                                controller: _jobCategoryController,
                                enable: false,
                                fct: (){},
                                maxLength: 100,
                              ),
                              _textTitles(lable: "Job Title :"),
                              _textFormFeilds(
                                valuekey: 'JobTitle',
                                controller: _jobTitleController,
                                enable: false,
                                fct: (){},
                                maxLength: 100,
                              ),
                              _textTitles(lable: "Job Description :"),
                              _textFormFeilds(
                                valuekey: 'JobDescription',
                                controller: _jobDescriptionController,
                                enable: false,
                                fct: (){},
                                maxLength: 100,
                              ),
                              _textTitles(lable: "Job DeadLine Date :"),
                              _textFormFeilds(
                                valuekey: 'Deadline',
                                controller: _jobDeadLineDateController,
                                enable: false,
                                fct: _pickDateDialog,
                                maxLength: 100,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 30),
                          child: _isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                              backgroundColor: Colors.green[500],
                              shadowColor: Colors.grey[400],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Post Now',
                                    style: TextStyle(fontSize: 18.0,color: Colors.grey[100]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
