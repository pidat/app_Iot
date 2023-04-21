
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APP',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final user = FirebaseAuth.instance.currentUser;
  final userRef= FirebaseDatabase.instance.ref('iots');
  final dbref= FirebaseDatabase.instance.ref('tools');

//---------- Get Data From Firebase-----------------------
  int getTemp = 0;
  // const dataTemp;
  void getDataTemp(dataTemp){
  userRef.child('Temp').onValue.listen((event) {
      dataTemp = event.snapshot.value;
      setState(() {
      getTemp = dataTemp;
      });
});
}

  int getHumid = 0;
  // const dataTemp;
  void getDataHumid(dataHumid){
  userRef.child('Humid').onValue.listen((event) {
      dataHumid = event.snapshot.value;
      setState(() {
      getHumid=dataHumid;
      });
});
}

  int getInsen = 0;
  // const dataHumid;
  void getDataInsen(dataInsen){
    setState(() {
  userRef.child('Insen').onValue.listen((event) {
      dataInsen = event.snapshot.value;
      setState(() {
      getInsen= dataInsen;
      });
}); 
    });
}
// ----------Check Status------------------------

  bool valWater=false;
  updateDataWater(newValueWater){
   dbref.child('water').onValue.listen((event) {
    newValueWater = event.snapshot.value;
    setState(() {
    valWater = newValueWater;
    });
    });
}
  onChangeFunctionWater(newValueWater){
    setState(() {
      valWater = newValueWater;
    });
  }

  bool valDoor=false;
  updateDataDoor(newValueDoor){
   dbref.child('door').onValue.listen((event) {
    newValueDoor = event.snapshot.value;
    setState(() {
    valDoor = newValueDoor;
    });
    });
}
  onChangeFunctionDoor(newValueDoor){
    setState(() {
      valDoor = newValueDoor;
    });
  }

  bool valFan=false;
  updateDataFan(newValueFan){
   dbref.child('fan').onValue.listen((event) {
    newValueFan = event.snapshot.value;
    setState(() {
   valFan = newValueFan;
    });
    });
}
  onChangeFunctionFan(newValueFan){
    setState(() {
      valFan = newValueFan;
    });
  }
  bool valLight=false;
  updateDataLight(newValueLight){
   dbref.child('light').onValue.listen((event) {
    // newValueLight = event.snapshot.value;
    setState(() {
   valLight = newValueLight;
    });
    });
}
  onChangeFunctionLight(newValueLight){
    setState(() {
      valLight = newValueLight;
    });
  }

// --------------Program APP--------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'DAT DUY',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 135,
                    child: Icon(
                      Icons.bar_chart_rounded,
                      color: Colors.indigo,
                      size: 28,
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 32),
                    Center(
                      child: Image.asset(
                        'assets/images/1.jpg',
                        scale: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Center(
                      child: Text(
                        'Smart HenHouse',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    const Text(
                      'SERVICES',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _cardMenu(
                          icon: 'assets/images/temperature.png',
                          // title: 'TEMPERATURE',
                          title: '$getTemp',
                          color: const Color.fromARGB(255, 235, 54, 48),
                          fontColor: Colors.white, 
                        ),
                        _cardMenu(
                          icon: 'assets/images/water.png',
                          title: '$getHumid',
                          // number: '1',
                          color: const Color.fromARGB(255, 24, 127, 237),
                          fontColor: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _cardMenu(
                         icon: 'assets/images/energy.png',
                          // number:'1',
                          title:''
                        ),
                        _cardMenu(
                          icon: 'assets/images/water.png',
                          // number: '50''%',
                          title: ''
                        ),
                      ],
                    ),
                    customSwitchWater('ABC',valWater, onChangeFunctionWater),
                    customSwitchDoor('ABC',valDoor, onChangeFunctionDoor),
                    // const SizedBox(height: 18),

                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _cardMenu(
                          icon: 'assets/images/fan-1.png',
                          // number: '1',
                          title: ''
                        ),
                        _cardMenu(
                          icon: 'assets/images/lightbulb.png',
                          // number: '11',
                          // title: 'Light'
                           title: "$getInsen",
                          //  snapshot.data.value['Insen'].toString()
                        ),
                      ],
                    ),
                    customSwitchFan('ABC',valFan, onChangeFunctionFan),
                    customSwitchLight('ABC',valLight, onChangeFunctionLight),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardMenu({
    // required Map student,
    required String title,
    required String icon,
    Color color = Colors.white,
    Color fontColor = Colors.grey,
  }) {
    getDataHumid(getHumid);
    getDataTemp(getTemp);
    getDataInsen(getInsen);
    // builder: (context, snapshot);
    return GestureDetector(
      // onTap: onTap,
      child: Container(
        
        padding: const EdgeInsets.symmetric(
          vertical: 36,
        ),
        width: 130,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Image.asset(icon),
             const SizedBox(height: 10),
            
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: fontColor),
            )
          ],
        ), 
    ),
    );
  }
  Widget customSwitchWater(String text,bool val,Function onChangeMethod){
    updateDataWater(valWater);
    updateDataDoor(valDoor);
    updateDataFan(valFan);
    updateDataLight(valLight);
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,left:180),
    child: Row(children: [
      // Text(text,style: const TextStyle(
      //   fontSize: 20,
      //   fontFamily: 'Roboto',
      //   fontWeight: FontWeight.w600,
      //   color: Colors.black,
      // )),
      CupertinoSwitch(
        trackColor: Colors.grey,
        activeColor: Colors.blue,
        value: val, 
        onChanged: (newValueWater){
          writeDataWater();
          onChangeMethod(newValueWater);
        })
    ],),
    );
  }
  Future<void> writeDataWater ()async {
     dbref.update({'water': !valWater});
    }

  Widget customSwitchDoor(String text,bool val,Function onChangeMethod){
    return Padding(
      padding: const EdgeInsets.only(
        top: 0,left: 35),
    child: Row(children: [
      // Text(text,style: const TextStyle(
      //   fontSize: 20,
      //   fontFamily: 'Roboto',
      //   fontWeight: FontWeight.w600,
      //   color: Colors.black,
      // )),
      CupertinoSwitch(
        trackColor: Colors.grey,
        activeColor: Colors.green,
        value: val, 
        onChanged: (newValueDoor){
          writeDataDoor();
          onChangeMethod(newValueDoor);
        })
    ],),
    );
  }
  Future<void> writeDataDoor ()async {
      dbref.update({'door': !valDoor});
    }
  Widget customSwitchFan(String text,bool val,Function onChangeMethod){
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,left: 35),
    child: Row(children: [
      // Text(text,style: const TextStyle(
      //   fontSize: 20,
      //   fontFamily: 'Roboto',
      //   fontWeight: FontWeight.w600,
      //   color: Colors.black,
      // )),
      CupertinoSwitch(
        trackColor: Colors.grey,
        activeColor: Colors.green,
        value: val, 
        onChanged: (newValueFan){
          writeDataFan();
          onChangeMethod(newValueFan);
        })
    ],),
    );
  }
    Future<void> writeDataFan ()async {
      dbref.update({'fan': !  valFan});
    }

  Widget customSwitchLight(String text,bool val,Function onChangeMethod){
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,left: 180),
    child: Row(children: [
      // Text(text,style: const TextStyle(
      //   fontSize: 20,
      //   fontFamily: 'Roboto',
      //   fontWeight: FontWeight.w600,
      //   color: Colors.black,
      // )),
      CupertinoSwitch(
        trackColor: Colors.grey,
        activeColor: Colors.yellow.shade400,
        value: val, 
        onChanged: (newValueLight){
          writeDataLight();
          onChangeMethod(newValueLight);
        })
    ],),
    );
  }
 Future<void> writeDataLight ()async {
      dbref.update({'light': !valLight});
    }
}
