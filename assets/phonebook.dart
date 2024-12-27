import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:madcamp_w1/tab_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (await FlutterContacts.requestPermission()) {
    runApp(const MyApp());
  } else {
    print("Permission denied.");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactPickerPage(),
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
      body: Stack(
        children: [
          Column(
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
          Positioned(
            bottom: 1,
            left: 0,
            right: 0,
            child: Center(
              child: TapBar(),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ContactPickerPage(),
//     );
//   }
// }
//
// class ContactPickerPage extends StatefulWidget {
//   @override
//   _ContactPickerPageState createState() => _ContactPickerPageState();
// }
//
// class _ContactPickerPageState extends State<ContactPickerPage> {
//   final FlutterContactPicker _contactPicker = FlutterContactPicker();
//   Contact? _contact;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Contact Picker'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () async {
//                 try {
//                   final contact = await _contactPicker.selectContact();
//                   setState(() {
//                     _contact = contact;
//                   });
//                 } catch (e) {
//                   print("Error picking contact: $e");
//                 }
//               },
//               child: const Text('Pick a Contact'),
//             ),
//             const SizedBox(height: 20),
//             _contact != null
//                 ? Text(
//               'Name: ${_contact!.fullName}\nPhone: ${_contact!.phoneNumber}',
//               textAlign: TextAlign.center,
//             )
//                 : const Text('No contact selected.'),
//           ],
//         ),
//       ),
//     );
//   }
// }
