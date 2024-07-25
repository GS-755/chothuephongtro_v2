import 'vitri.dart';
import '../users/taikhoan.dart';

class PhongTro {
  final int _maPT;
  final String _tieuDe;
  final DateTime _ngayDang;
  final double _dienTich;
  final double _soTien;
  final double _tienCoc;
  final String _moTa;
  final String _hinhAnh;
  final String _shortText;
  final String _base64Thumbnail;
  final String _diaChi;
  final String _tenDangNhap;
  final int _maVT;
  final int _maTT;
  final ViTri _viTri;
  final TaiKhoan _taiKhoan;

  PhongTro({
    required int maPT,
    required String tieuDe,
    required DateTime ngayDang,
    required double dienTich,
    required double soTien,
    required double tienCoc,
    required String moTa,
    required String hinhAnh,
    required String shortText,
    required String base64Thumbnail,
    required String diaChi,
    required String tenDangNhap,
    required int maVT,
    required int maTT,
    required ViTri viTri,
    required TaiKhoan taiKhoan,
  }) : _maPT= maPT, _tieuDe = tieuDe, _ngayDang = ngayDang,
        _dienTich = dienTich, _soTien = soTien, _tienCoc = tienCoc,
        _moTa = moTa, _hinhAnh = hinhAnh,_shortText = shortText,
        _base64Thumbnail = base64Thumbnail,_diaChi = diaChi,
        _tenDangNhap = tenDangNhap,_maVT = maVT,_maTT = maTT,
        _viTri = viTri, _taiKhoan = taiKhoan;

  factory PhongTro.fromJson(Map<String, dynamic> json) {
    return PhongTro(
      maPT: json['MaPT'],
      tieuDe: json['TieuDe'],
      ngayDang: DateTime.parse(json['NgayDang']),
      dienTich: json['DienTich'],
      soTien: json['SoTien'],
      tienCoc: json['TienCoc'],
      moTa: json['MoTa'],
      hinhAnh: json['HinhAnh'],
      shortText: json['ShortText'],
      base64Thumbnail: '',
      diaChi: json['DiaChi'],
      tenDangNhap: json['TenDangNhap'].trim(),
      maVT: json['MaVT'],
      maTT: json['MaTT'],
      viTri: ViTri.fromJson(json['ViTri']),
      taiKhoan: TaiKhoan.fromJson(json['TaiKhoan']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MaPT': _maPT,
      'TieuDe': _tieuDe,
      'NgayDang': _ngayDang.toIso8601String(),
      'DienTich': _dienTich,
      'SoTien': _soTien,
      'TienCoc': _tienCoc,
      'MoTa': _moTa,
      'HinhAnh': _hinhAnh,
      'ShortText': _shortText,
      'Base64Thumbnail': _base64Thumbnail,
      'DiaChi': _diaChi,
      'TenDangNhap': _tenDangNhap,
      'MaVT': _maVT,
      'MaTT': _maTT,
      'ViTri': _viTri.toJson(),
      'TaiKhoan': _taiKhoan.toJson(),
    };
  }

  TaiKhoan get taiKhoan => this._taiKhoan;
  ViTri get viTri => this._viTri;
  int get maTT => this._maTT;
  int get maVT => this._maVT;
  String get tenDangNhap => this._tenDangNhap;
  String get diaChi => this._diaChi;
  String get base64Thumbnail => this._base64Thumbnail;
  String get shortText => this._shortText;
  String get hinhAnh => this._hinhAnh;
  String get moTa => this._moTa;
  double get tienCoc => this._tienCoc;
  double get soTien => this._soTien;
  double get dienTich => this._dienTich;
  DateTime get ngayDang => this._ngayDang;
  String get tieuDe => this._tieuDe;
  int get maPT => this._maPT;
}
