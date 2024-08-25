import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:technical_test/database/database_helper.dart';
import 'package:technical_test/utils/drop_down.dart';
import 'package:technical_test/utils/custom_textfiled.dart';

import '../utils/date_picker.dart';

class EditProfilePage extends StatefulWidget{

  final Map<String,dynamic>? data;

  const EditProfilePage({super.key, required this.data});

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage>{

  // Form Key
  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey3 = GlobalKey<FormState>();

  // Controller
  // step 1
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _lahirController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pendidikanController = TextEditingController();
  final TextEditingController _pernikahanController = TextEditingController();

  // step 2
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _provinsiController = TextEditingController();
  final TextEditingController _provinsiDomisiliController = TextEditingController();
  final TextEditingController _kabupatenController = TextEditingController();
  final TextEditingController _kabupatenDomisiliController = TextEditingController();
  final TextEditingController _kecamatanController = TextEditingController();
  final TextEditingController _kecamatanDomisiliController = TextEditingController();
  final TextEditingController _kelurahanController = TextEditingController();
  final TextEditingController _kelurahanDomisiliController = TextEditingController();
  final TextEditingController _kodePosController = TextEditingController();
  final TextEditingController _alamatDomisiliController = TextEditingController();

  // step 3
  final TextEditingController _namaUsahaController = TextEditingController();
  final TextEditingController _alamatUsahaController = TextEditingController();
  final TextEditingController _jabatanController = TextEditingController();
  final TextEditingController _sumberPendapatanController = TextEditingController();
  final TextEditingController _totalPendapatanController = TextEditingController();
  final TextEditingController _namaBankController = TextEditingController();
  final TextEditingController _cabangBankController = TextEditingController();
  final TextEditingController _rekeningController = TextEditingController();
  final TextEditingController _namaPemilikController = TextEditingController();


  bool checkedValue = true;
  File? images;
  String imagePath = "";
  DateTime? selectedDate;
  String formatDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year}";
  }
  Map<String,dynamic>? dataUser = {};

  // provinsi
  String? selectedProvinsi;
  String? selectedProvinsiDomisili;
  List<String> listProvinsiName = [
    "Aceh",
    "Bali",
    "Bangka Belitung",
    "Banten",
    "Bengkulu",
    "Gorontalo",
    "Jakarta",
    "Jambi",
    "Jawa Barat",
    "Jawa Tengah",
    "Jawa Timur",
    "Kalimantan Barat",
    "Kalimantan Tengah",
    "Kalimantan Timur",
    "Kalimantan Selatan",
    "Kalimantan Utara",
    "Kepulauan Riau",
    "Lampung",
    "Maluku",
    "Maluku Utara",
    "Nusa Tenggara Barat",
    "Nusa Tenggara Timur",
    "Papua",
    "Papua Barat",
    "Riau",
    "Sulawesi Barat",
    "Sulawesi Selatan",
    "Sulawesi Tengah",
    "Sulawesi Tenggara",
    "Sulawesi Utara",
    "Sumatera Barat",
    "Sumatera Selatan",
    "Sumatera Utara",
    "Yogyakarta"
  ];

  String? selectedKabupaten;
  String? selectedKabupatenDomisili;
  List<String> listKabupatenName = [
    "Aceh",
    "Bali",
    "Bangka Belitung",
    "Banten",
    "Bengkulu",
    "Gorontalo",
    "Jakarta",
    "Jambi",
    "Jawa Barat",
    "Jawa Tengah",
    "Jawa Timur",
  ];

  String? selectedKecamatan;
  String? selectedKecamatanDomisili;
  List<String> listKecamatannName = [
    "Aceh",
    "Bali",
    "Bangka Belitung",
    "Banten",
    "Bengkulu",
    "Gorontalo",
    "Jakarta",
    "Jambi",
    "Jawa Barat",
    "Jawa Tengah",
    "Jawa Timur",
  ];

  String? selectedKelurahan;
  String? selectedKelurahanDomisili;
  List<String> listKelurahanName = [
    "Aceh",
    "Bali",
    "Bangka Belitung",
    "Banten",
    "Bengkulu",
    "Gorontalo",
    "Jakarta",
    "Jambi",
    "Jawa Barat",
    "Jawa Tengah",
    "Jawa Timur",
  ];

  String? selectedGender;
  List<String> listGender = [
    "Laki-laki",
    "Perempuan",
  ];

  String? selectedPendidikan;
  List<String> listPendidikan = [
    "SD",
    "SMP",
    "SMA",
    "D1",
    "D2",
    "D3",
    "S1",
    "S2",
    "S3",
  ];

  String? selectedPernikahan;
  List<String> listPernikahan = [
    "Sudah Menikah",
    "Belum Menikah",
    "Janda",
    "Duda",
  ];

  String? selectedJabatan;
  List<String> listJabatan = [
    "Non-Staff",
    "Staff",
    "Supervisor",
    "Manajer",
    "Direktur",
    "Lainnya",
  ];

  String? selectedLamaKerja;
  final TextEditingController _lamaKerjaController = TextEditingController();
  List<String> listLamaKerja = [
    "< 6 Bulan",
    "6 Bulan - 1 Tahun",
    "1 - 2 Tahun",
    "> 2 Tahun",
  ];

  String? selectedSumberPendapatan;
  List<String> listSumberPendapatan = [
    "Gaji",
    "Keuntungan Bisnis",
    "Bunga Tabungan",
    "Warisan",
    "Dana dari orang tua atau anak",
    "Undian",
    "Keuntungan Investasi",
    "Lainnya",
  ];

  String? selectedTotalPendapatan;
  List<String> listTotalPendapatan = [
    "< 10 Juta",
    "10 - 50 Juta",
    "50 - 100 Juta",
    "100 - 500 Juta",
    "500 - 1 Milyar",
    "> 1 Milyar",
  ];

  String? selectedNamaBank;
  List<String> listNamaBank = [
    "Bank BCA",
    "Bank BRI",
    "Bank Mandiri",
    "Bank BTN",
    "Bank DKI",
    "Bank BJB",
    "Bank Danamon",
  ];

  Future imagePickerFromGallery() async{
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    try{
      if(image == null){
        return;
      }
      final tempImage = File(image.path);
      setState(() {
        images = tempImage;
        imagePath = images!.path;
      });

    }on PlatformException catch(e){
      throw Exception(e);
    }
  }

  Future imagePickerFromCamera() async{
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    try{
      if(image == null){
        return;
      }
      final tempImage = File(image.path);
      setState(() {
        images = tempImage;
        imagePath = images!.path;
      });

    }on PlatformException catch(e){
      return e;
    }
  }

  int currentStep = 0;
  List<Step> listStep() => [
    Step(
        label: Text("Biodata", style: TextStyle(color: currentStep >= 0 ? const Color(0xffF8C20A) : Colors.grey, fontSize: 12),),
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: Container(),
        content: Form(
          key: formKey1,
          child: Column(
            children: [
              // Nama Lengkap
              CustomTextField(
                  controller: _namaController,
                  text: "Nama Lengkap *",
                  readOnly: false,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.person),
                  isRequired: true,
                  enable: true,
              ),
              // Tanggal Lahir
              CustomTextField(
                  controller: _lahirController,
                  text: "Tanggal Lahir *",
                  readOnly: true,
                  textInputType: TextInputType.datetime,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.date_range),
                  suffixWidget: const Icon(Icons.arrow_drop_down),
                  isRequired: true,
                  enable: true,
                  onTap: (){
                    dateDialog(
                      context,
                      selectedDate,
                          (DateTime newDate) {
                        setState(() {
                          selectedDate = newDate;
                          _lahirController.text = formatDate(selectedDate!);
                        });
                      },
                    );
                  },
              ),
              DropDownUtils(
                title: "Jenis Kelamin*",
                hintText: "Jenis Kelamin",
                selectedValue: selectedGender,
                controller: _genderController,
                items: listGender.toSet().toList(),
                onChanged: (String? value){
                  setState(() {
                    selectedGender = value!;
                    _genderController.text = value;
                  });
                },
                isRequired: true,
              ),
              CustomTextField(
                  controller: _emailController,
                  text: "Alamat Email *",
                  readOnly: true,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.email),
                  isRequired: true,
                  enable: false,
              ),
              CustomTextField(
                controller: _phoneController,
                text: "No HP *",
                readOnly: false,
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(Icons.phone_android),
                isRequired: true,
                enable: true,
              ),
              DropDownUtils(
                title: "Status Pendidikan*",
                hintText: "Status Pendidikan",
                selectedValue: selectedPendidikan,
                controller: _pendidikanController,
                items: listPendidikan.toSet().toList(),
                onChanged: (String? value){
                  setState(() {
                    selectedPendidikan = value!;
                  });
                },
                isRequired: true,
              ),
              DropDownUtils(
                title: "Status Pernikahan*",
                hintText: "Status Pernikahan",
                selectedValue: selectedPernikahan,
                controller: _pernikahanController,
                items: listPernikahan.toSet().toList(),
                onChanged: (String? value){
                  setState(() {
                    selectedPernikahan = value!;
                  });
                },
                isRequired: true,
              ),
            ],
          ),
        ),
    ),
    Step(
        label: Text("Alamat", style: TextStyle(color: currentStep >= 1 ? const Color(0xffF8C20A) : Colors.grey, fontSize: 12),),
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: Container(),
        content: Form(
          key: formKey2,
          child: Column(
            children: [
              GestureDetector(
                onTap:(){},
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xffF8C20A).withOpacity(0.1),
                        borderRadius: const BorderRadius.all(Radius.circular(10))
                      ),
                      child: const Icon(Icons.credit_card_rounded,color: Color(0xffF8C20A),),
                    ),

                    const SizedBox(width: 10),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: (){
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          leading: const Icon(Icons.photo_library),
                                          title: const Text('Ambil dari Gallery'),
                                          onTap: () {
                                            imagePickerFromGallery();
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          leading: const Icon(Icons.camera),
                                          title: const Text('Ambil dari kamera'),
                                          onTap: () {
                                            imagePickerFromCamera();
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Text("Upload KTP (JPG, PNG)")),

                        imagePath != "" ?
                        Row(
                          children: [
                            Text("File Dilengkapi", style: TextStyle(color: Colors.black.withOpacity(0.5)),),
                            const SizedBox(width: 10),
                            GestureDetector(
                                onTap: (){
                                  setState(() {
                                    imagePath = "";
                                  });
                                },
                                child: const Text("Hapus",style: TextStyle(color: Colors.blue),)),
                          ],
                        ) : Container()
                      ],
                    ),
                    
                    const Spacer(),

                    imagePath != "" ? const Icon(Icons.check_circle,color: Colors.green,) : Container()
                  ],
                ),
              ),

              const SizedBox(height: 10),

              CustomTextField(
                text: "NIK *",
                readOnly: false,
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(Icons.credit_card_sharp),
                isRequired: true,
                enable: true,
                controller: _nikController,
              ),

              CustomTextField(
                text: "Alamat Sesuai KTP *",
                readOnly: false,
                textInputType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                prefixIcon: const Icon(Icons.location_on),
                isRequired: true,
                enable: true,
                controller: _alamatController,
              ),
              DropDownUtils(
                title: "Provinsi*",
                hintText: "Provinsi",
                selectedValue: selectedProvinsi,
                controller: _provinsiController,
                items: listProvinsiName.toSet().toList(),
                onChanged: (String? value){
                  setState(() {
                    selectedProvinsi = value!;
                  });
                },
                isRequired: true,
              ),
              DropDownUtils(
                title: "Kabupaten *",
                hintText: "Kabupaten",
                selectedValue: selectedKabupaten,
                controller: _kabupatenController,
                items: listKabupatenName.toSet().toList(),
                onChanged: (String? value){
                  setState(() {
                    selectedKabupaten = value!;
                  });
                },
                isRequired: true,
              ),
              DropDownUtils(
                title: "Kecamatan *",
                hintText: "Kecamatan",
                selectedValue: selectedKecamatan,
                controller: _kecamatanController,
                items: listKecamatannName.toSet().toList(),
                onChanged: (String? value){
                  setState(() {
                    selectedKecamatan = value!;
                  });
                },
                isRequired: true,
              ),
              DropDownUtils(
                title: "Kelurahan *",
                hintText: "Kelurahan",
                selectedValue: selectedKelurahan,
                controller: _kelurahanController,
                items: listKelurahanName.toSet().toList(),
                onChanged: (String? value){
                  setState(() {
                    selectedKelurahan = value!;
                  });
                },
                isRequired: true,
              ),
              CustomTextField(
                text: "Kode Pos *",
                readOnly: false,
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(Icons.numbers_rounded),
                isRequired: true,
                enable: true,
                controller: _kodePosController,
              ),

              CheckboxListTile(
                title: const Text("Alamat domisili sama dengan alamat KTP"),
                value: checkedValue,
                onChanged: (newValue) {
                  setState(() {
                    checkedValue = newValue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
              ),

              if(!checkedValue)...[
                Column(
                  children: [
                    CustomTextField(
                      text: "Alamat Domisili *",
                      readOnly: false,
                      textInputType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      prefixIcon: const Icon(Icons.location_city),
                      isRequired: true,
                      enable: true,
                      controller: _alamatDomisiliController,
                    ),
                    DropDownUtils(
                      title: "Provinsi*",
                      hintText: "Provinsi",
                      selectedValue: selectedProvinsiDomisili,
                      controller: _provinsiDomisiliController,
                      items: listProvinsiName.toSet().toList(),
                      onChanged: (String? value){
                        setState(() {
                          selectedProvinsiDomisili = value!;
                        });
                      },
                      isRequired: true,
                    ),
                    DropDownUtils(
                      title: "Kabupaten *",
                      hintText: "Kabupaten",
                      selectedValue: selectedKabupatenDomisili,
                      controller: _kabupatenDomisiliController,
                      items: listKabupatenName.toSet().toList(),
                      onChanged: (String? value){
                        setState(() {
                          selectedKabupatenDomisili = value!;
                        });
                      },
                      isRequired: true,
                    ),
                    DropDownUtils(
                      title: "Kecamatan *",
                      hintText: "Kecamatan",
                      selectedValue: selectedKecamatanDomisili,
                      controller: _kecamatanDomisiliController,
                      items: listKecamatannName.toSet().toList(),
                      onChanged: (String? value){
                        setState(() {
                          selectedKecamatanDomisili = value!;
                        });
                      },
                      isRequired: true,
                    ),
                    DropDownUtils(
                      title: "Kelurahan *",
                      hintText: "Kelurahan",
                      selectedValue: selectedKelurahanDomisili,
                      controller: _kelurahanDomisiliController,
                      items: listKelurahanName.toSet().toList(),
                      onChanged: (String? value){
                        setState(() {
                          selectedKelurahanDomisili = value!;
                        });
                      },
                      isRequired: true,
                    ),
                  ],
                )
              ]
            ],
          ),
        )
    ),
    Step(
      label: Text(
        "Perusahaan",
        style: TextStyle(
          color: currentStep >= 2 ? const Color(0xffF8C20A) : Colors.grey,
          fontSize: 12,
        ),
      ),
      state: currentStep > 2 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 2,
      title: Container(),
      content: Form(
        key: formKey3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              text: "Nama Usaha / Perusahaan",
              readOnly: false,
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.business),
              isRequired: false,
              enable: true,
              controller: _namaUsahaController,
            ),
            CustomTextField(
              text: "Alamat Usaha / Perusahaan",
              readOnly: false,
              textInputType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              prefixIcon: const Icon(Icons.location_city),
              isRequired: false,
              enable: true,
              controller: _alamatUsahaController,
            ),
            DropDownUtils(
              title: "Jabatan",
              hintText: "Jabatan",
              selectedValue: selectedJabatan,
              controller: _jabatanController,
              items: listJabatan.toSet().toList(),
              onChanged: (String? value){
                setState(() {
                  selectedJabatan = value!;
                });
              },
              isRequired: false,
            ),
            DropDownUtils(
              title: "Lama Bekerja",
              hintText: "Lama Bekerja",
              selectedValue: selectedLamaKerja,
              controller: _lamaKerjaController,
              items: listLamaKerja.toSet().toList(),
              onChanged: (String? value){
                setState(() {
                  selectedLamaKerja = value!;
                });
              },
              isRequired: false,
            ),
            DropDownUtils(
              title: "Sumber Pendapatan",
              hintText: "Sumber Pendapatan",
              selectedValue: selectedSumberPendapatan,
              controller: _sumberPendapatanController,
              items: listSumberPendapatan.toSet().toList(),
              onChanged: (String? value){
                setState(() {
                  selectedSumberPendapatan = value!;
                });
              },
              isRequired: false,
            ),
            DropDownUtils(
              title: "Pendapatan Kotor Pertahun",
              hintText: "Pendapatan Kotor Pertahun",
              selectedValue: selectedTotalPendapatan,
              controller: _totalPendapatanController,
              items: listTotalPendapatan.toSet().toList(),
              onChanged: (String? value){
                setState(() {
                  selectedTotalPendapatan = value!;
                });
              },
              isRequired: false,
            ),
            DropDownUtils(
              title: "Nama Bank",
              hintText: "Nama Bank",
              selectedValue: selectedNamaBank,
              controller: _namaBankController,
              items: listNamaBank.toSet().toList(),
              onChanged: (String? value){
                setState(() {
                  selectedNamaBank = value!;
                });
              },
              isRequired: false,
            ),
            CustomTextField(
              text: "Cabang Bank",
              readOnly: false,
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.business_center),
              isRequired: false,
              enable: true,
              controller: _cabangBankController,
            ),
            CustomTextField(
              text: "Nomor Rekening",
              readOnly: false,
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.credit_card),
              isRequired: false,
              enable: true,
              controller: _rekeningController,
            ),
            CustomTextField(
              text: "Nama Pemilik Rekening",
              readOnly: false,
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(Icons.person),
              isRequired: false,
              enable: true,
              controller: _namaPemilikController,
            ),
          ],
        ),
      ),
    )
  ];

  @override
  void initState() {
    super.initState();
    dataUser = widget.data;
    if(dataUser!=null) {
      _namaController.text = dataUser!["nama"] ?? "";
      _lahirController.text = dataUser!["lahir"] ?? "";
      selectedGender = dataUser!["gender"] ?? "";
      _emailController.text = dataUser!["email"] ?? "";
      _phoneController.text = dataUser!["phone"] ?? "";
      selectedPendidikan = dataUser!["pendidikan"] ?? "";
      selectedPernikahan = dataUser!["pernikahan"] ?? "";
      _nikController.text = dataUser!["nik"] ?? "";
      _alamatController.text = dataUser!["alamat"] ?? "";
      selectedProvinsi = dataUser!["provinsi"] ?? "";
      selectedKabupaten = dataUser!["kabupaten"] ?? "";
      selectedKecamatan = dataUser!["kecamatan"] ?? "";
      selectedKelurahan = dataUser!["kelurahan"] ?? "";
      _kodePosController.text = dataUser!["kode"] ?? "";
      _alamatDomisiliController.text = dataUser!["alamat_dom"] ?? "";
      selectedProvinsiDomisili = dataUser!["provinsi_dom"] ?? "";
      selectedKabupatenDomisili = dataUser!["kabupaten_dom"] ?? "";
      selectedKecamatanDomisili = dataUser!["kecamatan_dom"] ?? "";
      selectedKelurahanDomisili = dataUser!["kelurahan_dom"] ?? "";
      _namaUsahaController.text = dataUser!["nama_perusahaan"] ?? "";
      _alamatUsahaController.text = dataUser!["alamat_perusahaan"] ?? "";
      selectedJabatan = dataUser!["jabatan"] ?? "";
      selectedLamaKerja = dataUser!["lama_kerja"] ?? "";
      selectedSumberPendapatan = dataUser!["sumber_pendapatan"] ?? "";
      selectedTotalPendapatan = dataUser!["total_pendapatan"] ?? "";
      selectedNamaBank = dataUser!["nama_bank"] ?? "";
      _cabangBankController.text = dataUser!["cabang_bank"] ?? "";
      _rekeningController.text = dataUser!["rekening"] ?? "";
      _namaPemilikController.text = dataUser!["pemilik"] ?? "";
    }
  }

  Future<void> updateData() async {
    final dbHelper = DatabaseHelper();
    final data = {
      'email': _emailController.text,
      'nama': _namaController.text,
      'password': dataUser!["password"],
      'lahir': _lahirController.text,
      'gender': selectedGender,
      'phone': _phoneController.text,
      'pendidikan': selectedPendidikan,
      'pernikahan': selectedPernikahan,
      'nik': _nikController.text,
      'alamat': _alamatController.text,
      'provinsi': selectedProvinsi,
      'kabupaten': selectedKabupaten,
      'kecamatan': selectedKecamatan,
      'kelurahan': selectedKelurahan,
      'kode': _kodePosController.text,
      'is_alamat_sama': 0,
      'alamat_dom': _alamatDomisiliController.text,
      'provinsi_dom': selectedProvinsiDomisili,
      'kabupaten_dom': selectedKabupatenDomisili,
      'kecamatan_dom': selectedKecamatanDomisili,
      'kelurahan_dom': selectedKelurahanDomisili,
      'nama_perusahaan': _namaUsahaController.text,
      'alamat_perusahaan': _alamatUsahaController.text,
      'jabatan': selectedJabatan,
      'lama_kerja': selectedLamaKerja,
      'sumber_pendapatan': selectedSumberPendapatan,
      'total_pendapatan': selectedTotalPendapatan,
      'nama_bank': selectedNamaBank,
      'cabang_bank': _cabangBankController.text,
      'rekening': _rekeningController.text,
      'pemilik': _namaPemilikController.text,
    };

    if (dataUser != null && dataUser!["id"] != null) {
      await dbHelper.updateUser(dataUser!["id"], data);
    }
  }


  @override
  void dispose() {
    listStep().clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Informasi Pribadi"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Theme(
            data: ThemeData(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xffF8C20A),
                )
            ),
            child: Stepper(
                elevation: 0.5,
                type: StepperType.horizontal,
                steps: listStep(),
                currentStep: currentStep,
                onStepCancel: (){
                  currentStep == 0 ? null :
                      setState(() {
                        currentStep -= 1;
                      });
                },
                onStepContinue: () async {
                  final isLast = currentStep == listStep().length - 1;
                  if (currentStep == 0 || currentStep == 1) {
                    if (currentStep == 0 && formKey1.currentState != null && formKey1.currentState!.validate()) {
                      setState(() {
                        currentStep += 1;
                      });
                    } else if (currentStep == 1 && formKey2.currentState != null && formKey2.currentState!.validate()) {
                      setState(() {
                        currentStep += 1;
                      });
                    }
                  }else if(isLast){
                    if (formKey3.currentState != null && formKey3.currentState!.validate()) {
                      if (currentStep < listStep().length - 1) {
                        setState(() {
                          currentStep += 1;
                        });
                      } else {
                        if (formKey1.currentState!.validate() && formKey2.currentState!.validate() && formKey3.currentState!.validate()) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                          await Future.delayed(const Duration(seconds: 1));

                          await updateData();

                          if (!mounted) return;

                          if (context.mounted) {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          }
                        }
                      }
                    }
                  }
                },
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      if (currentStep != 0)
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                backgroundColor: WidgetStateProperty.all(Colors.grey), minimumSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.width, 50))
                            ),
                            onPressed: details.onStepCancel,
                            child: const Text('Kembali', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      if (currentStep != 0)
                        const SizedBox(
                          width: 20,
                        ),
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              backgroundColor: WidgetStateProperty.all(const Color(0xffF8C20A)), minimumSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.width, 50))
                          ),
                          onPressed: details.onStepContinue,
                          child: currentStep == listStep().length - 1
                              ? const Text('Simpan', style: TextStyle(color: Colors.white))
                              : const Text('Selanjutnya', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
      ),
    );
  }

}