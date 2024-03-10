import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:vagalivre/config/extension.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    const spaceDefault = SizedBox.square(
      dimension: 16,
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: context.colorScheme.primary,
              height: 177,
              child: Image.asset('assets/images/darker_expanded.png'),
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
                      SupaSocialsAuth(
                        colored: true,
                        nativeGoogleAuthConfig: const NativeGoogleAuthConfig(
                          webClientId: 'YOUR_WEB_CLIENT_ID',
                          iosClientId: 'YOUR_WEB_CLIENT_ID',
                        ),
                        enableNativeAppleAuth: true,
                        socialProviders: const [
                          OAuthProvider.facebook,
                          OAuthProvider.google
                        ],
                        onSuccess: (session) {},
                      ),
                      spaceDefault
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              child: Text.rich(
                style: context.textTheme.bodyLarge,
                textAlign: TextAlign.center,
                const TextSpan(children: [
                  TextSpan(
                      text:
                          "Ao entrar no Vaga Livre, você concorda com os nossos "),
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
    );
  }
}
