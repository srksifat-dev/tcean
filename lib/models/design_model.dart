
import 'package:file_picker/file_picker.dart';

List<String> positions = [
  "Chest-Left","Chest-Middle","Chest-Right","Front Middle","Back-Upper","Back-Middle","Back-Lower","Right Hand","Left Hand",
];

class DesignModel {
  final PlatformFile? designUrl;
  String? position;
  double? height;
  double? width;
  DesignModel({
    this.designUrl,
    this.position,
    this.height,
    this.width,
  });


  DesignModel copyWith({
    PlatformFile? designUrl,
    String? position,
    double? height,
    double? width,
  }) {
    return DesignModel(
      designUrl: designUrl ?? this.designUrl,
      position: position ?? this.position,
      height: height ?? this.height,
      width: width ?? this.width,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'designUrl': designUrl,
      'position': position,
      'height': height,
      'width': width,
    };
  }

  factory DesignModel.fromMap(Map<String, dynamic> map) {
    return DesignModel(
      designUrl: map['designUrl'] != null ? PlatformFile.fromMap(map['designUrl'] as Map<String,dynamic>) : null,
      position: map['position'] != null ? map['position'] as String : null,
      height: map['height'] != null ? map['height'] as double : null,
      width: map['width'] != null ? map['width'] as double : null,
    );
  }
}
