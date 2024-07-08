import 'dart:async';

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Completer<void> _completer = Completer();
  Future<void>? get future => _completer.future;
  bool get isRunning => !_completer.isCompleted;

  Debouncer({required this.delay});

  Future<void> run(Future<void> Function() action) async {
    _timer?.cancel();

    _completer = Completer();
    final completer = _completer;
    _timer = Timer(delay, () async {
      try {
        await action();

        completer.complete();
      } on Exception catch (e, st) {
        completer.completeError(e, st);
      }
    });

    return _completer.future;
  }

  void dispose() {
    _timer?.cancel();
  }
}
