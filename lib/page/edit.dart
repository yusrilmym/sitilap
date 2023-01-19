// ignore_for_file: unused_field, prefer_const_constructors, avoid_print, use_key_in_widget_constructors, must_be_immutable, unused_element, unused_local_variable, avoid_unnecessary_containers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Edit extends StatefulWidget {
  Edit({@required this.id});

  String id;

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _formKey = GlobalKey<FormState>();

  //inprocessoralize field
  var nomer_komp = TextEditingController();
  var processor = TextEditingController();
  var ram = TextEditingController();
  var hdd = TextEditingController();
  var vga = TextEditingController();
  var psu = TextEditingController();
  var pengadaan = TextEditingController();
  var pic = TextEditingController();
  var maintenance = TextEditingController();
  var tgl_pasang = TextEditingController();

  @override
  void initState() {
    super.initState();
    //in first time, this method will be executed
    _getData();
  }

  //Http to get detail data
  Future _getData() async {
    try {
      final response = await http.get(Uri.parse(
          //you have to take the ip address of your computer.
          //because using localhost will cause an error
          //get detail data with id
          "https://api-sitilap.itrsudcibinong.com/detail.php?id='${widget.id}'"));

      // if response successful
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        setState(() {
          nomer_komp = TextEditingController(text: data['nomer_komp']);
          processor = TextEditingController(text: data['processor']);
          ram = TextEditingController(text: data['ram']);
          hdd = TextEditingController(text: data['hdd']);
          vga = TextEditingController(text: data['vga']);
          psu = TextEditingController(text: data['psu']);
          pengadaan = TextEditingController(text: data['pengadaan']);
          pic = TextEditingController(text: data['pic']);
          maintenance = TextEditingController(text: data['maintenance']);
          tgl_pasang = TextEditingController(text: data['tgl_pasang']);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _onUpdate(context) async {
    try {
      return await http.post(
        Uri.parse("https://api-sitilap.itrsudcibinong.com/update.php"),
        body: {
          "id": widget.id,
          "nomer_komp": nomer_komp.text,
          "processor": processor.text,
          "ram": ram.text,
          "hdd": hdd.text,
          "vga": vga.text,
          "psu": psu.text,
          "pengadaan": pengadaan.text,
          "pic": pic.text,
          "maintenance": maintenance.text,
          "tgl_pasang": tgl_pasang.text,
        },
      ).then((value) {
        //print message after insert to database
        //you can improve this message with alert dialog
        var data = jsonDecode(value.body);
        print(data["message"]);

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/qr', (Route<dynamic> route) => false);
      });
    } catch (e) {
      print(e);
    }
  }

  Future _onDelete(context) async {
    try {
      return await http.post(
        Uri.parse("https://api-sitilap.itrsudcibinong.com/delete.php"),
        body: {
          "id": widget.id,
        },
      ).then((value) {
        //print message after insert to database
        //you can improve this message with alert dialog
        var data = jsonDecode(value.body);
        print(data["message"]);

        // Remove all existing routes until the home.dart, then rebuild Home.
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/tes', (Route<dynamic> route) => false);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input processoran"),
        backgroundColor: Colors.green,
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      //show dialog to confirm delete data
                      return AlertDialog(
                        content: Text('Are you sure you want to delete this?'),
                        actions: <Widget>[
                          ElevatedButton(
                            child: Icon(Icons.cancel),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          ElevatedButton(
                            child: Icon(Icons.check_circle),
                            onPressed: () => _onDelete(context),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.delete)),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'processor',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: processor,
                  decoration: InputDecoration(
                      hintText: "processor",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'ram',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: ram,
                  decoration: InputDecoration(
                      hintText: "ram",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'hdd',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: hdd,
                  decoration: InputDecoration(
                      hintText: "hdd",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'vga',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: vga,
                  decoration: InputDecoration(
                      hintText: "vga",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'psu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: psu,
                  decoration: InputDecoration(
                      hintText: "psu",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'pengadaan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: pengadaan,
                  decoration: InputDecoration(
                      hintText: "pengadaan",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'pic',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: pic,
                  decoration: InputDecoration(
                      hintText: "pic",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'maintenance',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: maintenance,
                  decoration: InputDecoration(
                      hintText: "maintenance",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'tgl_pasang',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: tgl_pasang,
                  decoration: InputDecoration(
                    labelText: "Tanggal Bulan",
                    hintText: "input Tanggal Bulan",
                  ),
                  onTap: () async {
                    DateTime date = DateTime(1900);
                    FocusScope.of(context).requestFocus(new FocusNode());
                    date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));

                    tgl_pasang.text = date.toIso8601String();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    //validate
                    if (_formKey.currentState.validate()) {
                      //send data to database with this method
                      _onUpdate(context);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
