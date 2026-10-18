import 'package:flutter/material.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Profile - Sofor")), body: ListView(children: [ListTile(leading: CircleAvatar(child: Text("S")), title: Text("Sofor Driver"), subtitle: Text("Rating 4.9 - 1200 trips")), Divider(), ListTile(leading: Icon(Icons.help), title: Text("Help Center")), ListTile(leading: Icon(Icons.logout), title: Text("Logout"))]));
  }
}