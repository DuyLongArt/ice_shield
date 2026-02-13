import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ice_shield/orchestration_layer/ReactiveBlock/User/AuthBlock.dart';
import 'package:provider/provider.dart';
import 'package:signals_flutter/signals_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late AuthBlock _authBlock;
  late final void Function() _disposeEffect;

  @override
  void initState() {
    super.initState();
    _authBlock = context.read<AuthBlock>();

    // Redirect when authenticated
    _disposeEffect = effect(() {
      if (_authBlock.status.value == AuthStatus.authenticated) {
        if (mounted) {
          context.go('/');
        }
      }
    });
  }

  @override
  void dispose() {
    _disposeEffect(); // Stop watching the signal
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      final status = _authBlock.status.value;
      final error = _authBlock.error.value;
      final isLoading =
          status == AuthStatus.authenticating ||
          status == AuthStatus.registering ||
          status == AuthStatus.checkingSession;

      // Show welcome snackbar on success
      if (status == AuthStatus.authenticated &&
          _authBlock.username.value != null) {
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        // if (mounted) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Row(
        //         children: [
        //           const Icon(Icons.check_circle, color: Colors.white),
        //           const SizedBox(width: 12),
        //           Text('Welcome, ${_authBlock.username.value}!'),
        //         ],
        //       ),
        //       behavior: SnackBarBehavior.floating,
        //       backgroundColor: Colors.deepPurpleAccent,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(12),
        //       ),
        //       margin: const EdgeInsets.all(16), // Adds space from screen edges
        //       duration: const Duration(seconds: 3),
        //     ),
        //   );
        // }
        // });
      }

      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Placeholder - Shield Icon
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shield_outlined,
                    size: 64,
                    color: Color(0xFF00A36C), // Emerald green
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'ICE SHIELD',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Secure your digital assets',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 0, 0, 0),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 16),

                // Error Display
                if (error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      error,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 13,
                      ),
                    ),
                  ),

                const SizedBox(height: 32),

                // Email Field
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Email address',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      size: 20,
                      color: Colors.white70,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 0, 0, 0),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF00A36C),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Password Field
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      size: 20,
                      color: Colors.white70,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 0, 0, 0),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF00A36C),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00A36C),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        inherit: true,
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Login',
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),

                // Passkey Login Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton.icon(
                    onPressed: isLoading ? null : _handlePasskeyLogin,
                    icon: const Icon(Icons.fingerprint_rounded, size: 24),
                    label: const Text(
                      'Sign in with Passkey',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF00A36C),
                      side: const BorderSide(
                        color: Color(0xFF00A36C),
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Additional Options
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // TextButton(
                    //   onPressed: () {
                    //     // Handle Forgot Password
                    //   },
                    //   child: Text(
                    //     'Forgot Password?',
                    //     style: TextStyle(
                    //       color: Colors.grey.shade600,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(width: 8),
                    Text('•', style: TextStyle(color: Colors.grey.shade400)),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        // Handle Sign Up
                      },
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          color: Color(0xFF00A36C),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter username and password')),
      );
      return;
    }

    await _authBlock.login(email, password, context);
  }

  Future<void> _handlePasskeyLogin() async {
    // Passkey login currently isn't in AuthBlock but could be.
    // Keeping it separate for now or refactoring as an action.
    try {
      // For now, using the local service logic or moving it to AuthBlock later
      await _authBlock.checkSession(context);
      // Note: Full passkey flow should be in AuthBlock too for consistency
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Passkey failed: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }
}
