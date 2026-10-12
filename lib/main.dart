import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() => runApp(SoforDriverApp());

class SoforDriverApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SOFOR Driver',
      theme: ThemeData(primaryColor: Color(0xFF00A651)),
      home: LanguageScreen(),
    );
  }
}

Widget soforLogo({double size = 1}) {
  return Column(
    children: [
      Text("سفر", style: TextStyle(fontSize: 42 * size, fontWeight: FontWeight.bold, color: Color(0xFF00A651))),
      Text("সফর", style: TextStyle(fontSize: 44 * size, fontWeight: FontWeight.bold, color: Color(0xFF00A651))),
      SizedBox(height: 8 * size),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.directions_bus, size: 36 * size, color: Color(0xFF00A651)),
          SizedBox(width: 12 * size),
          Icon(Icons.local_shipping, size: 36 * size, color: Color(0xFF00A651)),
          SizedBox(width: 12 * size),
          Icon(Icons.motorcycle, size: 36 * size, color: Color(0xFF00A651)),
        ],
      ),
      SizedBox(height: 6 * size),
      Text("SOFOR DRIVER", style: TextStyle(fontSize: 18 * size, fontWeight: FontWeight.w900, color: Color(0xFF00A651))),
    ],
  );
}

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              soforLogo(size: 1.2),
              SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00A651)),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PhoneScreen())),
                  child: Text("বাংলা - Continue", style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PhoneScreen())),
                  child: Text("English - Continue"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneScreen extends StatelessWidget {
  final c = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phone Number")),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            soforLogo(size: 0.7),
            SizedBox(height: 30),
            TextField(
              controller: c,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: "Phone Number", prefixText: "+880 ", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00A651)),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OtpScreen(phone: c.text))),
                child: Text("SEND OTP", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OtpScreen extends StatelessWidget {
  final String phone;
  OtpScreen({required this.phone});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verify OTP")),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Text("6 Digit OTP sent to +880 $phone"),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (i) => SizedBox(width: 42, child: TextField(textAlign: TextAlign.center, decoration: InputDecoration(border: OutlineInputBorder())))),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00A651)),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RegistrationScreen())),
                child: Text("VERIFY OTP", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? selectedCategory;
  final ImagePicker _picker = ImagePicker();
  File? driverPhoto;
  File? nidFront;
  File? nidBack;
  File? license;
  File? vehiclePhoto;

  Future<void> pickCamera(Function(File) onPicked) async {
    final XFile? img = await _picker.pickImage(source: ImageSource.camera, imageQuality: 70);
    if (img!= null) {
      setState(() {
        onPicked(File(img.path));
      });
    }
  }

  Widget upBox(String title, File? file, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 95,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border.all(color: file!= null? Color(0xFF00A651) : Colors.grey.shade300, width: file!= null? 2 : 1),
          borderRadius: BorderRadius.circular(12),
          image: file!= null? DecorationImage(image: FileImage(file), fit: BoxFit.cover) : null,
        ),
        child: file == null
           ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, color: Color(0xFF00A651), size: 28),
                    SizedBox(height: 4),
                    Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    Text("Tap for Camera", style: TextStyle(fontSize: 8, color: Colors.grey)),
                  ],
                ),
              )
            : Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.all(4),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                  child: Icon(Icons.check, color: Colors.white, size: 14),
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Driver Registration"), backgroundColor: Color(0xFF00A651), foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: soforLogo(size: 0.5)),
            SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: "Full Name", prefixIcon: Icon(Icons.person), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "NID Number", prefixIcon: Icon(Icons.badge), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: InputDecoration(labelText: "Vehicle Category", prefixIcon: Icon(Icons.category), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
              items: [
                DropdownMenuItem(value: "bike", child: Text("🏍️ Bike")),
                DropdownMenuItem(value: "car", child: Text("🚗 Car")),
                DropdownMenuItem(value: "cng", child: Text("🛺 CNG")),
                DropdownMenuItem(value: "bus", child: Text("🚌 Bus")),
                DropdownMenuItem(value: "truck", child: Text("🚚 Truck")),
              ],
              onChanged: (v) => setState(() => selectedCategory = v),
            ),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "Vehicle Number", prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            SizedBox(height: 20),
            Text("Upload - Tap to Open Camera", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            upBox("Driver Photo", driverPhoto, () => pickCamera((f) => driverPhoto = f)),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: upBox("NID Front", nidFront, () => pickCamera((f) => nidFront = f))),
                SizedBox(width: 10),
                Expanded(child: upBox("NID Back", nidBack, () => pickCamera((f) => nidBack = f))),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: upBox("License", license, () => pickCamera((f) => license = f))),
                SizedBox(width: 10),
                Expanded(child: upBox("Vehicle", vehiclePhoto, () => pickCamera((f) => vehiclePhoto = f))),
              ],
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00A651)),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PendingScreen())),
                child: Text("SUBMIT FOR VERIFICATION", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PendingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              soforLogo(),
              SizedBox(height: 20),
              Icon(Icons.hourglass_top, size: 60, color: Colors.orange),
              Text("Verification Pending", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text("Office theke verify korche", textAlign: TextAlign.center),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00A651)),
                  onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginScreen()), (r) => false),
                  child: Text("Go to Login", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              soforLogo(),
              SizedBox(height: 30),
              TextField(decoration: InputDecoration(labelText: "Phone", prefixText: "+880 ", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
              SizedBox(height: 12),
              TextField(obscureText: true, decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00A651)),
                  onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomeScreen()), (r) => false),
                  child: Text("LOGIN", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool online = true;
  bool trip = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00A651),
        foregroundColor: Colors.white,
        title: Text("سفر সফর SOFOR"),
        actions: [
          Text(online? "Online" : "Offline"),
          Switch(value: online, activeColor: Colors.white, onChanged: (v) => setState(() => online = v)),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Color(0xFFE8E3DF),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  soforLogo(size: 0.6),
                  SizedBox(height: 20),
                  Text("Map - Blue Dot Location"),
                ],
              ),
            ),
          ),
          if (trip && online)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                child: Column(
                  children: [
                    Text("New Trip Request", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00A651))),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        CircleAvatar(child: Icon(Icons.person)),
                        SizedBox(width: 10),
                        Text("Hridoy Ahmed", style: TextStyle(fontWeight: FontWeight.bold)),
                        Spacer(),
                        Text("৳ 180", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF00A651))),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: OutlinedButton(onPressed: () => setState(() => trip = false), child: Text("DECLINE"))),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00A651)),
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RideScreen())),
                            child: Text("ACCEPT", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class RideScreen extends StatefulWidget {
  @override
  _RideScreenState createState() => _RideScreenState();
}

class _RideScreenState extends State<RideScreen> {
  bool picked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(picked? "Drop e Jacchi" : "Passenger er kache"), backgroundColor: Color(0xFF00A651), foregroundColor: Colors.white),
      body: Stack(
        children: [
          Container(
            color: Color(0xFFD6EAF8),
            child: Center(child: Text(picked? "Drop Location e Navigation" : "Passenger Live Location", style: TextStyle(fontWeight: FontWeight.bold))),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00A651), foregroundColor: Colors.white),
                onPressed: () {
                  if (!picked) {
                    setState(() => picked = true);
                  } else {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => FinishScreen()));
                  }
                },
                child: Text(picked? "FINISH TRIP" : "PICKED UP"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FinishScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              soforLogo(),
              SizedBox(height: 20),
              Icon(Icons.check_circle, size: 90, color: Color(0xFF00A651)),
              Text("Trip Finished!", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              Text("Vara: ৳180 | Cash Collected"),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00A651)),
                  onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomeScreen()), (r) => false),
                  child: Text("BACK TO HOME", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}