import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String _lang = 'en';
  String get lang => _lang;

  LanguageProvider() {
    loadLang();
  }

  Future<void> loadLang() async {
    final prefs = await SharedPreferences.getInstance();
    _lang = prefs.getString('lang') ?? 'en';
    notifyListeners();
  }

  Future<void> setLang(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', code);
    _lang = code;
    notifyListeners();
  }

  String t(String key) {
    if (_lang == 'bn') {
      return bn[key] ?? key;
    } else {
      return en[key] ?? key;
    }
  }

  // ENGLISH - Full App
  Map<String, String> en = {
    'welcome': 'Welcome to Sofor Rider.',
    'subtitle': 'Delivery • Arrived on Time',
    'bangla': 'বাংলা',
    'bengali_small': 'Bengali',
    'english': 'English',
    'english_small': 'English',
    'continue': 'Continue',
    'change_later': 'You can change this later in settings',
    
    // Home / Dashboard
    'home': 'Home',
    'orders': 'Orders',
    'my_orders': 'My Orders',
    'wallet': 'Wallet',
    'profile': 'Profile',
    'earnings': 'Earnings',
    'today_earnings': 'Today Earnings',
    'total_delivered': 'Total Delivered',
    'online': 'Online',
    'offline': 'Offline',
    'go_online': 'Go Online',
    'new_order': 'New Order Request',
    'accept': 'Accept',
    'reject': 'Reject',
    'pickup': 'Pickup',
    'delivered': 'Delivered',
    'customer': 'Customer',
    'delivery_address': 'Delivery Address',
    'call': 'Call',
    'navigate': 'Navigate',
    'settings': 'Settings',
    'logout': 'Logout',
    'language': 'Language',
    
    // DriverHomePage New Keys - ADD KORA HOYECHE
    'you_online': 'You are Online',
    'you_offline': 'You are Offline',
    'finding_passengers': 'Finding passengers...',
    'go_online_to_earn': 'Go online to earn',
    'today_earn': "Today's Earn",
    'trips': 'Trips',
    'rating': 'Rating',
    'waiting_request': 'Waiting for request...',
    'go_online_btn': 'Go Online',
  };

  // BANGLA - Full App
  Map<String, String> bn = {
    'welcome': 'Sofor Rider-এ স্বাগতম।',
    'subtitle': 'ডেলিভারি • সময়মতো পৌঁছে যায়',
    'bangla': 'বাংলা',
    'bengali_small': 'Bengali',
    'english': 'English',
    'english_small': 'English',
    'continue': 'চালিয়ে যান',
    'change_later': 'আপনি এটি পরে সেটিংসে পরিবর্তন করতে পারবেন',

    // Home / Dashboard
    'home': 'হোম',
    'orders': 'অর্ডার সমূহ',
    'my_orders': 'আমার অর্ডার',
    'wallet': 'ওয়ালেট',
    'profile': 'প্রোফাইল',
    'earnings': 'আয়',
    'today_earnings': 'আজকের আয়',
    'total_delivered': 'মোট ডেলিভারি',
    'online': 'অনলাইন',
    'offline': 'অফলাইন',
    'go_online': 'অনলাইন হোন',
    'new_order': 'নতুন অর্ডার এসেছে',
    'accept': 'গ্রহণ করুন',
    'reject': 'বাতিল করুন',
    'pickup': 'পিকআপ',
    'delivered': 'ডেলিভারি সম্পন্ন',
    'customer': 'কাস্টমার',
    'delivery_address': 'ডেলিভারি ঠিকানা',
    'call': 'কল করুন',
    'navigate': 'রাস্তা দেখুন',
    'settings': 'সেটিংস',
    'logout': 'লগ আউট',
    'language': 'ভাষা',

    // DriverHomePage New Keys - ADD KORA HOYECHE
    'you_online': 'আপনি অনলাইন আছেন',
    'you_offline': 'আপনি অফলাইন আছেন',
    'finding_passengers': 'যাত্রী খোঁজা হচ্ছে...',
    'go_online_to_earn': 'আয় করতে অনলাইন হোন',
    'today_earn': 'আজকের আয়',
    'trips': 'ট্রিপ',
    'rating': 'রেটিং',
    'waiting_request': 'রিকোয়েস্টের জন্য অপেক্ষা...',
    'go_online_btn': 'অনলাইন হোন',
  };
}