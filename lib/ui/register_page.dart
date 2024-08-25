import 'package:flutter/material.dart';
import 'package:technical_test/database/database_helper.dart';

import '../utils/custom_textfiled.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isObscure = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _namaController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> setData(String email, String nama, String password) async {
    final dbHelper = DatabaseHelper();
    await dbHelper.insertUser({
      'email': email,
      'nama': nama,
      'password': password,
      'lahir': "",
      'gender': "",
      'phone': "",
      'pendidikan': "",
      'pernikahan': "",
      'nik': "",
      'alamat': "",
      'provinsi': "",
      'kabupaten': "",
      'kecamatan': "",
      'kelurahan': "",
      'kode': "",
      'is_alamat_sama': 0,
      'alamat_dom': "",
      'provinsi_dom': "",
      'kabupaten_dom': "",
      'kecamatan_dom': "",
      'kelurahan_dom': "",
      'nama_perusahaan': "",
      'alamat_perusahaan': "",
      'jabatan': "",
      'lama_kerja': "",
      'sumber_pendapatan': "",
      'total_pendapatan': "",
      'nama_bank': "",
      'cabang_bank': "",
      'rekening': "",
      'pemilik': "",
    });
  }

  Future<void> _register() async {
    final email = _emailController.text;
    final nama = _namaController.text;
    final password = _passwordController.text;

    // Show progress dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: SizedBox(
            height: 50,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );

    // Delay for 1 second
    await Future.delayed(const Duration(seconds: 1));

    if(mounted){
      // Close the progress dialog
      Navigator.of(context).pop();

      // Call setData
      await setData(email, nama, password);

      // Show success SnackBar
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Akun berhasil dibuat"),
            backgroundColor: Colors.green,
          ),
        );

        // back to login page
        Navigator.of(context).pop();
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
                Icon(Icons.person_add_alt_1_outlined, size: 120, color: Colors.black.withOpacity(0.2)),
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
                  controller: _namaController,
                  text: "Nama Lengkap",
                  readOnly: false,
                  enable: true,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  prefixIcon: const Icon(Icons.person),
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
                  onPressed: _register,
                  child: const Text('Daftar', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
