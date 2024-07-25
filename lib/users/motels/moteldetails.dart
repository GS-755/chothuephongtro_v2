import 'dart:convert';
import 'dart:ui';
import 'package:chothuephongtro_v2/users/booking/confirmbooking.dart';
import 'package:chothuephongtro_v2/utils/uribuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../models/motels/phongtro.dart';
import 'package:http/http.dart' as http;

class MotelDetails extends StatefulWidget {
  final int maPT;

  const MotelDetails({super.key, required this.maPT});

  @override
  State<MotelDetails> createState() => _MotelDetailsState(maPT: this.maPT);
}

class _MotelDetailsState extends State<MotelDetails> {
  final int maPT;

  _MotelDetailsState({required this.maPT});

  Future<PhongTro?> fetchMotelDetails(int maPT) async {
    try {
      final response = await http.get(
          UriAccess.buildApiUri('/motels?id=${maPT}'));
      if (response.statusCode == 200) {
        PhongTro motel = jsonDecode(response.body);

        return motel;
      }

      return null;
    }
    catch (ex) {
      print('[moteldetails.dart] Unable to fetch motel details (id = ${this
          .maPT})');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<PhongTro?>(
          future: fetchMotelDetails(this.maPT),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              PhongTro motel = snapshot.data as PhongTro;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // hinh anh va button back
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 180,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            child: Image.network(
                              UriAccess.buildImageUrl(
                                  '/getmotelimage?motelid=${motel.maPT}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25)
                                ),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 7, sigmaY: 7),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: const Icon(
                                      Icons.arrow_back_ios,
                                      size: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2,),
                    //ratting bar
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: Row(children: [
                        RatingBar(
                          ratingWidget: RatingWidget(
                            full: const Icon(
                              Icons.star_rate_rounded,
                              color: Colors.yellow,
                            ),
                            half: const Icon(
                              Icons.star_half_rounded,
                              color: Colors.yellow,
                            ),
                            empty: const Icon(
                              Icons.star_border_rounded,
                              color: Colors.yellow,
                            ),
                          ),
                          onRatingUpdate: (value) {},
                          itemPadding: EdgeInsets.zero,
                          initialRating: 5,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 27,
                        ),
                        const SizedBox(width: 5,),
                      ],
                      ),
                    ),
                    // ten phong tro
                    const Padding(
                      padding: EdgeInsets.only(top: 10, left: 25),
                      child: Row(
                        children: [
                          Text(
                            'snapshot.data!.tieuDe',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,),

                          ),
                        ],
                      ),
                    ),
                    // dia chi
                    const Padding(
                      padding: EdgeInsets.only(top: 10, left: 25),
                      child: Row(children: [
                        Icon(Icons.location_on_outlined, size: 14,
                          color: Colors.black,),
                        SizedBox(width: 3,),
                        Expanded(
                          child: Text(
                            'motel.diaChi',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],),
                    ),
                    // duong line
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 25, right: 25),
                        child: Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.black12,)
                    ),
                    // Tong Quan
                    const Padding(
                      padding: EdgeInsets.only(top: 15, left: 25, right: 25),
                      child: Row(
                        children: [
                          Text(
                            'Tổng quan',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,),
                          ),
                        ],
                      ),
                    ),
                    // Noi dung tong quan
                    const Padding(
                      padding: EdgeInsets.only(top: 15, left: 25, right: 25),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'motel.moTa',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 8,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,),

                            ),
                          ),
                        ],
                      ),
                    ),
                    // duong line
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 25, right: 25),
                        child: Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.black12,)
                    ),
                    // horizontal
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 25,
                          right: 25
                      ),
                    ),
                    // duong line
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 25, right: 25),
                        child: Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.black12,
                        )
                    ),
                    // button
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 25, right: 25),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'motel.soTien as String',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),

                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => const ConfirmBooking()));
                                  },
                                  child: const Text('Thuê trọ ngay'),
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              );
            }

            return const Center(
              child: const CircularProgressIndicator(),
            );
          }),
    );
  }
}
Widget itemHorizontalViewLocation(PhongTro motel) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align (
          alignment: Alignment.center,
          child: SizedBox(
            height: 65,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network (
                UriAccess.buildImageUrl('/getmotelimage?motelid=${motel.maPT}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    ),);
}
