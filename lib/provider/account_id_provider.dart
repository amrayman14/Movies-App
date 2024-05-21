import 'package:flutter_riverpod/flutter_riverpod.dart';


class AccountIdNotifier extends StateNotifier<String?> {
  AccountIdNotifier() : super(null);

  void setAccountId(String accountId) {
    state = accountId;
  }

  void clearSessionId() {
    state = null;
  }
}

final accountIdProvider = StateNotifierProvider<AccountIdNotifier, String?>((ref) {
  return AccountIdNotifier();
});