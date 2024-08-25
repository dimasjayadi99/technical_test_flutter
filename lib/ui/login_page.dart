import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technical_test/database/database_helper.dart';
import 'package:technical_test/ui/register_page.dart';
import 'package:technical_test/utils/custom_textfiled.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isObscure = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login(String email, String password) async {

    final dbHelper = DatabaseHelper();
    final user = await dbHelper.loginUser(email, password);

    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('id', user['id']);
      await prefs.setString('email', email);
      await prefs.setBool('isLogin', true);

      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login berhasil!"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      }

    } else {
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email atau password salah!"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Icon(Icons.people_alt, size: 120, color: Colors.black.withOpacity(0.2)),
                const Text("Selamat Datang!", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(
                  "Silahkan Login dengan email terdaftar atau buat akun baru.",
                  style: TextStyle(color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _emailController,
                  text: "Alamat Email",
                  readOnly: false,
                  enable: true,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  prefixIcon: const Icon(Icons.email),
                  isRequired: true,
                ),
                CustomTextField(
                  controller: _passwordController,
                  text: "Password",
                  readOnly: false,
                  enable: true,
                  obscure: isObscure,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  prefixIcon: const Icon(Icons.lock),
                  suffixWidget: GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    child: isObscure ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                  ),
                  isRequired: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    backgroundColor: WidgetStateProperty.all(const Color(0xffF8C20A)),
                    minimumSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.width, 50)),
                  ),
                  onPressed: () {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    _login(email, password);
                  },
                  child: const Text('Lanjutkan', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Atau"),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    backgroundColor: WidgetStateProperty.all(Colors.grey),
                    minimumSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.width, 50)),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterPage()));
                  },
                  child: const Text('Buat Akun', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}