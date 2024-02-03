import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'app_user.dart';
import 'users_provider.dart';

class PrescriptionPatientPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<AppUser>> users = ref.watch(usersProvider);

    return Scaffold(
      // ignore: prefer_const_constructors
      appBar: AppBar(title: Text("Upload Prescription")),
      body: users.when(
        data: (users) => UploadForm(users: users),
        loading: () => CircularProgressIndicator(),
        error: (e, _) => Text('Error: $e'),
      ),
    );
  }
}

class UploadForm extends StatefulWidget {
  final List<AppUser> users;
  UploadForm({required this.users});

  @override
  _UploadFormState createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  AppUser? selectedUser;
  File? file;
  final picker = ImagePicker();

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'pdf']);
    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
      });
    }
  }

  Future<void> uploadFile() async {
    if (selectedUser == null || file == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select a user and a file.')));
      return;
    }
    String fileName = file!.path.split('/').last;
    try {
      await FirebaseStorage.instance
          .ref('prescriptions/${selectedUser!.id}/$fileName')
          .putFile(file!);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Prescription uploaded successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error uploading prescription: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<AppUser>(
          hint: Text("Select User"),
          value: selectedUser,
          onChanged: (value) => setState(() => selectedUser = value),
          items: widget.users.map<DropdownMenuItem<AppUser>>((AppUser user) {
            return DropdownMenuItem<AppUser>(
              value: user,
              child: Text(user.name),
            );
          }).toList(),
        ),
        ElevatedButton(onPressed: pickFile, child: Text("Pick File")),
        ElevatedButton(onPressed: uploadFile, child: Text("Upload")),
        if (file != null) Text("Selected File: ${file!.path.split('/').last}"),
      ],
    );
  }
}
