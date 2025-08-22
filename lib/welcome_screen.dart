import 'about_screen.dart';
import 'home_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  final TextEditingController _adminPasswordController =
      TextEditingController();
  String? _verificationId;
  bool _showAuthForm = false;
  bool _loading = false;
  bool _codeSent = false;
  bool _isAdmin = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Wynford Weather Alerts',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF90CAF9), Color(0xFF1565C0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // --- Get Started/Login Button ---
                HomeButton(
                  icon: Icons.login,
                  label: 'Get Started / Login',
                  color: Colors.blueAccent,
                  onTap: () {
                    setState(() {
                      _showAuthForm = !_showAuthForm;
                    });
                  },
                ),
                const SizedBox(height: 24),
                // --- AUTH FORM ---
                if (_showAuthForm)
                  Card(
                    color: Colors.white.withOpacity(0.95),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const Text(
                            'Sign In / Sign Up',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1976D2),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _loading
                              ? const CircularProgressIndicator()
                              : Column(
                                  children: [
                                    TextField(
                                      controller: _phoneController,
                                      keyboardType: TextInputType.phone,
                                      decoration: const InputDecoration(
                                        labelText: 'Phone Number',
                                        hintText: '+1 555 123 4567',
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    if (_codeSent) ...[
                                      TextField(
                                        controller: _smsController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          labelText: 'SMS Code',
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: _isAdmin,
                                            onChanged: (val) {
                                              setState(() {
                                                _isAdmin = val ?? false;
                                              });
                                            },
                                          ),
                                          const Text(
                                            'Sign in as Admin',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (_isAdmin)
                                        TextField(
                                          controller: _adminPasswordController,
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                            labelText: 'Admin Password',
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                      const SizedBox(height: 16),
                                      ElevatedButton(
                                        onPressed: _signInWithSmsCode,
                                        child: const Text('Sign In'),
                                      ),
                                    ] else ...[
                                      ElevatedButton(
                                        onPressed: _verifyPhone,
                                        child: const Text('Verify Phone'),
                                      ),
                                    ],
                                    if (_error != null)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 16.0,
                                        ),
                                        child: Text(
                                          _error!,
                                          style: const TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                // --- INFO/ABOUT ---
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.info_outline),
                  label: const Text('Learn More'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 6,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
                Card(
                  color: Colors.white.withOpacity(0.9),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: const [
                        Text(
                          'Why Sign In?',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1976D2),
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          '• Get personalized alerts\n• Access emergency contacts\n• Stay updated on school closings\n• Help keep our community safe',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Created by Wynford Weather Mission\nVersion 1.0',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _verifyPhone() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      setState(() {
        _loading = false;
        _error = 'Phone number is required';
      });
      return;
    }
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (credential) async {
          setState(() {
            _loading = false;
          });
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          setState(() {
            _loading = false;
            _error = 'Phone verification failed. Please try again.';
          });
        },
        codeSent: (verificationId, resendToken) {
          setState(() {
            _loading = false;
            _codeSent = true;
            _verificationId = verificationId;
            _error = null;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) {
          setState(() {
            _verificationId = verificationId;
          });
        },
      );
    } catch (e) {
      setState(() {
        _loading = false;
        _error = 'An error occurred. Please try again later.';
      });
    }
  }

  void _signInWithSmsCode() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final smsCode = _smsController.text.trim();
    if (smsCode.isEmpty) {
      setState(() {
        _loading = false;
        _error = 'SMS code is required';
      });
      return;
    }
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      // Navigate to the home screen or wherever appropriate
    } catch (e) {
      setState(() {
        _loading = false;
        _error = 'Invalid SMS code. Please try again.';
      });
    }
  }
}
