import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import '../../components/navigationbar.dart';

class ConfirmBooking extends StatefulWidget {
  const ConfirmBooking({super.key});

  @override
  State<ConfirmBooking> createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  bool isSelected = true;
  bool isSelected2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);},
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 7,sigmaY: 7),
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
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Xác nhận và thanh toán", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15,color: Colors.black),),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20, top: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(0, 2),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.asset(
                            "assets/hotel/hing1.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded( // Sử dụng Expanded ở đây
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
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
                                  itemSize: 18,
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            const Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'motel.tieuDe',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            const Row(
                              children: [
                                Icon(Icons.location_on, size: 9, color: Colors.black),
                                SizedBox(width: 3), // Thêm SizedBox để có khoảng cách giữa icon và văn bản
                                Expanded( // Sử dụng Expanded ở đây để văn bản không bị tràn ra ngoài
                                  child: Text(
                                    'motel.diaChi',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              NumberFormat('###,###').format(1900000),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // duong line
            Padding(
                padding: const EdgeInsets.only(top: 15, left: 25,right: 25),
                child: Container(width: double.infinity,height: 1,color: Colors.black12,)
            ),
            // Đường line
            Padding(
                padding: const EdgeInsets.only(top: 5, left: 25,right: 25),
                child: Container(width: double.infinity,height: 1,color: Colors.black12,)
            ),
            // lua chon phuong thuc thanh toan
            const Padding(
              padding: EdgeInsets.only(top: 30, left: 25),
              child: Row(
                children: [
                  Text('Lựa chọn phương thức thanh toán',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            // chuyen khoan du
            Padding(
              padding: const EdgeInsets.only(left: 25,right: 25),
              child: Row(children: [
                const Align(alignment: Alignment.centerLeft,
                  child: Text('Chuyển khoản đủ',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black
                    ),
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Radio(
                    value: true,
                    groupValue: isSelected,
                    onChanged: (value) {
                      setState(() {
                        isSelected = value!;
                      });
                    },
                  ),
                ),
              ],),
            ),
            // duong line
            Padding(
                padding: const EdgeInsets.only(top: 5, left: 25,right: 25),
                child: Container(width: double.infinity,height: 1,color: Colors.black12,)
            ),
            // coc
            Padding(
              padding: const EdgeInsets.only(left: 25,right: 25),
              child: Row(children: [
                const Align(alignment: Alignment.centerLeft,
                  child: Text('Cọc trước, thanh toán sau',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Radio(
                    value: true,
                    groupValue: isSelected2,
                    onChanged: (value) {
                      setState(() {
                        isSelected2 = value!;
                      });
                    },
                  ),
                ),
              ],),
            ),
            // duong line
            Padding(
                padding: const EdgeInsets.only(top: 5, left: 25,right: 25),
                child: Container(width: double.infinity,height: 1,color: Colors.black12,)
            ),
            // chi tiet don
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 25),
              child: Row(
                children: [
                  Text('Chi tiết',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w600, ),

                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25,right: 25,top: 5),
              child: Row(children: [
                Align(alignment: Alignment.centerLeft,
                  child: Text(
                    'Chuyển khoản đủ',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Giá tiền',
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
            const Padding(
              padding: EdgeInsets.only(left: 25,right: 25,top: 5),
              child: Row(children: [
                Align(alignment: Alignment.centerLeft,
                  child: Text(
                    'Tiền cọc',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Giá tiền',
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
                padding: const EdgeInsets.only(top: 20, left: 25,right: 25),
                child: Container(width: double.infinity,height: 1,color: Colors.black12,)
            ),
            // tong tien
            const Padding(
              padding: EdgeInsets.only(left: 25,right: 25,top: 5),
              child: Row(children: [
                Align(alignment: Alignment.centerLeft,
                  child: Text('Tổng tiền:',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w600, ),

                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('Giá tiền',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w600, ),

                  ),
                ),
              ],),
            ),
            // button
            Padding(
                padding: const EdgeInsets.only(top: 15, left: 25,right: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: (){
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
                              builder: (BuildContext context){
                                return AnimatedContainer(
                                  decoration: BoxDecoration(
                                    color: Colors.white60,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        offset: const Offset(0, 2),
                                        blurRadius: 8.0,
                                      ),
                                    ],
                                  ),
                                  duration: const Duration(microseconds: 300),
                                  height: 300,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 80,bottom: 10),
                                        child: Text('Xác nhận thành công !',
                                          style: TextStyle(color: Colors.black,fontSize: 20),),
                                      ),
                                      // text ngay thang
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 20),
                                        child: Text(
                                          'Chúc mừng bạn ngày mới vui vẻ',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const NavigationBottomBar()));
                                        },
                                        child: const Text('Trở về'),
                                      ),
                                    ],
                                  ),
                                );
                              },);
                          },
                          child: const Text('Chốt Luôn'),
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
