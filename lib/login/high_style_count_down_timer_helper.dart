import 'package:stop_watch_timer/stop_watch_timer.dart';

abstract class HighStyleCountDownTimerHelper {
  int endTime();
}

class HighStyleCountDownTimerHelperImpl
    implements HighStyleCountDownTimerHelper {
  @override
  int endTime() => StopWatchTimer.getMilliSecFromMinute(15);
}
