import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../utils/screen_utils.dart';

class TextCustom extends StatelessWidget {
  final String text;
  final FontCustom fontCustom;
  final FontWeight fontWeight;
  final Color color;
  final double? fontSize;
  final TextStyle? style;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? lineSpacing;
  final TextDecoration textDecoration;

  const TextCustom(this.text,
      {Key? key,
      this.fontCustom = FontCustom.NotoSansJPRegular,
      this.textAlign = TextAlign.left,
      this.maxLines,
      this.fontWeight = FontWeight.normal,
      this.fontSize,
      this.color = AppColor.txtPrimaryColor,
      this.overflow = TextOverflow.ellipsis,
      this.lineSpacing,
      this.textDecoration = TextDecoration.none,
      TextStyle? style = const TextStyle()})
      : style = style;

  getFont(FontCustom _ctFont) {
    switch (_ctFont) {
      case FontCustom.NotoSansJPBlack:
        return 'NotoSansJP-Black';
      case FontCustom.NotoSansJPBold:
        return 'NotoSansJP-Bold';
      case FontCustom.NotoSansJPLight:
        return 'NotoSansJP-Light';
      case FontCustom.NotoSansJPMedium:
        return 'NotoSansJP-Medium';
      case FontCustom.NotoSansJPRegular:
        return 'NotoSansJP-Regular';
      case FontCustom.NotoSansJPThin:
        return 'NotoSansJP-Thin';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        textScaleFactor: 1,
        style: TextStyle(
            fontSize: (fontSize ?? ScreenUtils.resizeHeight(context, 16)),
            fontWeight: fontWeight,
            color: color,
            fontFamily: getFont(fontCustom),
            decoration: textDecoration,
            height: lineSpacing));
  }
}

enum FontCustom {
  NotoSansJPBlack,
  NotoSansJPBold,
  NotoSansJPLight,
  NotoSansJPMedium,
  NotoSansJPRegular,
  NotoSansJPThin,
}
