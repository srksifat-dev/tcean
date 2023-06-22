class TSize {
  final String sizeName;
  final String sizeCode;

  TSize({
    required this.sizeName,
    required this.sizeCode,
  });
}

List<TSize> kSizes = [
  TSize(sizeName: "Small", sizeCode: "s"),
  TSize(sizeName: "Medium", sizeCode: "m"),
  TSize(sizeName: "Large", sizeCode: "l"),
  TSize(sizeName: "Extra Large", sizeCode: "xl"),
  TSize(sizeName: "Double Extra Large", sizeCode: "xxl"),
  TSize(sizeName: "Triple Extra Large", sizeCode: "xxxl"),

];
