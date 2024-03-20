import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:vagalivre/config/extension.dart';
import 'package:vagalivre/modules/auth/controller/user_info_controller.dart';

class RegisterUserInfoPage extends StatefulWidget {
  const RegisterUserInfoPage({super.key});

  @override
  State<RegisterUserInfoPage> createState() => _RegisterUserInfoPageState();
}

class _RegisterUserInfoPageState extends State<RegisterUserInfoPage> {
  final UserInfo userInfoController = UserInfo();
  final _formKey = GlobalKey<FormState>();

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
                height: 177,
                child: Image.asset('assets/images/darker_expanded.png'),
              ),
              spaceDefault,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Queremos saber um pouco mais sobre você",
                            style: context.textTheme.headlineSmall,
                          ),
                          const SizedBox.square(
                            dimension: 32,
                          ),
                          Text(
                            "Precisamos das seguintes informações para que possamos ajudar você a economizar tempo",
                            style: context.textTheme.bodyLarge,
                          ),
                          spaceDefault,
                          TextFormField(
                            controller: userInfoController.nameController,
                            decoration: InputDecoration(
                              label: const Text("Nome completo"),
                              prefixIcon: const Icon(Icons.person_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: userInfoController.validateName,
                          ),
                          spaceDefault,
                          TextFormField(
                            controller:
                                userInfoController.phoneNumberController,
                            decoration: InputDecoration(
                              label: const Text("Telefone"),
                              prefixIcon: const Icon(Icons.call_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter(),
                            ],
                            validator: userInfoController.validatePhoneNumber,
                          ),
                          spaceDefault,
                          ListenableBuilder(
                            listenable: userInfoController,
                            builder: (context, _) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color.fromARGB(
                                              255, 107, 106, 106)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ListTile(
                                      leading:
                                          const Icon(Icons.date_range_outlined),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 13, vertical: 3),
                                      title: const Text("Data de Nascimento"),
                                      trailing: Text(
                                        userInfoController
                                                .dateController.text.isNotEmpty
                                            ? DateFormat.yMMMMd('pt_Br').format(
                                                DateTime.parse(
                                                    userInfoController
                                                        .dateController.text))
                                            : 'Selecione uma data',
                                      ),
                                      leadingAndTrailingTextStyle:
                                          context.textTheme.labelLarge,
                                      onTap: () async {
                                        final dateTime = await showDatePicker(
                                          context: context,
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now(),
                                        );
                                        if (dateTime != null) {
                                          userInfoController
                                                  .dateController.text =
                                              dateTime.toIso8601String();
                                        }
                                      },
                                    ),
                                  ),
                                  if (userInfoController
                                          .dateController.text.isNotEmpty &&
                                      userInfoController.validateAge(
                                              userInfoController
                                                  .dateController.text) !=
                                          null)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, top: 8),
                                      child: Text(
                                        userInfoController.validateAge(
                                                userInfoController
                                                    .dateController.text) ??
                                            '',
                                        style: context.textTheme.bodySmall
                                            ?.copyWith(
                                                color:
                                                    context.colorScheme.error),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 32),
                          FilledButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                userInfoController.changeUserInfo();
                              }
                            },
                            child: const Text("Continuar"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
