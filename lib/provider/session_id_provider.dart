import 'package:flutter_riverpod/flutter_riverpod.dart';


class SessionIdNotifier extends StateNotifier<String?> {
  SessionIdNotifier() : super(null);

  void setSessionId(String sessionId) {
    state = sessionId;
  }

  void clearSessionId() {
    state = null;
  }
}

final sessionIdProvider = StateNotifierProvider<SessionIdNotifier, String?>((ref) {
  return SessionIdNotifier();
});