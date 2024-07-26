import 'package:chothuephongtro_v2/utils/emptystring.dart';

class VaiTro {
  late int _maVaiTro = 0;
  late String _tenVaiTro = EmptyString.get();

  VaiTro();
  VaiTro.fullInit(int maVaiTro, String tenVaiTro) {
    this._maVaiTro = maVaiTro;
    this._tenVaiTro = tenVaiTro;
  }

  int get maVaiTro => this._maVaiTro;
  String get tenVaiTro => this._tenVaiTro;

  factory VaiTro.fromJson(Map<String, dynamic> json) {
    return VaiTro.fullInit(
      json['MaVaiTro'],
      json['TenVaiTro'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'MaVaiTro': this._maVaiTro,
      'TenVaiTro': this._tenVaiTro,
    };
  }
}
