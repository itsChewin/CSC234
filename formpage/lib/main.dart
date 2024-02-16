import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Page',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Form Page'),
          backgroundColor: Colors.yellow,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        body: const MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  TextEditingController name = TextEditingController();
  TextEditingController studentid = TextEditingController();
  TextEditingController gmail = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late FocusNode myFocusNode;
  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                focusNode: myFocusNode,
                autofocus: true,
                controller: name,
                decoration: InputDecoration(labelText: "Name"),
                validator: (name) {
                  if (name == null || name.isEmpty) {
                    return 'Plese enter your name';
                  } else {
                    final isNumber = RegExp(r"(?=.*[a-z])(?=.*[A-Z]+)");
                    if (isNumber.hasMatch(name)) {
                      return null;
                    } else {
                      return "Must be both UPPERCASE and lowercase";
                    }
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                  controller: studentid,
                  decoration: InputDecoration(labelText: "Student ID"),
                  validator: (id) {
                    if (id == null || id.isEmpty) {
                      return 'Plese enter your student ID';
                    } else {
                      final isPassword = RegExp(r"([0-9])");
                      if (isPassword.hasMatch(id) && id.length == 11) {
                        return null;
                      } else {
                        return "Must be 11-digit ";
                      }
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                  controller: gmail,
                  decoration: InputDecoration(labelText: "email"),
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Plese enter your email';
                    } else {
                      final isPassword = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (isPassword.hasMatch(email)) {
                        return null;
                      } else {
                        return "Must be email format ";
                      }
                    }
                  }),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  onPressed: () {
                    bool validate = _formKey.currentState!.validate();
                    if (validate) {
                      print(
                          '---------- Name , Student ID and Gmail ----------');
                      print('Name : ' + name.text);
                      print('Student ID : ' + studentid.text);
                      print('Email : ' + gmail.text);

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              content: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                  "-------------------- Information --------------------" +
                                      '\n'),
                              Text("Name : " + name.text),
                              Text("Student ID : " + studentid.text),
                              Text("Email : " + gmail.text),
                            ],
                          ));
                        },
                      );
                      final snackBar = SnackBar(
                        content: const Text("Submitted!!!"),
                        action: SnackBarAction(
                          label: 'Clear form',
                          onPressed: () {
                            name.clear();
                            studentid.clear();
                            gmail.clear();
                            print('Clear form');
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text('Submit')),
            )
          ],
        ));
  }
}
