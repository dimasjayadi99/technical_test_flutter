import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget{
  const EditProfilePage({super.key});

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage>{

  int currentStep = 0;
  List<Step> listStep() => [
    Step(
        label: Text("Biodata", style: TextStyle(color: currentStep >= 0 ? const Color(0xffF8C20A) : Colors.grey, fontSize: 12),),
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: Container(),
        content: const Center(child: Text("Biodata Diri")),
    ),
    Step(
        label: Text("Alamat", style: TextStyle(color: currentStep >= 1 ? const Color(0xffF8C20A) : Colors.grey, fontSize: 12),),
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: Container(),
        content: const Center(child: Text("Alamat Pribadi"))
    ),
    Step(
      label: Text("Informasi", style: TextStyle(color: currentStep >= 2 ? const Color(0xffF8C20A) : Colors.grey, fontSize: 12),),
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: Container(),
        content: const Center(child: Text("Informasi Perusahaan"))
    ),
  ];

  @override
  void initState() {
    super.initState();
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
        backgroundColor: Colors.transparent,
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
                onStepContinue: (){
                  if (currentStep < listStep().length - 1) {
                    setState(() {
                      currentStep += 1;
                    });
                  }
                },
                onStepTapped: (int index) {
                  setState(() {
                    currentStep = index;
                  });
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
                              backgroundColor: WidgetStateProperty.all(const Color(0xffF8C20A)), minimumSize: WidgetStateProperty.all(Size(MediaQuery.of(context).size.width, 50))
                          ),
                          onPressed: details.onStepContinue,
                          child: currentStep == listStep().length - 1
                              ? const Text('Kirim', style: TextStyle(color: Colors.white))
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