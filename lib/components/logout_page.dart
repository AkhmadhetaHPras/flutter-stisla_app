import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stisla_app/services/authentication.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  String _email = '';
  String _token = '';
  bool _isLoading = false;

  void _getAuth() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    var email = localStorage.getString('email');
    if (token != null && email != null) {
      if (mounted) {
        setState(() {
          _token = token;
          _email = email;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _token = '';
          _email = '';
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getAuth();
  }

  Future<String> _logout() async {
    return await Authentication.logout(_token);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.person, size: 200.0, color: Colors.white),
            Text(
              _email,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
              padding: const EdgeInsets.only(top: 3, left: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: const Border(
                  bottom: BorderSide(color: Colors.black),
                  top: BorderSide(color: Colors.black),
                  left: BorderSide(color: Colors.black),
                  right: BorderSide(color: Colors.black),
                ),
              ),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  if (await _logout() == 'Success') {
                    setState(() {
                      _isLoading = false;
                    });
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  } else {
                    setState(() {
                      _isLoading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Gagal logout',
                          style: TextStyle(color: Colors.black),
                        ),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        backgroundColor: Colors.white,
                      ),
                    );
                  }
                },
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: !_isLoading
                    ? const Text(
                        "Logout",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      )
                    : const CircularProgressIndicator(
                        color: Colors.black,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
