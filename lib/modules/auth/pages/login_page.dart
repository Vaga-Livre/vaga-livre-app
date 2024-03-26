import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import '../../../config/extension.dart';

class LoginPage extends StatefulWidget {
  static const completedSignUpFlag = "finishedSignUp";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    const spaceDefault = SizedBox.square(
      dimension: 16,
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: context.colorScheme.primary,
                height: 127 + 50,
                child: Center(
                  child: Hero(
                    tag: "splash-image-login",
                    child: Image.asset(
                      'assets/images/darker_expanded.png',
                      height: 127,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              spaceDefault,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text.rich(
                          style: context.textTheme.headlineSmall,
                          const TextSpan(
                            children: [
                              TextSpan(text: "Encontre os\n"),
                              TextSpan(
                                text: "melhores estacionamentos\n",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: "perto do seu destino"),
                            ],
                          ),
                        ),
                        const SizedBox.square(
                          dimension: 32,
                        ),
                        Text(
                          "Entre agora e aproveite",
                          style: context.textTheme.bodyLarge,
                        )
                      ],
                    ),
                    spaceDefault,
                    Column(
                      children: [
                        // Create a Email sign-in/sign-up form
                        SupaEmailAuth(
                          onSignInComplete: (response) {
                            checkUserMetadataAndNavigate(response, context);
                          },
                          onSignUpComplete: (response) {
                            checkUserMetadataAndNavigate(response, context);
                          },
                        ),
                        spaceDefault
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                child: Text.rich(
                  style: context.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                  const TextSpan(children: [
                    TextSpan(text: "Ao entrar no Vaga Livre, você concorda com os nossos "),
                    TextSpan(
                      text: "Termos e Política de Privacidade",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkUserMetadataAndNavigate(AuthResponse response, BuildContext context) {
    Map<String, dynamic> currentUserMetadata = response.user!.appMetadata;
    if (currentUserMetadata[LoginPage.completedSignUpFlag] == false) {
      Navigator.pushReplacementNamed(context, 'PersonalInformation');
    } else {
      Navigator.pushReplacementNamed(context, '/');
    }
  }
}
