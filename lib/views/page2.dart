import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran/models/jsonAsset.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  JsonAsset asset = JsonAsset();
  int pageNumber = 0;
  List<dynamic> ayahs = [];

  void getData() async {
    ayahs = await asset.fetchData();

    setState(() {});
  }

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
        body: SafeArea(
            child: PageView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            getData();
            pageNumber = index + 1;
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(12),
                child: Center(
                  child: Text.rich(
                    textAlign: TextAlign.justify,
                    TextSpan(
                      style: TextStyle(
                          fontSize: 25, textBaseline: TextBaseline.ideographic),
                      children: [
                        for (int i = 0; i < ayahs.length; i++) ...{
                          TextSpan(
                            style: TextStyle(
                              fontSize: 24.5,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Hafs',
                            ),
                            text: '${ayahs[i]} ',
                          ),
                          // WidgetSpan(
                          //   child: Container(
                          //     padding:
                          //         EdgeInsetsDirectional.only(start: 12, top: 5),
                          //     width: 35,
                          //     height: 35,
                          //     decoration: BoxDecoration(
                          //       image: DecorationImage(
                          //         image: AssetImage('assets/images/Ayah.png'),
                          //       ),
                          //     ),
                          //     child: Text(
                          //       '${ayahs[i]['aya_no']}',
                          //       style: TextStyle(
                          //         fontSize: 16,
                          //         color: Colors.black,
                          //         fontWeight: FontWeight.w600,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        }
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        )),
      ),
    );
  }
}
