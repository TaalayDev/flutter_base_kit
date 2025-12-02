import 'dart:async';

final class TimerController {
  final streamController = StreamController<TimerState>.broadcast();

  void pause() {
    streamController.add(TimerState.pause);
  }

  void resume() {
    streamController.add(TimerState.resume);
  }

  void addListener(Function(TimerState state) listener) {
    streamController.stream.listen((state) {
      listener(state);
    });
  }

  void dispose() {
    streamController.close();
  }
}

enum TimerState { pause, resume }
