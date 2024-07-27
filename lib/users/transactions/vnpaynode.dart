class VnPayNode {
  final String maGD;

  VnPayNode({required this.maGD});

  	Map<String, dynamic> toJson() {
      return {
        'MaGD': this.maGD,
      };
    }
}
