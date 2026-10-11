import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

void main() => runApp(SoforDriverApp());

class SoforDriverApp extends StatelessWidget {
  const SoforDriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'HindSiliguri'),
      home: SoforDriverHome(),
    );
  }
}

class SoforDriverHome extends StatefulWidget {
  const SoforDriverHome({super.key});

  @override
  State<SoforDriverHome> createState() => _SoforDriverHomeState();
}

class _SoforDriverHomeState extends State<SoforDriverHome> with SingleTickerProviderStateMixin {
  bool isOnline = false;
  late TabController _tabController;
  late stt.SpeechToText _speech;
  late FlutterTts _tts;
  bool isListening = false;
  String voiceText = "বলুন - 'অনলাইন হও', 'ট্রিপ নাও', 'অফলাইন হও'";

  // Dummy Data
  List<Map> advanceBookings = [
    {"time": "Kaal Sokal 9 AM", "from": "Shah Alam, Section 15", "to": "KLIA", "price": "RM 85"},
    {"time": "11 Oct, 6 PM", "from": "i-City", "to": "Sunway Pyramid", "price": "RM 25"},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _speech = stt.SpeechToText();
    _tts = FlutterTts();
    _tts.setLanguage("bn-BD");
    _tts.setSpeechRate(0.5);
  }

  void _listen() async {
    if (!isListening) {
      bool avail = await _speech.initialize();
      if (avail) {
        setState(() => isListening = true);
        _speech.listen(localeId: "bn_BD", onResult: (v) {
          setState(() => voiceText = v.recognizedWords);
          _handleVoice(v.recognizedWords.toLowerCase());
        });
      }
    } else {
      setState(() => isListening = false);
      _speech.stop();
    }
  }

  void _handleVoice(String text) {
    if (text.contains("online") || text.contains("অনলাইন") || text.contains("চালু")) {
      setState(() => isOnline = true);
      _speak("আপনি অনলাইন হয়ে গেছেন, ট্রিপের জন্য প্রস্তুত");
    } else if (text.contains("offline") || text.contains("অফলাইন") || text.contains("বন্ধ")) {
      setState(() => isOnline = false);
      _speak("আপনি অফলাইন");
    } else if (text.contains("trip") || text.contains("নাও") || text.contains("accept") || text.contains("একসেপ্ট")) {
      _speak("ট্রিপ একসেপ্ট করা হলো");
      _showTripAccept();
    } else if (text.contains("বাদ") || text.contains("cancel") || text.contains("বাতিল")) {
      _speak("ট্রিপ বাতিল করা হলো");
    }
  }

  Future _speak(String t) async => await _tts.speak(t);

  void _showTripAccept() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("✅ Trip Accepted! Jatri er kache jachen..."), backgroundColor: Colors.green));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(children: [
          Icon(Icons.directions_car, color: Colors.green.shade800),
          SizedBox(width: 8),
          Text("SOFOR DRIVER", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ]),
        actions: [
          IconButton(icon: Icon(Icons.notifications, color: Colors.black), onPressed: () {}),
        ],
        bottom: TabBar(controller: _tabController, labelColor: Colors.green.shade800, unselectedLabelColor: Colors.grey, indicatorColor: Colors.green, tabs: [
          Tab(text: "Instant Trip"),
          Tab(text: "Advance Booking"),
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // TAB 1 - INSTANT TRIP (Pathao Style)
          Stack(
            children: [
              Container(color: Colors.grey.shade200, child: Center(child: Icon(Icons.map, size: 100, color: Colors.grey.shade400))),
              Positioned(
                top: 20, left: 20, right: 20,
                child: Card(
                  child: SwitchListTile(
                    title: Text(isOnline? "আপনি ONLINE আছেন" : "আপনি OFFLINE", style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(isOnline? "Trip er jonno prostut" : "Online hoye income shuru korun"),
                    value: isOnline,
                    activeColor: Colors.green,
                    onChanged: (v) => setState(() => isOnline = v),
                  ),
                ),
              ),
              if (isOnline)
                Positioned(
                  bottom: 100, left: 15, right: 15,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(children: [CircleAvatar(child: Text("R")), SizedBox(width: 10), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Rahim - Jatri", style: TextStyle(fontWeight: FontWeight.bold)), Text("2.5 km dure")])]),
                          Divider(),
                          Row(children: [Icon(Icons.my_location, size: 16, color: Colors.green), SizedBox(width: 5), Text("Shah Alam Seksyen 7")]),
                          Row(children: [Icon(Icons.location_on, size: 16, color: Colors.red), SizedBox(width: 5), Text("KL Sentral")]),
                          SizedBox(height: 10),
                          Row(children: [
                            Expanded(child: OutlinedButton(onPressed: () => _speak("Trip batil"), child: Text("বাদ দিন"))),
                            SizedBox(width: 10),
                            Expanded(child: ElevatedButton(onPressed: _showTripAccept, style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: Text("গ্রহণ করুন (ACCEPT)"))),
                          ])
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          // TAB 2 - ADVANCE BOOKING
          ListView.builder(
            padding: EdgeInsets.all(12),
            itemCount: advanceBookings.length,
            itemBuilder: (ctx, i) {
              var b = advanceBookings[i];
              return Card(
                child: ListTile(
                  leading: Icon(Icons.calendar_month, color: Colors.green),
                  title: Text("${b['time']} - ${b['price']}", style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("${b['from']} -> ${b['to']}"),
                  trailing: ElevatedButton(onPressed: () {}, child: Text("Nibo")),
                ),
              );
            },
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: isListening? Colors.red : Colors.green.shade700,
        onPressed: _listen,
        icon: Icon(isListening? Icons.mic_off : Icons.mic),
        label: Text(isListening? "শুনছি..." : "বাংলায় বলুন"),
      ),
      bottomSheet: Container(
        color: Colors.black87,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(children: [
          Icon(Icons.mic, color: Colors.white, size: 16),
          SizedBox(width: 8),
          Expanded(child: Text(voiceText, style: TextStyle(color: Colors.white70, fontSize: 12))),
        ]),
      ),
    );
  }
}