import 'package:flutter/material.dart';

class _CustomText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? fontSize;
  final double? height;
  final double? letterSpacing;
  final bool? softWrap;

  const _CustomText(
    this.text, {
    super.key,
    this.textAlign,
    this.fontWeight,
    this.color = Colors.black,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.fontSize,
    this.height,
    this.letterSpacing,
    this.softWrap,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: fontWeight,
            color: color,
            fontSize: fontSize,
            height: height,
            letterSpacing: letterSpacing,
          ),
      softWrap: softWrap,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

class Head1 extends _CustomText {
  const Head1(
    super.text, {
    super.fontSize = 28,
    super.fontWeight = FontWeight.w600,
    super.height = 32 / 28,
    super.textAlign,
    super.color,
    super.maxLines,
    super.overflow,
    super.letterSpacing = 0.28,
    super.softWrap,
    super.key,
  });
}

class Head2 extends _CustomText {
  const Head2(
    super.text, {
    super.fontSize = 24,
    super.fontWeight = FontWeight.w600,
    super.height = 28 / 24,
    super.textAlign,
    super.color,
    super.maxLines,
    super.overflow,
    super.letterSpacing = 0.24,
    super.softWrap,
    super.key,
  });
}
