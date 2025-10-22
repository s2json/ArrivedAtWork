import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// 실시간 시:분:초를 보여주는 위젯
class CurrentTimeWidget extends StatelessWidget {
  /// textStyle이 null이면 기본 스타일을 사용
  final TextStyle? textStyle;

  /// 시분초 사이의 구분자 (기본 ':')
  final String separator;

  /// 초 단위까지 포맷 (true) / 초 없이 (false)
  final bool showSeconds;

  const CurrentTimeWidget({
    super.key,
    this.textStyle,
    this.separator = ':',
    this.showSeconds = true,
  });

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  String _format(DateTime dt) {
    final h = _twoDigits(dt.hour);
    final m = _twoDigits(dt.minute);
    if (!showSeconds) return '$h$separator$m';
    final s = _twoDigits(dt.second);
    return '$h$separator$m$separator$s';
  }

  @override
  Widget build(BuildContext context) {
    final defaultStyle = GoogleFonts.sairaStencilOne(
      fontSize: 58,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).textTheme.bodyLarge?.color,
      letterSpacing: 4.2,
    );

    // Stream.periodic로 매초 DateTime.now()를 방출.
    return StreamBuilder<DateTime>(
      stream: Stream<DateTime>.periodic(
        const Duration(seconds: 1),
        (_) => DateTime.now(),
      ).asBroadcastStream(),
      initialData: DateTime.now(),
      builder: (context, snapshot) {
        final now = snapshot.data ?? DateTime.now();
        final text = _format(now);
        return Text(text, style: textStyle ?? defaultStyle);
      },
    );
  }
}
