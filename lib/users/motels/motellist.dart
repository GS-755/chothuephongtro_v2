import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MotelList extends StatefulWidget {
  const MotelList({super.key});

  @override
  State<MotelList> createState() => _MotelListState();
}

class _MotelListState extends State<MotelList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 5
        ),
        child: GNav(
          haptic: true, // haptic feedback
          tabBorderRadius: 15,
          tabActiveBorder: Border.all(color: Colors.black, width: 0.5),
          duration: const Duration(milliseconds: 400),
          gap: 8,
          padding: const EdgeInsets.all(10),
          tabs: const [
            GButton(icon: Icons.home,text: 'Home',textColor: Colors.black,),
            GButton(icon: Icons.favorite_border,text: 'Like',textColor: Colors.black),
            GButton(icon: Icons.search, text: 'Search',textColor: Colors.black),
            GButton(icon: Icons.settings, text: 'Setting',textColor: Colors.black),
          ],),
      ),
      body: Column(children: [
        Container(
          decoration: BoxDecoration(color: Colors.white70,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0)
              ]),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child:Column(
              children: [
                // nut back va text tat ca phong tro
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                        onTap: () {},
                        child: const Icon(Icons.arrow_back, color: Colors.black,),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Tất cả phòng trọ",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.black
                        ),
                      ),
                    ),
                  ],
                ),
                // thanh tim kiem nut tim kiem
                Row(
                  children: [
                    // box cua search
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30, top: 8, bottom: 8),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(Radius.circular(39.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      offset: const Offset(0, 2),
                                      blurRadius: 8.0)
                                ]),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, top: 8, bottom: 8),
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    border: InputBorder.none, hintText: "Tìm phòng trọ"),
                              ),
                            ),
                          ),
                        )),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(39.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                offset: const Offset(0, 2),
                                blurRadius: 8.0)
                          ]),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                          onTap: () {},
                          child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.search,
                                size: 20,
                                color: Colors.black,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],),
    );
  }
}

