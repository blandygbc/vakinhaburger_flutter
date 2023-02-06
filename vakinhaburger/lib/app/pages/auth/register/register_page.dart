import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakinhaburger/app/core/ui/base_state/base_state.dart';
import 'package:vakinhaburger/app/core/ui/helpers/size_extensions.dart';
import 'package:vakinhaburger/app/core/ui/styles/text_styles.dart';
import 'package:vakinhaburger/app/core/ui/widgets/delivery_appbar.dart';
import 'package:vakinhaburger/app/core/ui/widgets/delivery_button.dart';
import 'package:vakinhaburger/app/pages/auth/register/register_controller.dart';
import 'package:vakinhaburger/app/pages/auth/register/register_state.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          register: () => showLoader(),
          error: () {
            hideLoader();
            showError('Erro ao registrar o usuário');
          },
          success: () {
            hideLoader();
            showSuccess('Cadastro realizado com sucesso');
            Navigator.pop(context);
          },
        );
      },
      child: Scaffold(
        appBar: DeliveryAppbar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cadastro',
                      style: context.textStyles.textTitle,
                    ),
                    Text(
                      'Preencha os campos abaixo para criar o  seu cadastro.',
                      style:
                          context.textStyles.textMedium.copyWith(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _nameEC,
                      decoration: const InputDecoration(
                        labelText: 'Nome*',
                      ),
                      validator: Validatorless.required('Nome é obrigatório'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _emailEC,
                      decoration: const InputDecoration(
                        labelText: 'E-mail*',
                      ),
                      validator: Validatorless.multiple([
                        Validatorless.required('E-mail é obrigatório'),
                        Validatorless.email('E-mail inválido'),
                      ]),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _passwordEC,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Senha*',
                      ),
                      validator: Validatorless.multiple([
                        Validatorless.required('Senha é obrigatória'),
                        Validatorless.min(
                          6,
                          'A senha deve conter pelo menos 6 caracteres',
                        ),
                      ]),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirmar senha*',
                      ),
                      validator: Validatorless.multiple([
                        Validatorless.required(
                            'Confirmar a senha é obrigatório'),
                        Validatorless.compare(
                            _passwordEC, 'As senhas não são iguais!'),
                      ]),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    DeliveryButton(
                      width: context.screenWith,
                      label: 'CADASTRAR',
                      onPressed: () {
                        final valid =
                            _formKey.currentState?.validate() ?? false;
                        if (valid) {
                          controller.register(
                            _nameEC.text,
                            _emailEC.text,
                            _passwordEC.text,
                          );
                        }
                      },
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
