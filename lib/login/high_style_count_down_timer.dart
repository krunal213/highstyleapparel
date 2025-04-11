import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:highstyleapparel/generated/l10n.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'high_style_count_down_timer_helper.dart';

class HighStyleCountDownTimer extends StatefulWidget {
  final Function() onTap;
  final bool shouldRestartCountDown;

  const HighStyleCountDownTimer(
      {super.key, required this.onTap, required this.shouldRestartCountDown});

  @override
  State<HighStyleCountDownTimer> createState() =>
      _HighStyleCountDownTimerState();
}

class _HighStyleCountDownTimerState extends State<HighStyleCountDownTimer> {
  late final HighStyleCountDownTimerHelper _highStyleCountDownTimerHelper;
  late final StopWatchTimer _stopWatchTimer;
  final _count_down_end = 0;

  @override
  void initState() {
    super.initState();
    //highStyleCountDownTimerHelper is used for testing purpose only
    _highStyleCountDownTimerHelper = GetIt.I<HighStyleCountDownTimerHelper>();

    _stopWatchTimer = StopWatchTimer(
        mode: StopWatchMode.countDown,
        presetMillisecond: _highStyleCountDownTimerHelper.endTime());

    _stopWatchTimer.onStartTimer();
  }

  @override
  void didUpdateWidget(covariant HighStyleCountDownTimer oldWidget) {
    if (widget.shouldRestartCountDown) {
      _stopWatchTimer.onResetTimer();
      _stopWatchTimer.onStartTimer();
    }
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StreamBuilder<int>(
          stream: _stopWatchTimer.rawTime,
          initialData: _stopWatchTimer.rawTime.value,
          builder: (context, snap) {
            final value = snap.data!;
            final displayTime = StopWatchTimer.getDisplayTime(value,
                hours: false, minute: true, second: true, milliSecond: false);

            return _count_down_end == value
                ? GestureDetector(
                    key: const Key('resend_now'),
                    onTap: widget.onTap,
                    child: Text(
                      S.of(context).title_resend,
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.black),
                    ))
                : Text(
                    key: const Key('count_down_timer'),
                    S.of(context).title_resend_in + displayTime,
                    style: const TextStyle(
                        fontSize: 14.0, color: Color(0xFFA5A7AC)),
                  );
          },
        ),
      ],
    );
  }
}
