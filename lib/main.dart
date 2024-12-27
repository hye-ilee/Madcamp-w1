import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool hasPermission = await FlutterContacts.requestPermission();
  runApp(MyApp(permissionGranted: hasPermission));
}

class MyApp extends StatelessWidget {
  final bool permissionGranted;

  const MyApp({Key? key, required this.permissionGranted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: permissionGranted ? ContactPickerPage() : PermissionDeniedPage(),
    );
  }
}

class ContactPickerPage extends StatefulWidget {
  @override
  _ContactPickerPageState createState() => _ContactPickerPageState();
}

class _ContactPickerPageState extends State<ContactPickerPage> {
  List<Contact> _contacts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final contacts = await FlutterContacts.getContacts(
                  withProperties: true,
                );
                setState(() {
                  _contacts = contacts;
                });
              },
              child: const Text('Pick Contacts'),
            ),
            const SizedBox(height: 20),
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
        ),
      ),
    );
  }
}

class PermissionDeniedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permission Denied'),
      ),
      body: Center(
        child: Text(
          'Contacts permission is required to use this app.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
