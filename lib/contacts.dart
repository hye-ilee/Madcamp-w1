import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactPickerPage extends StatefulWidget {
  const ContactPickerPage({Key? key}) : super(key: key);

  @override
  _ContactPickerPageState createState() => _ContactPickerPageState();
}

class _ContactPickerPageState extends State<ContactPickerPage> {
  List<Contact> _contacts = [];
  bool _permissionChecked = false;
  bool _permissionGranted = false;

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    final hasPermission = await FlutterContacts.requestPermission();
    setState(() {
      _permissionChecked = true;
      _permissionGranted = hasPermission;
    });

    if (hasPermission) {
      _fetchContacts();
    }
  }

  Future<void> _fetchContacts() async {
    final contacts = await FlutterContacts.getContacts(withProperties: true);
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_permissionChecked) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!_permissionGranted) {
      return const Center(
        child: Text(
          'Contacts permission is required to use this feature.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _contacts.length,
            itemBuilder: (context, index) {
              final contact = _contacts[index];
              return ListTile(
                title: Text(contact.displayName ?? 'No Name'),
                subtitle: Text(contact.phones.isNotEmpty
                    ? contact.phones.first.number
                    : 'No Number'),
              );
            },
          ),
        ),
      ],
    );
  }
}
