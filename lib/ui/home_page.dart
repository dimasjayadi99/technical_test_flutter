import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:technical_test/bloc/list_willness_bloc.dart';
import 'package:technical_test/ui/detail_wellness.dart';
import 'package:technical_test/ui/login_page.dart';
import 'package:technical_test/ui/profile_page.dart';

import '../widget/card_wellness.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>{

  // BLoC
  ListWellnessBloc? wellnessBloc;

  List<String> tabText = [];
  List<BuildCardWellness> listCard = [];
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
    tabText = ['Payung Pribadi', 'Payung Karyawan'];
    wellnessBloc = ListWellnessBloc();
  }

  @override
  void dispose() {
    super.dispose();
    tabText.clear();
    wellnessBloc!.close();
  }

  Future<bool> checkData() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt("id");
    final email = prefs.getString("email");
    final isLogin = prefs.getBool("isLogin");

    if (id != null && email != null && email.isNotEmpty && isLogin != null && isLogin == true) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight + 80) / 4;
    final double itemWidth = size.width / 2;
    return BlocProvider(
      create: (context) => wellnessBloc!..getListWellness(),
      child: Scaffold(
        backgroundColor: const Color(0xffF8C20A),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xffF8C20A),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Selamat Pagi", style: TextStyle(color: Colors.white, fontSize: 12)),
              Text("Dimas Jayadi", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            const Icon(Icons.notifications_none, color: Colors.white),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () async {
                  // cek preference
                  // jika isLogin
                  bool isLoggedIn = await checkData();
                  if(isLoggedIn){
                    // navigasi ke halaman profile
                    if(context.mounted) {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfilePage()));
                    }
                  }else{
                    // jika !isLogin
                    if(context.mounted) {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage()));
                    }
                  }
                },
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: Container(
                        width: 40,
                        height: 40,
                      color: Colors.grey,
                      padding: const EdgeInsets.all(10),
                      child: const Center(child: Text("D", style: TextStyle(color: Colors.white, fontSize: 14),))
                    )
                ),
              ),
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // tab bar
                  Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: const BorderRadius.all(Radius.circular(100))
                      ),
                      child: Row(
                        children: List.generate(
                          tabText.length,
                              (index) => Expanded(
                            child: Container(
                              height: 32,
                              decoration: BoxDecoration(
                                color: currentTab == index
                                    ? const Color(0xffF8C20A)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    currentTab = index;
                                  });
                                },
                                child: Text(
                                  tabText[index],
                                  style: TextStyle(
                                    color: currentTab == index
                                        ? Colors.white
                                        : Colors.black.withOpacity(0.5),
                                    fontWeight: currentTab == index
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),

                  // Produk Keuangan
                  const Text("Produk Keuangan", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  // list menu kategori pilihan
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    crossAxisCount: 4,
                    children: [
                      _buildItem(Icons.people, "Urun", Colors.deepOrangeAccent),
                      _buildItem(Icons.mosque, "Pembiayaan\nPorsi Haji", Colors.green),
                      _buildItem(Icons.document_scanner_rounded, "Financial\nCheck Up", Colors.yellow),
                      _buildItem(Icons.car_crash, "Asuransi\nMobil", Colors.blueGrey),
                      _buildItem(Icons.house_rounded, "Asuransi\nProperti", Colors.brown),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Kategori Pilihan
                  Row(
                    children: [
                      const Text("Kategori Pilihan", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: const BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // Ensure the Row does not take more width than needed
                          children: [
                            const Text("Wishlist"),
                            const SizedBox(width: 5),
                            Container(
                              padding: const EdgeInsets.all(5), // Add some padding to the circle
                              decoration: const BoxDecoration(
                                color: Color(0xffF8C20A), // Yellow color
                                shape: BoxShape.circle, // Circular shape
                              ),
                              child: const Center(
                                child: Text(
                                  "2",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // list menu kategori pilihan
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    crossAxisCount: 4,
                    children: [
                      _buildItem(Icons.gamepad, "Hobi", Colors.blue),
                      _buildItem(Icons.card_giftcard, "Merchandise", Colors.lightBlue),
                      _buildItem(Icons.heart_broken, "Gaya Hidup\nSehat", Colors.red),
                      _buildItem(Icons.chat, "Konseling &\nRohani", Colors.lightBlueAccent),
                      _buildItem(Icons.self_improvement, "Self\nDevelopment", Colors.indigo),
                      _buildItem(Icons.credit_card, "Perencanaan\nKeuangan", Colors.greenAccent),
                      _buildItem(Icons.medical_information, "Konsultasi\nMedis", Colors.lightGreen),
                      _buildItem(Icons.category, "Lihat\nSemua", Colors.cyanAccent),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Explore Wellness
                  Row(
                    children: [
                      const Text("Explore Wellness", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 3, 0, 3),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: const BorderRadius.all(Radius.circular(100)),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min, // Ensure the Row does not take more width than needed
                          children: [
                            Text("Terpopuler"),
                            SizedBox(width: 5),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                    ],
                  ),
                  // list card explore wellness
                  BlocBuilder<ListWellnessBloc,ListWellnessInitState>(
                    buildWhen: (context, state) => state is ListWellnessLoadingState || state is ListWellnessSuccessState || state is ListWellnessFailedState,
                    builder: (context, state){
                      if(state is ListWellnessLoadingState){
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Shimmer.fromColors(
                            baseColor: Colors.black.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.1),
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: 6,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    color: Colors.grey[300],
                                  ),
                                  height: 100,
                                  width: double.infinity,
                                );
                              },
                            ),
                          ),
                        );
                      }
                      else if(state is ListWellnessSuccessState){
                        listCard = state.list;
                        return Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          child: GridView.count(
                            crossAxisCount: 2,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            childAspectRatio: (itemWidth / itemHeight),
                            children: List.generate(
                                listCard.length,
                                    (index){
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DetailWellnessPage(idWellness: listCard[index].wellnessModel.idWellness,)));
                                    },
                                    child: listCard[index],
                                  );
                                }
                            ),
                          ),
                        );
                      }
                      else if(state is ListWellnessFailedState){
                        return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  state.message,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            )
                        );
                      }
                      else{
                        return Container();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(IconData icon, String text, Color color) {
    return GestureDetector(
      onTap: (){},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          Text(text, style: const TextStyle(color: Colors.black, fontSize: 12), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}