import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'driver_home.dart';

class DriverLoginScreen extends StatefulWidget {
  const DriverLoginScreen({super.key});
  @override
  State<DriverLoginScreen> createState() => _DriverLoginScreenState();
}

class _DriverLoginScreenState extends State<DriverLoginScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  String? selectedZila;

  final List<String> allZilas = [
    "Bagerhat", "Bandarban", "Barguna", "Barishal", "Bhola", "Bogura", "Brahmanbaria", "Chandpur",
    "Chattogram", "Chuadanga", "Cox's Bazar", "Cumilla", "Dhaka", "Dinajpur", "Faridpur", "Feni",
    "Gaibandha", "Gazipur", "Gopalganj", "Habiganj", "Jamalpur", "Jashore", "Jhalokati", "Jhenaidah",
    "Joypurhat", "Khagrachhari", "Khulna", "Kishoreganj", "Kurigram", "Kushtia", "Lakshmipur", "Lalmonirhat",
    "Madaripur", "Magura", "Manikganj", "Meherpur", "Moulvibazar", "Munshiganj", "Mymensingh", "Naogaon",
    "Narail", "Narayanganj", "Narsingdi", "Natore", "Netrokona", "Nilphamari", "Noakhali", "Pabna",
    "Panchagarh", "Patuakhali", "Pirojpur", "Rajbari", "Rajshahi", "Rangamati", "Rangpur", "Satkhira",
    "Shariatpur", "Sherpur", "Sirajganj", "Sunamganj", "Sylhet", "Tangail", "Thakurgaon"
  ];

  Future<void> openZilaPicker() async {
    List<String> filtered = List.from(allZilas);
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("Select Your District"),
              content: SizedBox(
                width: double.maxFinite,
                height: 400,
                child: Column(
                  children: [
                    TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "Search District... ex: Dhaka",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onChanged: (value) {
                        setDialogState(() {
                          filtered = allZilas.where((z) => z.toLowerCase().contains(value.toLowerCase())).toList();
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: filtered.isEmpty
                     ? const Center(child: Text("No District Found"))
                      : ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(filtered[index]),
                            onTap: () {
                              setState(() => selectedZila = filtered[index]);
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> login() async {
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Full Name Likhen")));
      return;
    }

    String raw = phoneController.text.trim().replaceAll(RegExp(r'[^0-9]'), '');
    if (raw.startsWith('0')) raw = raw.substring(1);

    if (raw.length!= 10) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Sothik 11 digit number den")));
      return;
    }
    if (selectedZila == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Select Your District")));
      return;
    }

    String fullNumber = "+880$raw";

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('driver_name', nameController.text.trim());
    await prefs.setString('driver_phone', fullNumber);
    await prefs.setString('driver_zila', selectedZila!);
    await prefs.setBool('is_logged_in', true);

    if (mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DriverHome()));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sofor Driver Login"), backgroundColor: Colors.green, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Full Name", border: OutlineInputBorder())
            ),
            const SizedBox(height: 15),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              maxLength: 11,
              decoration: const InputDecoration(
                labelText: "Phone Number",
                hintText: "1712345678",
                prefixText: "+880 ",
                prefixStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                border: OutlineInputBorder(),
                counterText: "",
              ),
              onChanged: (val){
                if(val.startsWith('0')){
                  phoneController.text = val.substring(1);
                  phoneController.selection = TextSelection.fromPosition(TextPosition(offset: phoneController.text.length));
                }
              },
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: openZilaPicker,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(selectedZila?? "Select Your District", style: TextStyle(color: selectedZila == null? Colors.grey[600] : Colors.black)),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: login,
                child: const Text("Login & Shuru Korun", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            )
          ],
        ),
      ),
    );
  }
}