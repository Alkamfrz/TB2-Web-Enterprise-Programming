import 'package:flutter/material.dart';

const String usernameLabel = 'Username or Email';
const String passwordLabel = 'Password';
const String emptyFieldError = 'Please enter ';
const String passwordLengthError = 'Password must be at least 8 characters long';

class LoginPage extends StatefulWidget {
  final VoidCallback onLogin;
  final VoidCallback onRegister;

  const LoginPage({Key? key, required this.onLogin, required this.onRegister}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 50),
                _buildLogo(screenSize),
                const SizedBox(height: 50),
                _buildTextField(_usernameController, usernameLabel, false, Icons.person, isDarkMode),
                const SizedBox(height: 20),
                _buildTextField(_passwordController, passwordLabel, _obscureText, Icons.lock, isDarkMode),
                const SizedBox(height: 30),
                _buildLoginButton(isDarkMode),
                const SizedBox(height: 20),
                _buildFooter(context, isDarkMode),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(Size screenSize) {
    return Image.asset(
      'images/chisato.jpg',
      width: screenSize.width * 0.5,
      height: screenSize.height * 0.3,
      fit: BoxFit.contain,
    );
  }

  Widget _buildLoginButton(bool isDarkMode) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: isDarkMode ? Colors.black : Colors.white,
        backgroundColor: isDarkMode ? Colors.white : Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: const EdgeInsets.all(16.0),
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          widget.onLogin();
        }
      },
      child: const Text('Login'),
    );
  }

  Widget _buildFooter(BuildContext context, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t have an account?', style: TextStyle(color: Colors.blue)),
        TextButton(
          onPressed: widget.onRegister,
          child: const Text(
            'Register',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, bool isPassword, IconData icon, bool isDarkMode) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        labelStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.blue),
        prefixIcon: Icon(icon, color: isDarkMode ? Colors.white : Colors.blue),
        suffixIcon: isPassword ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: isDarkMode ? Colors.white : Colors.blue,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ) : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return emptyFieldError + label;
        }
        if (isPassword && value.length < 8) {
          return passwordLengthError;
        }
        return null;
      },
    );
  }
}