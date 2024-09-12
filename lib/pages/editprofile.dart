import 'package:flutter/material.dart';

class EProfilePage extends StatefulWidget {
  @override
  _EProfilePageState createState() => _EProfilePageState();
}

class _EProfilePageState extends State<EProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String? _gender = 'Male';
  String? _userType = 'Fresher';
  String? _course = 'BCA';
  String? _specialization = 'Computer Science';
  DateTime? _dob;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('lib/assets/img.jpg'),
                ),
                const SizedBox(height: 16),
                _buildTextField('First Name', 'Yogendra'),
                SizedBox(height: 12),
                _buildTextField('Last Name', 'Nimje'),
                SizedBox(height: 12),
                _buildDisabledTextField('Username', '483yonim2786'),
                SizedBox(height: 12),
                _buildDisabledTextField('Email', 'yogendranimje87@gmail.com'),
                SizedBox(height: 12),
                _buildTextField('Mobile', '8347925393'),
                const SizedBox(height: 16),
                _buildGenderSelector(),
                _buildUserTypeSelector(),
                const SizedBox(height: 16),
                _buildDropdownField('Course', _course, ['BCA', 'BBA', 'BCom']),
                const SizedBox(height: 12),
                _buildDropdownField('Specialization', _specialization, ['Computer Science', 'Marketing', 'Finance']),
                SizedBox(height: 12),
                _buildCourseDuration(),
                const SizedBox(height: 12),
                _buildTextField('College', 'SDJ International College, Surat'),
                const SizedBox(height: 12),
                _buildDatePicker(context),
                const SizedBox(height: 12),
                _buildAddressFields('Current Address'),
                const SizedBox(height: 12),
                _buildAddressFields('Permanent Address'),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Save basic details
                    }
                  },
                  child: const Text('Save'),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String initialValue) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDisabledTextField(String label, String value) {
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      enabled: false,
    );
  }

  Widget _buildGenderSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Gender'),
        Row(
          children: [
            Radio(
              activeColor: Colors.green,
              value: 'Male',
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value;
                });
              },
            ),
            Text('Male'),
            Radio(
              activeColor: Colors.green,
              value: 'Female',
              groupValue: _gender,
              onChanged: (value) {
                setState(() {
                  _gender = value;
                });
              },
            ),
            Text('Female'),
          ],
        ),
      ],
    );
  }

  Widget _buildUserTypeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('User Type'),
        Row(
          children: [
            Radio(
              activeColor: Colors.green,
              value: 'Fresher',
              groupValue: _userType,
              onChanged: (value) {
                setState(() {
                  _userType = value;
                });
              },
            ),
            const Text('Fresher'),
            Radio(
              activeColor: Colors.green,
              value: 'Professional',
              groupValue: _userType,
              onChanged: (value) {
                setState(() {
                  _userType = value;
                });
              },
            ),
            const Text('Professional'),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, String? currentValue, List<String> options) {
    return DropdownButtonFormField<String>(
      value: currentValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        setState(() {
          currentValue = value;
        });
      },
      items: options.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildCourseDuration() {
    return Row(
      children: [
        Expanded(
          child: _buildTextField('Course Start', '2022'),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _buildTextField('Course End', '2025'),
        ),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: _dob != null
                  ? "${_dob!.day}/${_dob!.month}/${_dob!.year}"
                  : 'Date of Birth',
              border: OutlineInputBorder(),
            ),
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime(2000),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                setState(() {
                  _dob = picked;
                });
              }
            },
            readOnly: true,
          ),
        ),
      ],
    );
  }

  Widget _buildAddressFields(String addressType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$addressType'),
        _buildTextField('Address Line 1', 'Plot.79'),
        const SizedBox(height: 12),
        _buildTextField('Address Line 2', 'Asthik nagar limbayat Surat'),
        const SizedBox(height: 12),
        _buildTextField('Landmark', 'ner. sanjay nagar'),
        const SizedBox(height: 12),
        _buildTextField('Pincode', '394210'),
        const SizedBox(height: 12),
      ],
    );
  }
}
