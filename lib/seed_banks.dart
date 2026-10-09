
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String status = 'جاري إضافة البيانات...';

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final db = FirebaseFirestore.instance;
    final banks = [
      {
        'name': 'بنك دم شبرا العام',
        'nameEn': 'Shubra General Blood Bank',
        'address': '76 شارع المستشفى، داخل مستشفى شبرا العام - كتشنر',
        'phone': '22352325',
        'governorate': 'cairo',
        'city': 'Cairo',
      },
      {
        'name': 'بنك دم المنيرة',
        'nameEn': 'El Mounira Blood Bank',
        'address': '2 شارع نوبار، السيدة زينب، داخل مستشفى المنيرة العام',
        'phone': '23910230',
        'governorate': 'cairo',
        'city': 'Cairo',
      },
      {
        'name': 'بنك دم منشية البكري',
        'nameEn': 'Manshiet El Bakry Blood Bank',
        'address': 'شارع جسر السويس، داخل مستشفى منشية البكري العام',
        'phone': '22580946',
        'governorate': 'cairo',
        'city': 'Cairo',
      },
      {
        'name': 'بنك دم الخازندارة',
        'nameEn': 'El Khazandara Blood Bank',
        'address': '3 شارع شيبان، شبرا',
        'phone': '22057593',
        'governorate': 'cairo',
        'city': 'Cairo',
      },
    ];

    int added = 0;
    int skipped = 0;

    for (final bank in banks) {
      final existing = await db
          .collection('blood_banks')
          .where('nameEn', isEqualTo: bank['nameEn'])
          .limit(1)
          .get();

      if (existing.docs.isNotEmpty) {
        skipped++;
        continue;
      }

      await db.collection('blood_banks').add({
        ...bank,
        'addressEn': '',
        'inventory': {
          'A+': 0,
          'A-': 0,
          'B+': 0,
          'B-': 0,
          'AB+': 0,
          'AB-': 0,
          'O+': 0,
          'O-': 0,
        },
        'isVerified': false,
        'updatedAt': DateTime.now().toIso8601String(),
      });

      added++;
    }

    status = 'انتهت العملية!\n'
        'تمت إضافة: $added\n'
        'موجودة بالفعل: $skipped';

    debugPrint(status);
  } catch (e, stackTrace) {
    status = 'حدث خطأ: $e';
    debugPrint(status);
    debugPrintStack(stackTrace: stackTrace);
  }

  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(status, textAlign: TextAlign.center),
        ),
      ),
    ),
  ));
}