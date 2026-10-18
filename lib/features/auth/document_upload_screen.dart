import 'package:flutter/material.dart';

class DocumentUploadScreen extends StatelessWidget {
  const DocumentUploadScreen({super.key});

  Widget _docCard(String title, String subtitle, IconData icon) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: Color(0xFF00A86B).withOpacity(0.1), child: Icon(icon, color: Color(0xFF00A86B))),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00A86B)),
          onPressed: (){},
          child: Text("Upload", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Documents - Sofor"), backgroundColor: Colors.white, foregroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Driver Verification", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text("Bangladesh e cholte ei document lagbe", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),
            _docCard("NID Front Side", "Jatiyo Porichoy Potro samne", Icons.badge),
            _docCard("NID Back Side", "Jatiyo Porichoy Potro pichone", Icons.badge_outlined),
            _docCard("Driving License", "BRTA License er photo", Icons.card_membership),
            _docCard("Selfie Photo", "Apnar mukher photo", Icons.person),
            _docCard("Vehicle Photo", "Bike/Car er number plate soho", Icons.directions_car),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00A86B), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> PendingScreen()));
                },
                child: Text("Submit Documents - জমা দিন", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PendingScreen extends StatelessWidget {
  const PendingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.hourglass_top, size: 70, color: Color(0xFF00A86B)), SizedBox(height: 15), Text("Document Check Hocche", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), Text("24 ghontar moddhe approve hobe", style: TextStyle(color: Colors.grey)), SizedBox(height: 20), ElevatedButton(onPressed: (){}, child: Text("Home e jan"))])));
  }
}