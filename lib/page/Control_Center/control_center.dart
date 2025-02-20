import 'package:flutter/material.dart';
import 'package:t0a12/page/Control_Center/History/history.dart';
import 'package:t0a12/page/Control_Center/Home/home.dart';
import 'package:t0a12/page/Control_Center/Notifications/notifications.dart';
import 'package:t0a12/page/Control_Center/profile/info_user.dart'; // ไปที่หน้าข้อมูลผู้ใช้
import 'package:t0a12/page/login/log.dart'; // หน้า login เมื่อ logout

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Track the current index of the selected tab
  final List<Widget> _pages = [
    Home_page(), // Home Screen
    History_page(), // History Screen
    Notifications_page(), // Notifications Screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0), // เพิ่มระยะห่างจากขอบซ้าย
          child: IconButton(
            icon: CircleAvatar(
              backgroundImage: NetworkImage('https://your-image-url.com'), // URL รูปภาพโปรไฟล์
            ),
            onPressed: () {
              // ไปที่หน้าข้อมูลผู้ใช้
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InfoUserPage()), // ไปหน้าข้อมูลผู้ใช้
              );
            },
          ),
        ),
        title: const Text('SmartBuff'),
        actions: [
          // ปุ่ม logout
          IconButton(
            icon: Icon(Icons.exit_to_app), // เปลี่ยนจาก Icons.output เป็น Icons.exit_to_app
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()), // ไปหน้าล็อกอินเมื่อออกจากระบบ
              );
            },
          ),
        ],
      ),
      body: _pages[_currentIndex], // Display the current page based on selected index
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        currentIndex: _currentIndex, // Highlight selected tab
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'ประวัติ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'การแจ้งเตือน',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the selected index and display the corresponding page
          });
        },
      ),
    );
  }
}
