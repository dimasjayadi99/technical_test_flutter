import 'package:flutter/material.dart';
import 'package:technical_test/ui/home_page.dart';
import 'package:technical_test/ui/explorer_page.dart';
import 'package:technical_test/ui/keranjang_page.dart';
import 'package:technical_test/ui/transaksi_page.dart';
import 'package:technical_test/ui/voucher_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  BottomNavStates createState() => BottomNavStates();
}

class BottomNavStates extends State<BottomNav> {
  int selectedPage = 0;

  List<Widget> _pageOptions() {
    return [
      const HomePage(),
      const ExplorerPage(),
      const KeranjangPage(),
      const VoucherPage(),
      const TransaksiPage(),
    ];
  }

  void _navigateToPage(int pageIndex) {
    setState(() {
      selectedPage = pageIndex;
    });
    Navigator.pop(context);
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 50,
                mainAxisSpacing: 0,
                crossAxisCount: 3,
                children: [
                  _buildItem(Icons.dashboard, "Dashboard", 0),
                  _buildItem(Icons.search, "Explorer", 1),
                  _buildItem(Icons.shopping_cart, "Dashboard", 2),
                  _buildItem(Icons.card_giftcard, "Voucher", 3),
                  _buildItem(Icons.fact_check_rounded, "Transaksi", 4),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: _pageOptions()[selectedPage],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100))
            ),
            child: FloatingActionButton(
              onPressed: () {
                _showMoreOptions(context);
              },
              backgroundColor: Colors.white,
              elevation: 0,
              child: const Icon(Icons.keyboard_arrow_up, size: 40),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          elevation: 2,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.dashboard, size: 30),
                color: selectedPage == 0 ? const Color(0xffF8C20A) : const Color(0xffF8C20A).withOpacity(0.3),
                onPressed: () {
                  setState(() {
                    selectedPage = 0;
                  });
                },
              ),
              const SizedBox(width: 40),
              IconButton(
                icon: const Icon(Icons.person, size: 30),
                color: selectedPage == 1 ? const Color(0xffF8C20A) : const Color(0xffF8C20A).withOpacity(0.3),
                onPressed: () {
                  setState(() {
                    selectedPage = 1;
                  });
                },
              ),
              const SizedBox(width: 40),
              IconButton(
                icon: const Icon(Icons.shopping_cart, size: 30),
                color: selectedPage == 2 ? const Color(0xffF8C20A) : const Color(0xffF8C20A).withOpacity(0.3),
                onPressed: () {
                  setState(() {
                    selectedPage = 2;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(IconData icon, String text, int pageIndex) {
    return GestureDetector(
      onTap: (){
        _navigateToPage(pageIndex);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xffF8C20A), size: 28),
          Text(text, style: const TextStyle(color: Colors.black, fontSize: 12), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
