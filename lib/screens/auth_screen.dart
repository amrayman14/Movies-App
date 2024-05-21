import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:movies_app/api/authentication/create_session.dart';
import 'package:movies_app/api/authentication/request_token.dart';
import 'package:movies_app/api/authentication/validate_with_login.dart';
import 'package:movies_app/colors.dart';
import 'package:movies_app/screens/home_screen.dart';
import 'package:movies_app/screens/tabs_screen.dart';

import '../api/account/account_id_api.dart';
import '../constrains.dart';
import '../provider/account_id_provider.dart';
import '../provider/session_id_provider.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var _isAuthenticating = false;
  String? _requestToken;

  Future<void> _initiateAuth() async {
    try {
      _requestToken = await RequestToken().requestToken();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _validateAndCreateSession() async {
    _isAuthenticating = true;
    if (_requestToken == null) return;
    String username = _usernameController.text;
    String password = _passwordController.text;

    try {
      await ValidateWithLogin()
          .validateWithLogin(_requestToken!, username, password);
      final sessionId = await CreateSession().createSession(_requestToken!);
      final accountId =
          await GetAccountId().getAccountId(Constrains.apiKey, sessionId);
      ref.read(sessionIdProvider.notifier).setSessionId(sessionId);
      ref.read(accountIdProvider.notifier).setAccountId(accountId);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => TabsScreen(sessionId, accountId),
        ),
      );
      _isAuthenticating = false;
    } catch (e) {
      throw Exception('Username or password invalid');
    }
  }

  @override
  void initState() {
    super.initState();
    _initiateAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.scaffoldBgColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  right: 20,
                  left: 20,
                ),
                width: 200,
                child: Image.asset('assets/images/movies_logo.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: _usernameController,
                            decoration:
                                const InputDecoration(labelText: "Username"),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "username not valid";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              labelText: "Password",
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return "Password not valid";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          if (_isAuthenticating)
                            const CircularProgressIndicator(),
                          if (!_isAuthenticating)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer),
                                  onPressed: () async {
                                    _validateAndCreateSession();
                                  },
                                  child: const Text("Login"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) => const HomeScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Visitor Mood",
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
