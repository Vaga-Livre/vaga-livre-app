import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class UserInfo with ChangeNotifier {
  TextEditingController nameController;
  TextEditingController dateController;
  TextEditingController phoneNumberController;

  UserInfo()
      : nameController = TextEditingController(text: ""),
        dateController = TextEditingController(text: ""),
        phoneNumberController = TextEditingController(text: "") {
    dateController.addListener(notifyListeners);
  }

  void changeUserInfo() async {
    final res = await Supabase.instance.client.auth.updateUser(
      UserAttributes(
        data: {
          "name": nameController.text,
          "phoneNumber": phoneNumberController.text,
          "birthDay": dateController.text,
          "finishedSignUp": true,
        },
      ),
    );

    res.user?.userMetadata;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu nome';
    }
    if (value.length < 3) {
      return 'O nome deve ter pelo menos 3 caracteres alfabéticos';
    }
    return null; // Retorna null se a validação for bem-sucedida
  }

  String? validatePhoneNumber(String? value) {
    final telefoneRegex =
        RegExp(r'^\([1-9]{2}\) (?:[2-8]|9[0-9])[0-9]{3}\-[0-9]{4}$');
    if (value == null || value.isEmpty) {
      return 'Por favor, insira um número de telefone';
    }
    if (!telefoneRegex.hasMatch(value)) {
      return 'Por favor, insira um número de telefone válido';
    }
    return null; // Retorna null se a validação for bem-sucedida
  }

  String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Selecione uma data de nascimento';
    }
    final selectedDate = DateTime.parse(value);
    final now = DateTime.now();
    final difference = now.difference(selectedDate);
    final age = difference.inDays ~/ 365;

    if (age < 18) {
      return 'Você deve ter pelo menos 18 anos para usar o aplicativo';
    }
    return null;
  }
}
