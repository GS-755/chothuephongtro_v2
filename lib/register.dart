import 'package:flutter/material.dart';
import './model/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Register Now',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Enter your information',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
              
                    labelText: "FullName",
                     labelStyle: TextStyle(
                      color: Colors.blue, // Label color
                      fontSize: 16.0, // Label font size
                       // Label font weight
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ), 
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                     labelStyle: TextStyle(
                      color: Colors.blue, // Label color
                      fontSize: 16.0, // Label font size
                       // Label font weight
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Password",
                       labelStyle: TextStyle(
                      color: Colors.blue, // Label color
                      fontSize: 16.0, // Label font size
                       // Label font weight
                    ),
                      enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                    height:
                        20), // Add some space between the TextFormField and the button
                ElevatedButton(
                
                  onPressed: () {
                    // Add your onPressed code here!
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Border radius
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15), // Button padding
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white), // Text color
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Center the children horizontally
                    crossAxisAlignment: CrossAxisAlignment
                        .center, // Center the children vertically
                    children: [
                      Text(
                        'Already a member',
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(width: 4), // Add some space between the texts
                      Text(
                        'Login',
                        style: TextStyle(fontSize: 12, color: Colors.blue),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
