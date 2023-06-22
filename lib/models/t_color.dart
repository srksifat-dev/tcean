class TColor {
  final String colorName;
  final int colorCode;

  TColor({
    required this.colorName,
    required this.colorCode,
  });
}

List<TColor> kColors = [
  TColor(colorName: "White", colorCode: 0xffffffff),
  TColor(colorName: "Black", colorCode: 0xff000000),

];
