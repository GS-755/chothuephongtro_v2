import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:chothuephongtro_v2/utils/uribuilder.dart';
import 'package:intl/intl.dart';
import '../../models/motels/phongtro.dart';
import 'package:chothuephongtro_v2/users/booking/confirmbooking.dart';

class MotelDetails extends StatefulWidget {
  final PhongTro motel;

  const MotelDetails({super.key, required this.motel});

  @override
  State<MotelDetails> createState() => _MotelDetailsState(motel: motel);
}

class _MotelDetailsState extends State<MotelDetails> {
  final PhongTro motel;

  _MotelDetailsState({required this.motel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                      UriBuilder.buildImageUrl('/getmotelimage?motelid=${motel.maPT}'),
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
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 25),
              child: Row(
                children: [
                  Text(
                    motel.tieuDe,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,),

                  ),
                ],
              ),
            ),
            // dia chi
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 25),
              child: Row(children: [
                const Icon(Icons.location_on_outlined, size: 14,
                  color: Colors.black,),
                const SizedBox(width: 3,),
                Expanded(
                  child: Text(
                    motel.diaChi,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(
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
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            // Noi dung tong quan
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 25, right: 25),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      motel.moTa,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 8,
                      style: const TextStyle(
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
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          NumberFormat('###,###,### đ/tháng').format(motel.soTien),
                          style: const TextStyle(
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
                                builder: (context) => ConfirmBooking(motel: motel)));
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
      ),
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
                UriBuilder.buildImageUrl('/getmotelimage?motelid=${motel.maPT}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    ),);
}
