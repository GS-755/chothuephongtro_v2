import 'dart:convert';
import 'dart:ui';
import 'package:chothuephongtro_v2/models/motels/phongtro.dart';
import 'package:chothuephongtro_v2/models/transactions/giaodich.dart';
import 'package:chothuephongtro_v2/users/booking/vnpaywebview.dart';
import 'package:chothuephongtro_v2/users/transactions/paymenturlnode.dart';
import 'package:chothuephongtro_v2/users/transactions/vnpaynode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import '../../utils/uribuilder.dart';
import 'package:http/http.dart' as http;

class ConfirmBooking extends StatefulWidget {
  final PhongTro motel;

  const ConfirmBooking({Key? key, required this.motel}) : super(key: key);

  @override
  State<ConfirmBooking> createState() => _ConfirmBookingState(motel: this.motel);
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  int isSelected = 1;
  bool isSelected2 = false;
  final PhongTro motel;
  _ConfirmBookingState({required this.motel});

  Future<void> _handleTransactionMaker() async {
    final String userName = localStorage.getItem('username').toString();
    final int motelId = motel.maPT;
    final int transactType = isSelected;

    try {
      final response = await http.post(
          UriBuilder.buildApiUri('/transactions/postgiaodich'),
          headers: { 'Content-Type': 'application/json' },
          body: jsonEncode({
            'MaLoaiGD': transactType,
            'TenDangNhap': userName,
            'MaPT': motelId
          })
      );
      if(response.statusCode == 201) {
        GiaoDich transact = GiaoDich.fromJson(jsonDecode(response.body));
        VnPayNode node = new VnPayNode(maGD: transact.maGD);
        final vnPayResponse = await http.post(
          UriBuilder.buildApiUri('/vnpay/sendtransaction'),
            headers: { 'Content-Type': 'application/json' },
            body: node.toJson()
        );
        if(vnPayResponse.statusCode == 200) {
          PaymentUrlNode urlNode = PaymentUrlNode.fromJson(
              jsonDecode(response.body)
          );
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VnPayWebView(websiteUrl: urlNode)
              )
          );
        }
        else if(vnPayResponse.statusCode == 401) {
          print('[confirmbooking.dart] Session expired!');
        }
        else {
          print('[confirmbooking.dart] Unable to process vnpay transaction - ${response.statusCode}');
        }
      }
      else if(response.statusCode == 401) {
        print('[confirmbooking.dart] Session expired!');
      }
      else {
        print('[confirmbooking.dart] Unable to make transaction - ${response.statusCode}');
      }
    }
    catch(ex) {
      print('[confirmbooking.dart] An error has occured when making transaction!');
      print(ex);
    }
  }
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
                          child: Image.network(
                            UriBuilder.buildImageUrl('/getmotelimage?motelid=${widget.motel.maPT}'),
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
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.motel.tieuDe,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 9, color: Colors.black),
                                SizedBox(width: 3), // Thêm SizedBox để có khoảng cách giữa icon và văn bản
                                Expanded( // Sử dụng Expanded ở đây để văn bản không bị tràn ra ngoài
                                  child: Text(
                                    widget.motel.diaChi,
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
                    value: 1,
                    groupValue: isSelected,
                    onChanged: (int ?value) {
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
                    value: 2,
                    groupValue: isSelected,
                    onChanged: (int ?value) {
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
            // chi tiet don
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 25),
              child: Row(
                children: [
                  Text('Chi tiết',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600, ),

                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25,right: 25,top: 5),
              child: Row(children: [
                Align(alignment: Alignment.centerLeft,
                  child: Text(
                    'Chuyển khoản đủ',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    NumberFormat('###,###,### đ/tháng').format(widget.motel.soTien),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25,right: 25,top: 5),
              child: Row(children: [
                Align(alignment: Alignment.centerLeft,
                  child: Text(
                    'Tiền cọc',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    NumberFormat('###,###,### đ/tháng').format(widget.motel.tienCoc),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
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
            Padding(
              padding: EdgeInsets.only(left: 25,right: 25,top: 5),
              child: Row(children: [
                Align(alignment: Alignment.centerLeft,
                  child: Text('Tổng tiền:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600, ),

                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    isSelected == 1
                        ? NumberFormat('###,###,### đ/tháng').format(widget.motel.soTien)
                        : NumberFormat('###,###,### đ/tháng').format(widget.motel.tienCoc),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
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
                          onPressed: () {
                            _handleTransactionMaker();
                            // showDialog(context: context, builder: (context) => const CustomModalSuccess());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: double.infinity,
                              child: const Text(
                                'Thanh Toán',
                                textAlign: TextAlign.center, // Align the text to the center
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              ),
                            ),
                          ),
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

class CustomModalSuccess extends StatelessWidget {
  const CustomModalSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Add a success icon at the top
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 50,
            ),
            const SizedBox(height: 20),
            // Add the success message
            Text(
              'Xác Nhận Thanh Toán Thành Công',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            const SizedBox(height: 20),
            // Add a line separator
            Divider(color: Colors.grey[300], thickness: 1),
            const SizedBox(height: 10),
            // Add a thank you message
            Text(
              'Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 20),
            // Add a close button
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen, // Button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text('Đóng',  style: TextStyle(fontSize: 16, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
