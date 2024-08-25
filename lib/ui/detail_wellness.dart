import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test/bloc/detail_wellness_bloc.dart';
import 'package:technical_test/widget/card_wellness.dart';

class DetailWellnessPage extends StatefulWidget {

  final int idWellness;

  const DetailWellnessPage({super.key, required this.idWellness});

  @override
  DetailWellnessPageState createState() => DetailWellnessPageState();
}

class DetailWellnessPageState extends State<DetailWellnessPage> {

  DetailWellnessBloc? detailWellnessBloc;
  BuildCardWellness? data;

  @override
  void initState() {
    super.initState();
    detailWellnessBloc = DetailWellnessBloc();
  }

  @override
  void dispose() {
    super.dispose();
    detailWellnessBloc!.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => detailWellnessBloc!..getDetailWellness(widget.idWellness),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: TextField(
            maxLines: 1,
            textInputAction: TextInputAction.search,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              hintText: 'Cari di sini...',
              hintStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
              contentPadding: const EdgeInsets.all(0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
            ),
            onChanged: (String value) {
              // Implement search functionality if needed
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<DetailWellnessBloc,DetailWellnessInitState>(
              buildWhen: (context, state) => state is DetailWellnessLoadingState || state is DetailWellnessSuccessState,
              builder: (context,state){
                if(state is DetailWellnessLoadingState){
                  return const Center(child: CircularProgressIndicator(),);
                }
                else if(state is DetailWellnessSuccessState){
                  data = state.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Image.asset(
                          data!.wellnessModel.imageWellness,
                          width: double.infinity,
                          height: 130,
                          fit: BoxFit.contain,
                        ),
                      ),

                      // Title and Price
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data!.wellnessModel.titleWellness,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Rp.${data!.wellnessModel.priceWellness.toString()}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.green,
                                  ),
                                ),
                                const Text(
                                  "Voucher Digital",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.share, color: Colors.black),
                            onPressed: () {
                              // Implement share functionality
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          Text("Min. Pembelian: 1"),
                          SizedBox(width: 20),
                          Text("Max. Pembelian: > 50"),
                        ],
                      ),

                      // Description
                      const SizedBox(height: 20),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                }
                else if(state is DetailWellnessFailedState){
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
                }else{
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}