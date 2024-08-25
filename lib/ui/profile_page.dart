import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technical_test/database/database_helper.dart';
import 'package:technical_test/ui/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  List<CardActionProfile> listActionProfile = [];
  Map<String, dynamic>? dataUser;

  @override
  void initState() {
    super.initState();
    listActionProfile = [
      CardActionProfile(
        iconAction: Icons.person,
        textAction: 'Informasi Pribadi',
        onTapAction: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EditProfilePage(data: dataUser)))
              .then((updatedData) {
            if (updatedData != null) {
              setState(() {
                dataUser = updatedData;
              });
              getDataUser();
            }
          });
        },
      ),
      CardActionProfile(iconAction: Icons.file_copy_rounded, textAction: 'Syarat & Ketentuan', onTapAction: () {}),
      CardActionProfile(iconAction: Icons.help, textAction: 'Bantuan', onTapAction: () {}),
      CardActionProfile(iconAction: Icons.safety_check, textAction: 'Kebijakan Privasi', onTapAction: () {}),
      CardActionProfile(
        iconAction: Icons.exit_to_app,
        textAction: 'Log Out',
        onTapAction: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Logout"),
                content: const Text("Anda yakin ingin keluar akun?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Batal"),
                  ),
                  TextButton(
                    onPressed: () async {
                      await logout();
                      if(context.mounted) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Keluar"),
                  ),
                ],
              );
            },
          );
        },
      ),
      CardActionProfile(iconAction: Icons.delete, textAction: 'Hapus Akun', onTapAction: () {}),
    ];
    getDataUser();
  }

  @override
  void dispose() {
    listActionProfile.clear();
    super.dispose();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> getDataUser() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt("id");

    if (id != null) {
      final dbHelper = DatabaseHelper();
      final data = await dbHelper.getUserById(id);
      setState(() {
        dataUser = data;
      });
    } else {
      setState(() {
        dataUser = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(100)),
                            child: Container(
                              color: Colors.grey,
                              width: 60,
                              height: 60,
                              padding: const EdgeInsets.all(10),
                              child: const Center(
                                child: Text("D", style: TextStyle(color: Colors.white, fontSize: 20)),
                              ),
                            ),
                          ),
                          Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                    color: Colors.white
                                ),
                                child: const Icon(Icons.camera_alt, size: 14,),
                              )
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(dataUser?['nama'] ?? "Nama Tidak Tersedia", style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        const Text("Masuk dengan Google", style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal)),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: listActionProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardActionProfile extends StatelessWidget {
  final IconData iconAction;
  final String textAction;
  final Function()? onTapAction;

  const CardActionProfile({super.key, required this.iconAction, required this.textAction, required this.onTapAction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: onTapAction,
        child: Card(
          shadowColor: Colors.black12,
          elevation: 1,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Icon(iconAction, color: Colors.grey.withOpacity(0.5)),
                ),
                const SizedBox(width: 10),
                Text(textAction),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
