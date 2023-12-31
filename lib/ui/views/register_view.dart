import 'package:agenda_front/constants.dart';
import 'package:agenda_front/providers/auth_provider.dart';
import 'package:agenda_front/providers/user_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/ui/buttons/my_outlined_button.dart';
import 'package:agenda_front/ui/buttons/my_text_button.dart';
import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final provider = Provider.of<AuthProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.only(top: defaultPadding * 5),
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 370),
          child: FormBuilder(
              key: formKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: "email",
                    decoration: CustomInputs.form(
                        label: 'Correo electrónico',
                        hint: 'Ingrese su correo',
                        icon: Icons.supervised_user_circle_sharp),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Correo electrónico obligatorio.'),
                      FormBuilderValidators.email(
                          errorText: 'El correo no es correcto.'),
                    ]),
                  ),

                  const SizedBox(height: defaultPadding),
                  // Password
                  FormBuilderTextField(
                    name: "password",
                    decoration: CustomInputs.form(
                        label: 'Contraseña de seguridad',
                        hint: '********',
                        icon: Icons.lock),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Contraseña obligatoria.'),
                      FormBuilderValidators.minLength(8,
                          errorText:
                              'La contraseña debe tener minimo 8 caracteres'),
                      FormBuilderValidators.maxLength(30,
                          errorText:
                              'La contraseña debe tener maximo 30 caracteres')
                    ]),
                    obscureText: true,
                  ),
                  const SizedBox(height: defaultPadding),
                  // Matching Password
                  FormBuilderTextField(
                    name: "matchingPassword",
                    decoration: CustomInputs.form(
                        label: 'Repita la contraseña de seguridad',
                        hint: '********',
                        icon: Icons.lock_outline),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Debe repetir la contraseña.'),
                      FormBuilderValidators.minLength(8,
                          errorText:
                              'La contraseña debe tener minimo 8 caracteres'),
                      FormBuilderValidators.maxLength(30,
                          errorText:
                              'La contraseña debe tener maximo 30 caracteres'),
                      (matchingPassword) {
                        final password =
                            formKey.currentState?.fields['password']!.value;
                        return password.contains(matchingPassword)
                            ? null
                            : 'Las contraseñas no coinciden';
                      }
                    ]),
                    obscureText: true,
                  ),

                  const SizedBox(height: defaultPadding),
                  MyOutlinedButton(
                    onPressed: () async {
                      if (formKey.currentState!.saveAndValidate()) {
                        final email =
                            formKey.currentState!.fields['email']!.value;
                        if (await Provider.of<UserProvider>(context,
                                listen: false)
                            .existe(email)) {
                          formKey.currentState!.fields['email']
                              ?.invalidate('Correo no disponible.');
                          return;
                        } else {
                          await provider.register(formKey.currentState!.value);
                        }
                      }
                    },
                    text: 'Crear cuenta',
                  ),

                  const SizedBox(height: defaultPadding),
                  MyTextButton(
                    text: 'Ir al login',
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Flurorouter.loginRoute);
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }
}
