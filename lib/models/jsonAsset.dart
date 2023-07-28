import 'dart:convert';
import 'package:flutter/services.dart';

class JsonAsset {
  Future<List<dynamic>> fetchData() async {
    List<List<String>> pages = [];
    List<String> pageAyah = [];
    String result = await rootBundle.loadString('assets/hafs_smart_v8.json');
    for (int i = 0; i <= 603; i++) {
      if (result.isNotEmpty) {
        Map<> ayahs = jsonDecode(result);
        // List<String> pageAyah =
        //     ayahs.where((element) => element['page'] == i).toList();
        for (final element in ayahs) {
          if (element['page'] == i) {
            pageAyah.add(element);
          }
        }
        pages.add(pageAyah);
        return pages;
      }
    }

    return Future.error('error');
  }
}
