import 'package:flutter_svg/svg.dart';

SvgPicture svgHelper(String path, double? width, double? height) {
  return SvgPicture.asset(path, width: width, height: height);
}
