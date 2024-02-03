import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PrescriptionUploadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Prescription")),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('users').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List<DropdownMenuItem<String>> dropdownItems = snapshot.data!.docs
                .map((doc) => DropdownMenuItem<String>(
                      value: doc.id, // Assuming doc.id is the identifier for the user
                      child: Text(doc['username'] as String),
                    ))
                .toList();

            return UploadForm(dropdownItems: dropdownItems);
          }

          return Center(child: Text('No users found'));
        },
      ),
    );
  }
}

class UploadForm extends StatefulWidget {
  final List<DropdownMenuItem<String>> dropdownItems;

  UploadForm({required this.dropdownItems});

  @override
  _UploadFormState createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  String? selectedUserId;
  File? file;
  final picker = ImagePicker();

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        file = File(result.files.single.path!);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No file selected or operation was canceled.')),
      );
    }
  }

  Future<void> uploadFile() async {
    if (selectedUserId == null || file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a user and a file.')),
      );
      return;
    }
    String fileName = file!.path.split('/').last;
    try {
      await FirebaseStorage.instance
          .ref('prescriptions/$selectedUserId/$fileName')
          .putFile(file!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Prescription uploaded successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading prescription: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<String>(
          hint: Text("Select User"),
          value: selectedUserId,
          onChanged: (String? newValue) {
            setState(() {
              selectedUserId = newValue;
            });
          },
          items: widget.dropdownItems,
        ),
        ElevatedButton(
          onPressed: pickFile,
          child: Text("Pick File"),
        ),
        ElevatedButton(
          onPressed: uploadFile,
          child: Text("Upload"),
        ),
        if (file != null)
          Text("Selected File: ${file!.path.split('/').last}"),
      ],
    );
  }
}
