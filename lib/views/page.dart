import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran/models/network.dart';

class PageV extends StatefulWidget {
  const PageV({super.key});

  @override
  State<PageV> createState() => _PageVState();
}

class _PageVState extends State<PageV> {
  List<dynamic> ayahs = [];
  Network network = Network();
  int pageNumber = 1;
  void getData() async {
    Map<String, dynamic> pageData = await network.fetchData(pageNumber);
    setState(() {
      ayahs = pageData['data']['ayahs'];
    });
    print(ayahs);
  }

  // Future<void> readJson(int i) async {
  //   final String response =
  //       await rootBundle.loadString('assets/hafs_smart_v8.json');
  //   List<dynamic> jsonData = jsonDecode(response);
  //   setState(() {
  //     ayahs.addAll(jsonData);
  //   });
  // }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(child: PageView.builder(
          itemBuilder: (context, index) {
            getData();
            pageNumber = index + 1;
            return Center(
              child: Text.rich(
                TextSpan(
                  style: TextStyle(fontSize: 25),
                  children: [
                    for (int i = 0; i < ayahs.length; i++) ...{
                      TextSpan(
                        text: '${ayahs[i]['text']} ',
                      ),
                      WidgetSpan(
                        child: Container(
                          padding:
                              EdgeInsetsDirectional.only(start: 18, top: 12),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/Ayah.png'),
                            ),
                          ),
                          child: Text(
                            '${ayahs[i]['numberInSurah']}',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    }
                  ],
                ),
              ),
            );
          },
        )),
      ),
    );
  }
}
