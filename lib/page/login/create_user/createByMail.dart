import 'package:flutter/material.dart';
import '../../../api/signup_api.dart';
import '../log.dart';
import 'createbyphone.dart';

class SignUpScreen2 extends StatefulWidget {
  @override
  _SignUpScreen2State createState() => _SignUpScreen2State();
}

class _SignUpScreen2State extends State<SignUpScreen2> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Buff'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('สร้างบัญชีด้วยอีเมล', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              _buildTextField('ชื่อ', _nameController),
              _buildTextField('นามสกุล', _surnameController),
              _buildDatePicker('วันเกิด'),
              _buildEmailField('อีเมล'),
              _buildPasswordField('รหัสผ่าน'),
              _buildPasswordField('ยืนยันรหัสผ่าน', isConfirm: true),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('สร้างบัญชี', style: TextStyle(color: Color(0xFFFFFFFF))),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Color(0xFF2E742B),
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  // ใช้ Navigator.push() เพื่อเปิดหน้าจอ SignUpScreen2
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                child: Text(
                  'สมัครด้วยโทรศัพท์',
                  style: TextStyle(color: Color(0xFFFFFFFF)), // สีตัวอักษรเป็นขาว
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // ขนาดของปุ่ม
                  backgroundColor: Color(0xFF2E742B), // สีพื้นหลังของปุ่ม
                ),
              ),

              Spacer(),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: const Text('ฉันมีบัญชีแล้ว',style: TextStyle(color: Color(0xFF000000)),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to create a simple text field
  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label is required';
          }
          return null;
        },
      ),
    );
  }

  // Method to create date picker field
  Widget _buildDatePicker(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _dobController,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        readOnly: true,
        onTap: _selectDate,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label is required';
          }
          return null;
        },
      ),
    );
  }

  // Method to create email field
  Widget _buildEmailField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'กรุณากรอกอีเมล';
          }
          if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
            return 'กรุณากรอกอีเมลที่ถูกต้อง';
          }
          return null;
        },
      ),
    );
  }

  // Method to create password field
  Widget _buildPasswordField(String label, {bool isConfirm = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: isConfirm ? _confirmPasswordController : _passwordController,
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: _togglePasswordVisibility,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label is required';
          }
          if (isConfirm && value != _passwordController.text) {
            return 'รหัสผ่านไม่ตรงกัน';
          }
          return null;
        },
      ),
    );
  }

  // Toggle password visibility
  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  // Date picker for selecting date of birth
  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _dobController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  // Submit form and send data
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final data = {
        'name': _nameController.text,
        'surname': _surnameController.text,
        'dob': _dobController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      };
      submitSignUp(data);  // ส่งข้อมูลไปยัง API
    }
  }
}
