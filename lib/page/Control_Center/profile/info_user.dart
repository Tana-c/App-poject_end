import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class InfoUserPage extends StatefulWidget {
  @override
  _InfoUserPageState createState() => _InfoUserPageState();
}

class _InfoUserPageState extends State<InfoUserPage> {
  final TextEditingController _nameController = TextEditingController(text: 'คุณ โชคดี มีชัย');
  final TextEditingController _statusController = TextEditingController(text: 'อยากตั้งอะไรก็ได้');
  final TextEditingController _phoneController = TextEditingController(text: '+66');
  final TextEditingController _dobController = TextEditingController(text: '01 มกราคม');
  File? _profileImage;

  final ImagePicker _picker = ImagePicker();

  // Function to pick an image
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อมูลส่วนตัว'),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Editable Profile Picture
            GestureDetector(
              onTap: _pickImage, // Open image picker
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : const AssetImage('assets/profile_picture.jpg') as ImageProvider,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Editable Name
            ListTile(
              title: const Text('ชื่อ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: TextField(
                controller: _nameController,
                decoration: const InputDecoration(hintText: 'Enter name'),
              ),
              trailing: const Icon(Icons.edit),
            ),

            // Editable Status
            ListTile(
              title: const Text('สถานะ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: TextField(
                controller: _statusController,
                decoration: const InputDecoration(hintText: 'Enter status'),
              ),
              trailing: const Icon(Icons.edit),
            ),

            // Editable Phone Number
            ListTile(
              title: const Text('หมายเลขโทรศัพท์', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: TextField(
                controller: _phoneController,
                decoration: const InputDecoration(hintText: 'Enter phone number'),
              ),
              trailing: const Icon(Icons.edit),
            ),

            // Editable Birthdate
            ListTile(
              title: const Text('วันเกิด', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: TextField(
                controller: _dobController,
                decoration: const InputDecoration(hintText: 'Enter birthdate'),
              ),
              trailing: const Icon(Icons.edit),
            ),

            // Save Button
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  // Handle save action
                  // You can save the updated values here
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Changes Saved'),
                      content: const Text('Your changes have been saved successfully.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('บันทึกข้อมูล'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
