import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Persistent/persistent.dart';
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

  String? selectedCategory;

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

  // Job Category dropdown menu implementation
  Widget _jobCategoryDropDown() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: DropdownButtonFormField<String>(
        value: selectedCategory,
        items: Persistent.jobCategoryList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child:  Text(
              value,
              style: const TextStyle(
                color: Colors.white, // White text for visibility
                fontSize: 16,
              ),
            ),
          );
        }).toList(),
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
        onChanged: (newValue) {
          setState(() {
            selectedCategory = newValue;
            _jobCategoryController.text = newValue!; // Store selected category in the controller
          });
        },
        hint: const Text(
          "Select Job Category",
          style: TextStyle(color: Colors.white),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a category';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          Expanded(
            child: Center(
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
                                _jobCategoryDropDown(),
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
                                  fct: (){},
                                  maxLength: 100,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: _isLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                              onPressed: (){},
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 100.0),
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
                                    const SizedBox(width: 9),
                                    Icon(
                                      Icons.upload_file,
                                      color: Colors.grey[100],
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
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
