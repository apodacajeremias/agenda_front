// ignore_for_file: prefer_const_constructors

import 'package:agenda_front/constants.dart';
import 'package:agenda_front/models/entities/grupo.dart';
import 'package:agenda_front/providers/beneficio_provider.dart';
import 'package:agenda_front/providers/grupo_provider.dart';
import 'package:agenda_front/providers/persona_provider.dart';
import 'package:agenda_front/ui/buttons/my_elevated_button.dart';
import 'package:agenda_front/ui/cards/white_card.dart';
import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:agenda_front/ui/shared/forms/form_header.dart';
import 'package:agenda_front/ui/shared/widgets/text_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class GrupoFormView extends StatefulWidget {
  final Grupo? grupo;
  const GrupoFormView({super.key, this.grupo});

  @override
  State<GrupoFormView> createState() => _GrupoFormViewState();
}

class _GrupoFormViewState extends State<GrupoFormView> {
  @override
  void initState() {
    Provider.of<BeneficioProvider>(context, listen: false).buscarTodos();
    Provider.of<PersonaProvider>(context, listen: false).buscarTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GrupoProvider>(context, listen: false);
    final beneficios =
        Provider.of<BeneficioProvider>(context, listen: false).beneficios;
    final personas =
        Provider.of<PersonaProvider>(context, listen: false).personas;
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          FormHeader(title: 'Grupo'),
          WhiteCard(
            child: FormBuilder(
              key: provider.formKey,
              child: Column(
                children: [
                  if (widget.grupo?.id != null) ...[
                    const SizedBox(height: defaultPadding),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: FormBuilderTextField(
                              name: 'ID',
                              initialValue: widget.grupo?.id,
                              enabled: false,
                              decoration: CustomInputs.form(
                                  label: 'ID', hint: 'ID', icon: Icons.qr_code),
                            )),
                        const SizedBox(width: defaultPadding),
                        Expanded(
                            child: FormBuilderSwitch(
                          name: 'activo',
                          title: const Text('Estado del registro'),
                          initialValue: widget.grupo?.activo,
                          decoration: CustomInputs.noBorder(),
                        )),
                      ],
                    )
                  ],
                  SizedBox(height: defaultPadding),
                  FormBuilderTextField(
                      name: 'nombre',
                      initialValue: widget.grupo?.nombre,
                      enabled: widget.grupo?.activo ?? true,
                      decoration: CustomInputs.form(
                          label: 'Nombre del grupo',
                          hint: 'Nombre que describa al grupo',
                          icon: Icons.info),
                      validator: FormBuilderValidators.required(
                          errorText: 'Campo obligatorio')),
                  SizedBox(height: defaultPadding),
                  FormBuilderSearchableDropdown(
                      name: 'beneficio',
                      compareFn: (item1, item2) =>
                          item1.id!.contains(item2.id!),
                      items: beneficios),
                  TextSeparator(text: 'Agregar personas al grupo'),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: FormBuilderSearchableDropdown(
                            name: 'personas-x',
                            compareFn: (item1, item2) =>
                                item1.id!.contains(item2.id!),
                            items: personas),
                      ),
                      SizedBox(width: defaultPadding),
                      Expanded(
                          child: MyElevatedButton(
                        text: 'Agregar persona al grupo',
                        icon: Icons.person_add,
                      ))
                    ],
                  ),
                  // TODO: agregar una tabla que muestre los integrantes del grupo
                  // TODO: la tabla debe poseer un boton para quitar a los integrantes de grupo
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
