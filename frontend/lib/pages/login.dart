import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ydays/config/constants.dart';
import 'package:validators/validators.dart';
import '../utils/save_token.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  static String routeName = "/login";
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void register() async {
    final response = await Dio().post(
      '$apiURL/login',
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ),
      data: {
        'email': _emailController.text,
        'password': _passwordController.text,
      },
    );

    response.statusCode == 200
        // ignore: use_build_context_synchronously
        ? saveTokenToCache(context, response.data.token)
        : throw Exception(response.data.message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 16.0),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer votre adresse email';
                        }
                        if (!isEmail(value)) {
                          return 'Veuillez entrer une adresse email valide !';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      textInputAction: TextInputAction.go,
                      onFieldSubmitted: (value) {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                        }
                      },
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer votre mot de passe';
                        }
                        if (value.length < 6) {
                          return 'Veuillez entrer un mot de passe valide !';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pushNamed('/');
                        }
                      },
                      child: const Text('Connexion'),
                    ),
                    const SizedBox(height: 16.0),
                    const Text('Vous n\'avez pas de compte ?'),
                    const SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/register'),
                      child: const Text('Inscription'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
