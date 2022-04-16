import 'package:database/controller/contact_db_controller.dart';
import 'package:database/models/contact.dart';
import 'package:database/utils/helpers.dart';
import 'package:flutter/material.dart';

class CreateContactScreen extends StatefulWidget {
  @override
  _CreateContactScreenState createState() => _CreateContactScreenState();
}

class _CreateContactScreenState extends State<CreateContactScreen> {
  late TextEditingController _nameTextController;
  late TextEditingController _mobileTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTextController = TextEditingController();
    _mobileTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameTextController.dispose();
    _mobileTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create Contact...',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Enter name and mobile nnumber',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _nameTextController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Contact Name',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _mobileTextController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Contact Name',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('Save'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
              ),
              onPressed: () async {
                await performData();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future performData() async {
    if (checkData()) save();
  }

  bool checkData() {
    if (_nameTextController.text.isNotEmpty &&
        _mobileTextController.text.isNotEmpty) {
      return true;
    }
    Helpers.showSnackBar(
      context,
      'Enter required data',
      error: true,
    );
    return false;
  }

  Future save() async {
    bool saved = await ContactDbController().create(contact);
    if (saved) {
      Helpers.showSnackBar(
        context,
        saved ? 'Saved Successfully' : 'Failed to save',
        error: !saved,
      );
      if(saved) clear();
    }
  }

  Contact get contact {
    return Contact(
        name: _nameTextController.text, mobile: _mobileTextController.text);
  }

  void clear(){
    _nameTextController.text = '';
    _mobileTextController.text = '';
  }
}
