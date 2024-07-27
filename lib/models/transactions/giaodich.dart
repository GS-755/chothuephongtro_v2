import 'package:chothuephongtro_v2/models/motels/phongtro.dart';
import 'package:chothuephongtro_v2/models/transactions/loaigiaodich.dart';
import 'package:chothuephongtro_v2/models/users/taikhoan.dart';

class GiaoDich {
  final String _maGD;
  final int _maLoaiGD;
  final int _maPT;
  final DateTime _ngayGD;
  final double _soTien;
  final int _maTTGD;
  final String _tenDangNhap;
  final LoaiGiaoDich _loaiGiaoDich;
  final PhongTro _phongTro;
  final TaiKhoan _taiKhoan;

  GiaoDich(
      this._maGD,
      this._maLoaiGD,
      this._maPT,
      this._ngayGD,
      this._soTien,
      this._maTTGD,
      this._tenDangNhap,
      this._loaiGiaoDich,
      this._phongTro,
      this._taiKhoan
  );

  TaiKhoan get taiKhoan => this._taiKhoan;
  PhongTro get phongTro => this._phongTro;
  LoaiGiaoDich get loaiGiaoDich => this._loaiGiaoDich;
  String get tenDangNhap => this._tenDangNhap;
  int get maTTGD => this._maTTGD;
  double get soTien => this._soTien;
  DateTime get ngayGD => this._ngayGD;
  int get maPT => this._maPT;
  int get maLoaiGD => this._maLoaiGD;
  String get maGD => this._maGD;

  factory GiaoDich.fromJson(Map<String, dynamic> json) {
    return GiaoDich(
        json['MaGD'],
        json['MaLoaiGD'],
        json['MaPT'],
        json['NgayGD'],
        json['SoTien'],
        json['MaTTGD'],
        json['TenDangNhap'],
        json['LoaiGiaoDich'],
        json['PhongTro'],
        json['TaiKhoan']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaLoaiGD': this._maLoaiGD,
      'TenDangNhap': this._tenDangNhap,
      'MaPT': this._maPT
    };
  }
}
