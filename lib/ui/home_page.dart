import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technical_test/ui/login_page.dart';
import 'package:technical_test/ui/profile_page.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>{

  List<String> tabText = [];
  List<BuildCardWellness> listCard = [
    const BuildCardWellness(imagesAssets: 'assets/indomaret.png', titleWellness: 'Voucher Digital Indomaret', priceWellness: 25000,),
    const BuildCardWellness(imagesAssets: 'assets/grab.png', titleWellness: 'Voucher Digital Indomaret', priceWellness: 25000,),
    const BuildCardWellness(imagesAssets: 'assets/excelso.jpg', titleWellness: 'Voucher Digital Indomaret', priceWellness: 25000,),
    const BuildCardWellness(imagesAssets: 'assets/alfamart.png', titleWellness: 'Voucher Digital Indomaret', priceWellness: 25000,),
    const BuildCardWellness(imagesAssets: 'assets/indomaret.png', titleWellness: 'Voucher Digital Indomaret', priceWellness: 25000,),
    const BuildCardWellness(imagesAssets: 'assets/indomaret.png', titleWellness: 'Voucher Digital Indomaret', priceWellness: 25000,),
  ];
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
    tabText = ['Payung Pribadi', 'Payung Karyawan'];
  }

  @override
  void dispose() {
    super.dispose();
    tabText.clear();
  }

  Future<bool> checkData() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString("email");
    final nama = prefs.getString("nama");

    if (email != null && email.isNotEmpty && nama != null && nama.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight + 80) / 4;
    final double itemWidth = size.width / 2;
    return Scaffold(
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfilePage()));
                }else{
                  // jika !isLogin
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage()));
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
                Container(
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
                            onTap: (){},
                            child: listCard[index],
                          );
                        }
                    ),
                  ),
                )
              ],
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

class BuildCardWellness extends StatelessWidget {
  final String imagesAssets;
  final String titleWellness;
  final int priceWellness;
  const BuildCardWellness({super.key, required this.imagesAssets, required this.titleWellness, required this.priceWellness});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Card(
        elevation: 0,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(imagesAssets, width: double.infinity, height: 80, fit: BoxFit.contain),
              const SizedBox(height: 10),
              Text("$titleWellness $priceWellness", style: const TextStyle(fontSize: 12),),
              const SizedBox(height: 10),
              Text("Rp. $priceWellness", style: const TextStyle(fontSize: 12),)
            ],
          ),
        ),
      ),
    );
  }
}