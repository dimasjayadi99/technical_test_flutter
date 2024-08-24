import 'package:flutter/material.dart';
import 'package:technical_test/ui/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  List<CardActionProfile> listActionProfile = [];

  @override
  void initState() {
    super.initState();
    listActionProfile = [
      CardActionProfile(iconAction: Icons.person, textAction: 'Informasi Pribadi',onTapAction: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EditProfilePage()));
      }),
      CardActionProfile(iconAction: Icons.file_copy_rounded, textAction: 'Syarat & Ketentuan',onTapAction: (){}),
      CardActionProfile(iconAction: Icons.help, textAction: 'Bantuan',onTapAction: (){}),
      CardActionProfile(iconAction: Icons.safety_check, textAction: 'Kebijakan Privasi',onTapAction: (){}),
      CardActionProfile(iconAction: Icons.exit_to_app, textAction: 'Log Out',onTapAction: (){}),
      CardActionProfile(iconAction: Icons.delete, textAction: 'Hapus Akun',onTapAction: (){}),
    ];
  }

  @override
  void dispose() {
    listActionProfile.clear();
    super.dispose();
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
                      onTap: (){},
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
                                  child: const Icon(Icons.camera_alt, size: 14,))
                          )
        
                        ]
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Dimas Jayadi", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text("Masuk dengan Google", style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal)),
                      ],
                    )
                  ],
                ),
        
                const SizedBox(height: 20),
        
                // Use Column instead of ListView.builder
                Column(
                  children: listActionProfile,
                )
        
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
        onTap:onTapAction,
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
                  child: Icon(iconAction, color: Colors.grey.withOpacity(0.5),),
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
