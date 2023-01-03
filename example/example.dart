
import 'package:flutter/material.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_appicon.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue,),
      home:  LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // This maintains validators and state of form fields
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //This manage state of modal progress widget
  bool _isLoading=false;

  //Function to make an api call and wait for response or result
  void loadStateForSeconds(){
    setState(() {_isLoading=true;});  // start the modal progress HUD

    // Simulate a service call
    Future.delayed(Duration(seconds: 2), () {
      //Show result
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Login successfully', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            Text('${emailController.text}', style: TextStyle(color: Colors.white),),
          ],
        ),
        backgroundColor: Colors.blue,
      ));

      setState(() {_isLoading=false;}); // dismiss the modal progress HUD

    });
  }

  @override
  Widget build(BuildContext context) {
    //wrap widget with OverlayLoaderWithAppIcon
    return OverlayLoaderWithAppIcon(
      isLoading: _isLoading,
      overlayBackgroundColor: Colors.black,
      circularProgressColor: Color(0xff670099),
      appIcon:  Image.asset('images/appIcon.png'),
      child: Scaffold(
        appBar: AppBar(title: Text("Overlay loader with app icon"),),
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: _buildColumn(),
          ),
        ),
      ),
    );
  }

  Column _buildColumn(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          key: ValueKey('email'),
          controller: emailController,
          textInputAction: TextInputAction.next,
          validator: (value) =>Validator.validateEmail(value!),
          decoration: InputDecoration(
              border: UnderlineInputBorder(),
              hintText: "Enter Email"
          ),
        ),

        SizedBox(height: 20,),
        TextFormField(
          key: ValueKey('password'),
          controller: passwordController,
          obscureText: true,
          validator: (value)=>Validator.validatePassword(value!),
          decoration: InputDecoration(
              border: UnderlineInputBorder(),
              hintText: "Enter Password"
          ),
        ),

        SizedBox(height: 20,),

        ElevatedButton(
            onPressed:(){
              if (_formKey.currentState!.validate()) {
                loadStateForSeconds();
              }
            },
            child: Text("Login"))
      ],
    );
  }

}

