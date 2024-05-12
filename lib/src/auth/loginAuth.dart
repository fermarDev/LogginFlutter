
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logginapp/src/providers/menu_provider.dart';

class LoginAuth extends StatefulWidget {

  const LoginAuth({super.key});

   @override
  _MyFormWidgetState createState() => _MyFormWidgetState();
}


class _MyFormWidgetState extends State<LoginAuth> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();
  String password = '';
  String user = '';

  @override
  void dispose() {
    // Es importante limpiar el controlador cuando el widget se destruye.
    _controller.dispose();
    _controllerPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 120),
            width: 250,
            child:  const Image(
              image: AssetImage('assets/images/logo.png'),
              repeat: ImageRepeat.noRepeat,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
             child:  const Text(
              'Login',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30),
            child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _controller,
                  onChanged: (value) => user = value,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'User name',

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _controllerPass,
                  onChanged: (value) => password = value 
                  ,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Enter your password',
                    labelText: 'Password',
                  ),
                ),
              ),
            ],
          ),
           
          ),
          Container(
            width: 150,
            margin: const EdgeInsets.only(top: 30),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 67, 136, 255)),
              ),
              child: const Text(
                'Access',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              onPressed: () {
                menuProvider.cargaData(_controller.text, _controllerPass.text).then((value) => {
                    if (!value ) {
                      Fluttertoast.showToast(
                        msg: "Credenciales invalidas",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      )
                    } else {
                       Fluttertoast.showToast(
                        msg: "Credenciales correctas",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 2,
                        backgroundColor: const Color.fromARGB(255, 119, 233, 144),
                        textColor: Colors.white,
                        fontSize: 16.0,
                      )

                    }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

