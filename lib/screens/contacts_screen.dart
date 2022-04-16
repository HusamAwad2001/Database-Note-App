import 'package:database/controller/contact_db_controller.dart';
import 'package:database/models/contact.dart';
import 'package:database/utils/helpers.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  late Future<List<Contact>> _futureContacts;
  List<Contact> _contacts = <Contact>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureContacts = ContactDbController().read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('APP TEXT'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/create_contacts');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Contact>>(
        future: _futureContacts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            ///انتظار وصول البيانات
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            );
          } else if (snapshot.hasError) {
            ///في حال حصلت مشكلة
            return Center(
              child: Column(
                children: const [
                  Icon(
                    Icons.warning,
                    size: 50,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Loading error!'),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            ///حالة النجاح
            if(_contacts.isEmpty) _contacts = snapshot.data ?? [];
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                Contact contact = _contacts.elementAt(index);
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue.shade200, width: 1.5),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 0),
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6)
                    ],
                  ),
                  child: ListTile(
                    onTap: () {},
                    onLongPress: () {},
                    leading: const Icon(Icons.contact_phone),
                    title: Text(contact.name),
                    subtitle: Text(contact.mobile),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () async{
                        await deleteContact(index);
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Column(
                children: const [
                  Icon(Icons.warning, size: 50),
                  SizedBox(height: 15),
                  Text('No Contacts'),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future deleteContact(int index) async {
    bool deleted = await ContactDbController().delete(_contacts.elementAt(index).id);
    Helpers.showSnackBar(
      context,
      deleted ? 'Contact deleted successfully' : 'Failed to delete contact',
      error: !deleted,
    );
    setState(() {
      _contacts.removeAt(index);
    });
  }
}
