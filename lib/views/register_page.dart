import 'package:flutter/material.dart';

const String firstNameLabel = 'First Name';
const String lastNameLabel = 'Last Name';
const String usernameLabel = 'Username';
const String emailLabel = 'Email';
const String passwordLabel = 'Password';
const String confirmPasswordLabel = 'Confirm Password';
const String emptyFieldError = 'Please enter ';
const String passwordLengthError = 'Password must be at least 8 characters long';
const String passwordMismatchError = 'Passwords do not match';

class RegisterPage extends StatefulWidget {
  final VoidCallback onLogin;
  final VoidCallback onRegister;

  const RegisterPage({Key? key, required this.onLogin, required this.onRegister}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
                _buildTextField(_firstNameController, firstNameLabel, false, Icons.person, isDarkMode),
                const SizedBox(height: 20),
                _buildTextField(_lastNameController, lastNameLabel, false, Icons.person, isDarkMode),
                const SizedBox(height: 20),
                _buildTextField(_usernameController, usernameLabel, false, Icons.person, isDarkMode),
                const SizedBox(height: 20),
                _buildTextField(_emailController, emailLabel, false, Icons.email, isDarkMode),
                const SizedBox(height: 20),
                _buildTextField(_passwordController, passwordLabel, _obscureText, Icons.lock, isDarkMode),
                const SizedBox(height: 20),
                _buildTextField(_confirmPasswordController, confirmPasswordLabel, _obscureText, Icons.lock, isDarkMode),
                const SizedBox(height: 30),
                _buildRegisterButton(isDarkMode),
                const SizedBox(height: 20),
                _buildFooter(context, isDarkMode),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton(bool isDarkMode) {
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
          widget.onRegister();
        }
      },
      child: const Text('Register'),
    );
  }

  Widget _buildFooter(BuildContext context, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account?', style: TextStyle(color: Colors.blue)),
        TextButton(
          onPressed: widget.onLogin,
          child: const Text(
            'Login',
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
        if (isPassword && _passwordController.text != _confirmPasswordController.text) {
          return passwordMismatchError;
        }
        return null;
      },
    );
  }
}