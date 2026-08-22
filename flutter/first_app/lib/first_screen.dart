import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu, color: Colors.deepOrange),
        ),
        centerTitle: true,
        title: Text(
          'My First App',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.deepOrange,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.deepOrange),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings, color: Colors.deepOrange),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: .center,
        children: [
          ClipOval(
            child: Image.asset(
              'assets/icons/icon.png',
              width: 160,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          // CircleAvatar(
          //   radius: 80,
          //   backgroundImage: NetworkImage(
          //     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSrBlqCPCCKmaKD4GqwvMqKnlcr0-PfTK4Sf4-0XP3zw&s=10',
          //   ),
          // ),
          SizedBox(height: 24),
          Text(
            'Ahmed Ali Ahmed',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontSize: 30,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Flutter Developer',
            style: TextStyle(color: Colors.deepOrange, fontSize: 18),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: .center,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.facebook_rounded, color: Colors.blue),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.camera_alt_rounded, color: Colors.redAccent),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.snapchat_rounded, color: Colors.amber),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.telegram_rounded, color: Colors.blue),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              minimumSize: Size(200, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {},
            child: Row(
              mainAxisSize: .min,
              children: [
                Icon(Icons.download_rounded, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  'Download CV',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
