import 'package:flutter/material.dart';
class EarningScreen extends StatelessWidget {
  const EarningScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Earning - Sofor")),
      body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
        Card(color: Color(0xFFB9E5C0), child: Padding(padding: EdgeInsets.all(16), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Daily Earnings"), Text("\$128.50", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))]), Icon(Icons.account_balance_wallet, size: 40)]))),
        SizedBox(height: 10),
        Card(child: ListTile(title: Text("Wallet Balance"), subtitle: Text("\$542.00", style: TextStyle(fontSize: 24)))),
        SizedBox(height: 10),
        SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00A86B)), onPressed: (){}, child: Text("Withdraw to Bank", style: TextStyle(color: Colors.white))))
      ])),
    );
  }
}