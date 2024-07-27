import 'dart:convert';
import 'package:chothuephongtro_v2/users/motels/moteldetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import '../models/motels/phongtro.dart';
import '../models/motels/vitri.dart';
import 'package:http/http.dart' as http;
import '../utils/uribuilder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  // Call List location API
  Future<List<ViTri>> fetchLocations() async {
    final response = await http.get(UriBuilder.buildApiUri('/locations'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((item) => ViTri.fromJson(item)).toList();
    } else {
      throw Exception('[trangchu.dart] Failed to load Location list');
    }
  }
  final _searchController = TextEditingController();
  bool _hasSearched = false;
  List<dynamic> _searchResults = [];

  Future<List<PhongTro>> fetchMotels() async {
    final response = await http.get(UriBuilder.buildApiUri('/motels'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((item) => PhongTro.fromJson(item)).toList();
    } else {
      throw Exception('[trangchu.dart] Failed to load newest motel list');
    }
  }

  Future<List<PhongTro>> fetchNewestMotels() async {
    final response =
    await http.get(UriBuilder.buildApiUri('/motels/getnewestmotel'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.map((item) => PhongTro.fromJson(item)).toList();
    } else {
      throw Exception('[trangchu.dart] Failed to load newest motel list');
    }
  }

  //khai bao list
  //List<HotelListData> lsthotel = HotelListData.hotelList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: 240,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 180,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          child: Image.asset(
                            "assets/images/homepage/homepage.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 140,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            height: 80,
                            child: Center(
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                        ),
                                        color: Color(0xFFFFEDD7),
                                      ),
                                      height: 40,
                                      width: 70,
                                      child: const Center(
                                        child: Text(
                                          "TPHCM",
                                          style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            bottomRight: Radius.circular(8),
                                          ),
                                          color: Color(0xFFF7F7F7),
                                        ),
                                        height: 40,
                                        child: Center(
                                          child: TextField(
                                            controller: _searchController,
                                            decoration: const InputDecoration(
                                              labelText: 'Tìm kiếm phòng trọ',
                                              fillColor: Color(0xFFFFEDD7),
                                              filled: true,
                                              border: InputBorder.none,
                                            ),
                                            style: TextStyle(color: Colors.orange),
                                            onSubmitted: (value) {
                                              _handlesearch();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )

                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Vi tri dang cho thue
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: 20,
                    child: Text(
                      "Vị trí đang cho thuê",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: SizedBox(
                    height: 200,
                    child: FutureBuilder<List<ViTri>>(
                      future: fetchLocations(), // Hàm lấy dữ liệu từ API
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                // Đặt chiều cao bằng với chiều rộng để tạo thành ô vuông// Khoảng cách giữa các item
                                child: itemHorizontalViewLocation(
                                    snapshot.data![index]),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          print('Error: ${snapshot.error}');
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Container(
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
                // cac tro gia re
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: 20,
                    child: Text(
                      "Phòng trọ vừa được tìm kiếm",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.black
                      ),
                    ),
                  ),
                ),
                if(_hasSearched)
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      height: 240,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 5, left: 2, right: 2),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MotelDetails(motel: _searchResults[index]),
                                  ),
                                );
                              },
                              child: Container(
                                child: itemHorizontalView(_searchResults[index]),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: 20,
                    child: Text(
                      "Phòng trọ mới đăng",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.black
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: SizedBox(
                    height: 240,
                    child: FutureBuilder<List<PhongTro>>(
                        future: fetchNewestMotels(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                scrollDirection:
                                Axis.horizontal, // Thiết lập cuộn ngang
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5, left: 2, right: 2),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MotelDetails(motel: snapshot.data![index],),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        // Đặt chiều cao bằng với chiều rộng để tạo thành ô vuông// Khoảng cách giữa các item
                                        child: itemHorizontalView(
                                            snapshot.data![index]),
                                      ),
                                    ),
                                  );
                                });
                          }

                          return Container(
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          );
                        }),
                  ),
                ),
                // gan noi o cua ban
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: 20,
                    child: Text(
                      "Các phòng trọ khác",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 350,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                    child: FutureBuilder(
                        future: fetchMotels(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5, left: 3, right: 2),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MotelDetails(motel: snapshot.data![index],),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      // Đặt chiều cao bằng với chiều rộng để tạo thành ô vuông// Khoảng cách giữa các item
                                      child: itemListViewViewNearYourLocation(
                                          snapshot.data![index]),
                                    ),
                                  ),
                                );
                              },
                            );
                          }

                          return Container(
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          );
                        }),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget itemHorizontalView(PhongTro motel) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        height: 150,
        width: 140,
        decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  offset: const Offset(0, 2),
                  blurRadius: 8.0)
            ]),
        child: Expanded(
          child: Padding(
            padding:
            const EdgeInsets.only(top: 4, bottom: 2, left: 4, right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.network(
                        UriBuilder.buildImageUrl(
                            '/getmotelimage?motelid=${motel.maPT}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
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
                      itemSize: 15,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        motel.tieuDe,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 10,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(
                          motel.diaChi,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.home_work_outlined,
                      size: 10,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(
                          motel.viTri.Quan,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  NumberFormat('###,###,### đ/tháng').format(motel.soTien),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemHorizontalViewLocation(ViTri location) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        child: Stack(children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 150,
              width: 110,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  UriBuilder.buildImageUrl(
                      '/getlocationimage?locationId=${location.MaVT}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 130,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                location.Quan,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget itemListViewViewNearYourLocation(PhongTro motel) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(5),
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
              padding: const EdgeInsets.all(3.0),
              child: SizedBox(
                height: 100,
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.network(
                    UriBuilder.buildImageUrl('/getmotelimage?motelid=${motel.maPT}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              // Sử dụng Expanded ở đây
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 2),
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
                            motel.tieuDe,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.location_on_rounded,
                            size: 10, color: Colors.grey),
                        const SizedBox(
                            width:
                            3), // Thêm SizedBox để có khoảng cách giữa icon và văn bản
                        Expanded(
                          // Sử dụng Expanded ở đây để văn bản không bị tràn ra ngoài
                          child: Text(
                            motel.diaChi,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.home_work_outlined,
                          size: 10,
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Text(
                              motel.viTri.Quan,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      NumberFormat('###,###,### đ/tháng').format(motel.soTien),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _handlesearch() async {
    final keyword = _searchController.text.trim();
    print(keyword);
    final apiUrl = Uri.parse("${dotenv.env['API_URL']!.trim()}/motels/SearchMotel?keyword=$keyword");
    try {
      final response = await http.get(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        print('[search.dart] Search successful');
        final data = jsonDecode(response.body);
        // Assuming data is a list of motels
        setState(() {
          _searchResults = data.map((json) => PhongTro.fromJson(json)).toList();
          _hasSearched = true;
        });
        // Process the data as needed
        print('[search.dart] Search results: $data');
      } else {
        // Đăng nhập thất bại
        print('[search.dart] Search failed');
      }
    } catch (e) {
      // Xử lý lỗi
      print('[search.dart] Error during search:\n $e');
    }
  }
}


