import 'package:agenda_front/constants.dart';
import 'package:agenda_front/datasources/agenda_datasource.dart';
import 'package:agenda_front/datasources/transaccion_datasource.dart';
import 'package:agenda_front/models/enums/genero.dart';
import 'package:agenda_front/models/entities/persona.dart';
import 'package:agenda_front/providers/persona_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/services/navigation_service.dart';
import 'package:agenda_front/ui/buttons/my_elevated_button.dart';
import 'package:agenda_front/ui/buttons/my_outlined_button.dart';
import 'package:agenda_front/ui/labels/text_profile_detail.dart';
import 'package:agenda_front/ui/shared/indexs/my_index.dart';
import 'package:agenda_front/ui/shared/widgets/avatar.dart';
import 'package:agenda_front/ui/shared/widgets/text_separator.dart';
import 'package:agenda_front/ui/views/indexs/transaccion_index_view.dart';
import 'package:agenda_front/utils/fecha_util.dart';
import 'package:agenda_front/ui/cards/white_card.dart';
import 'package:agenda_front/ui/inputs/custom_inputs.dart';
import 'package:agenda_front/ui/shared/forms/form_footer.dart';
import 'package:agenda_front/ui/shared/forms/form_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PersonaFormView extends StatefulWidget {
  final Persona? persona;

  const PersonaFormView({super.key, this.persona});

  @override
  State<PersonaFormView> createState() => _PersonaFormViewState();
}

class _PersonaFormViewState extends State<PersonaFormView> {
  bool isProfile = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PersonaProvider>(context, listen: false);
    return isProfile ? _profile(provider, context) : _form(provider, context);
  }

  Widget _profile(PersonaProvider provider, BuildContext context) {
    return ListView(children: [
      const FormHeader(title: 'Perfil'),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: _profileDetails(context)),
          Expanded(flex: 4, child: _profileDashboard(context))
        ],
      ),
    ]);
  }

  Widget _profileDetails(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: Column(
        children: [
          WhiteCard(
              footer: MyElevatedButton(
                text: 'Editar',
                icon: Icons.edit_outlined,
                onPressed: () => setState(() {
                  print('edit pressed');
                }),
              ),
              child: Column(
                children: [
                  Center(
                      child: Avatar(
                    widget.persona!.fotoPerfil ?? '',
                    size: 200,
                  )),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          widget.persona?.nombre ??
                              'Eiusmod commodo duis ea ut Lorem sunt duis commodo consequat qui nisi reprehenderit sunt proident.',
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                            widget.persona?.colaborador != null
                                ? 'Colaborador'
                                : 'Cliente',
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleSmall),
                      ],
                    ),
                  ),
                  const Divider(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Transacciones',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        Text('0',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Colors.blue)),
                      ]),
                  const Divider(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Pagos',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        Text('0',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Colors.blue)),
                      ]),
                  const Divider(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Agendamientos',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        Text('0',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Colors.blue)),
                      ]),
                ],
              )),
          WhiteCard(
              child: Column(
            children: [
              TextProfileDetail(
                  icon: Icons.badge_outlined,
                  title: 'Documento',
                  text: widget.persona!.documentoIdentidad),
              TextProfileDetail(
                  icon: Icons.cake_outlined,
                  text: FechaUtil.formatDate(
                      widget.persona?.fechaNacimiento ?? DateTime.now())),
              TextProfileDetail(
                  icon: Icons.info_outline,
                  title: 'Edad',
                  text: widget.persona?.edad.toString()),
              TextProfileDetail(
                  icon: widget.persona!.genero!.icon,
                  text: widget.persona!.genero!.toString(),
                  hasDivider: false),
              if (widget.persona?.colaborador != null) ...[
                const SizedBox(height: defaultPadding / 2),
                const TextSeparator(
                    text: 'Información profesional', color: Colors.black),
                const SizedBox(height: defaultPadding / 2),
                TextProfileDetail(
                    icon: Icons.info_outline,
                    title: 'Registro de Contribuyente',
                    text: widget.persona!.colaborador?.registroContribuyente),
                TextProfileDetail(
                    icon: Icons.info_outline,
                    title: 'Registro de Profesional',
                    text: widget.persona!.colaborador?.registroProfesional),
                TextProfileDetail(
                    icon: Icons.info_outline,
                    title: 'Profesión',
                    text: widget.persona!.colaborador?.profesion,
                    hasDivider: false),
              ],
            ],
          ))
        ],
      ),
    );
  }

  Widget _profileDashboard(BuildContext context) {
    final provider = Provider.of<PersonaProvider>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: Column(
        children: [
          WhiteCard(
            title: 'Agendamientos',
            actions: MyOutlinedButton(
                text: 'Crear', icon: Icons.add, onPressed: () {}),
            child: FutureBuilder(
              future: provider.agendas(widget.persona!.id!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: 100,
                    child: Column(
                      children: [
                        const CircularProgressIndicator(),
                        Text('Cargando...',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w300))
                      ],
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return MyIndex(
                        columns: AgendaDataSourceProfile.columns,
                        source:
                            AgendaDataSourceProfile(snapshot.data!, context));
                  } else {
                    return const SizedBox(
                      height: 50,
                      child: Column(
                        children: [
                          Icon(Icons.warning),
                          Text('No hay registros')
                        ],
                      ),
                    );
                  }
                } else {
                  return const SizedBox(
                    height: 50,
                    child: Column(
                      children: [Icon(Icons.error), Text('Error al cargar')],
                    ),
                  );
                }
              },
            ),
          ),
          WhiteCard(
            title: 'Transacciones',
            actions: MyOutlinedButton(
                text: 'Crear', icon: Icons.add, onPressed: () {}),
            child: FutureBuilder(
              future: provider.transacciones(widget.persona!.id!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: 100,
                    child: Column(
                      children: [
                        const CircularProgressIndicator(),
                        Text('Cargando...',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w300))
                      ],
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return MyIndex(
                        columns: TransaccionDataSourceProfile.columns,
                        source: TransaccionDataSourceProfile(
                            snapshot.data!, context));
                  } else {
                    return const SizedBox(
                      height: 50,
                      child: Column(
                        children: [
                          Icon(Icons.warning),
                          Text('No hay registros')
                        ],
                      ),
                    );
                  }
                } else {
                  return const SizedBox(
                    height: 50,
                    child: Column(
                      children: [Icon(Icons.error), Text('Error al cargar')],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _form(PersonaProvider provider, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const FormHeader(title: 'Persona'),
          WhiteCard(
              child: FormBuilder(
            key: provider.formKey,
            child: Column(
              children: [
                if (widget.persona?.id != null) ...[
                  const SizedBox(height: defaultPadding / 2),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: FormBuilderTextField(
                            name: 'ID',
                            initialValue: widget.persona?.id,
                            enabled: false,
                            decoration: CustomInputs.form(
                                label: 'ID', hint: 'ID', icon: Icons.qr_code),
                          )),
                      const SizedBox(width: defaultPadding),
                      Expanded(
                          child: FormBuilderSwitch(
                        name: 'activo',
                        title: const Text('Estado del registro'),
                        initialValue: widget.persona?.activo,
                        decoration: CustomInputs.noBorder(),
                      )),
                    ],
                  )
                ],
                const SizedBox(height: defaultPadding / 2),
                FormBuilderTextField(
                    name: 'nombre',
                    initialValue: widget.persona?.nombre,
                    enabled: widget.persona?.activo ?? true,
                    decoration: CustomInputs.form(
                        hint: 'Nombre completo',
                        label: 'Nombre y Apellido',
                        icon: Icons.info),
                    validator: FormBuilderValidators.required(
                        errorText: 'Campo obligatorio')),
                const SizedBox(height: defaultPadding / 2),
                Row(
                  children: [
                    Expanded(
                        child: FormBuilderTextField(
                            name: 'documentoIdentidad',
                            initialValue: widget.persona?.documentoIdentidad,
                            enabled: widget.persona?.activo ?? true,
                            decoration: CustomInputs.form(
                                hint:
                                    'Numero de documento, C.I., R.G., C.P.F., D.N.I., pasaporte...',
                                label: 'Documento de Identidad',
                                icon: Icons.perm_identity),
                            validator: FormBuilderValidators.required(
                                errorText: 'Campo obligatorio'))),
                    const SizedBox(width: defaultPadding),
                    Expanded(
                      child: FormBuilderDropdown(
                        name: 'genero',
                        initialValue: widget.persona?.genero ?? Genero.OTRO,
                        enabled: widget.persona?.activo ?? true,
                        decoration: CustomInputs.form(
                            label: 'Genero',
                            hint: 'Genero de persona',
                            icon: Icons.info),
                        items: Genero.values
                            .map((g) => DropdownMenuItem(
                                value: g,
                                child: Row(
                                  children: [
                                    Icon(g.icon),
                                    const SizedBox(width: defaultPadding / 2),
                                    Text(toBeginningOfSentenceCase(
                                        g.name.toLowerCase())!)
                                  ],
                                )))
                            .toList(),
                        validator: FormBuilderValidators.required(
                            errorText: 'Genero obligatorio'),
                        valueTransformer: (value) => value?.name,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: defaultPadding / 2),
                Row(children: [
                  Expanded(
                    child: FormBuilderDateTimePicker(
                      name: 'fechaNacimiento',
                      format: FechaUtil.dateFormat,
                      initialValue:
                          widget.persona?.fechaNacimiento ?? DateTime.now(),
                      enabled: widget.persona?.activo ?? true,
                      decoration: CustomInputs.form(
                          hint: 'Fecha de nacimiento',
                          label: 'Fecha de nacimiento',
                          icon: Icons.cake),
                      validator: FormBuilderValidators.required(
                          errorText: 'Campo obligatorio'),
                      onChanged: (value) {
                        provider.formKey.currentState!.fields['edad']!
                            .didChange(
                                FechaUtil.calcularEdad(value!).toString());
                      },
                      inputType: InputType.date,
                      valueTransformer: (value) => value?.toIso8601String(),
                    ),
                  ),
                  const SizedBox(width: defaultPadding),
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'edad',
                      initialValue: (widget.persona != null)
                          ? FechaUtil.calcularEdad(
                                  widget.persona!.fechaNacimiento!)
                              .toString()
                          : '0',
                      enabled: widget.persona?.activo ?? true,
                      decoration: CustomInputs.form(
                          hint: 'Edad de la persona',
                          label: 'Edad hasta la fecha',
                          icon: Icons.numbers),
                    ),
                  ),
                ]),
                const SizedBox(height: defaultPadding / 2),
                FormBuilderTextField(
                    name: 'telefono',
                    initialValue: widget.persona?.telefono,
                    enabled: widget.persona?.activo ?? true,
                    decoration: CustomInputs.form(
                        hint: 'Telefono de contacto',
                        label: 'Telefono',
                        icon: Icons.phone),
                    validator: FormBuilderValidators.minLength(7,
                        errorText:
                            'Numero de telefono muy corto para ser válido',
                        allowEmpty: true)),
                const SizedBox(height: defaultPadding / 2),
                FormBuilderTextField(
                    name: 'celular',
                    initialValue: widget.persona?.celular,
                    enabled: widget.persona?.activo ?? true,
                    decoration: CustomInputs.form(
                        hint: 'Celular de contacto',
                        label: 'Celular',
                        icon: Icons.phone_android),
                    validator: FormBuilderValidators.minLength(7,
                        errorText:
                            'Numero de celular muy corto para ser válido',
                        allowEmpty: true)),
                const SizedBox(height: defaultPadding / 2),
                FormBuilderTextField(
                    name: 'direccion',
                    initialValue: widget.persona?.direccion,
                    enabled: widget.persona?.activo ?? true,
                    decoration: CustomInputs.form(
                        hint: 'Direccion de domicilio',
                        label: 'Direccion',
                        icon: Icons.gps_fixed),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.minLength(5,
                          errorText: 'Direccion muy corta, de mas detalles',
                          allowEmpty: true),
                      FormBuilderValidators.maxLength(255,
                          errorText: 'Direccion muy larga')
                    ])),
                const SizedBox(height: defaultPadding / 2),
                FormBuilderTextField(
                    name: 'observacion',
                    initialValue: widget.persona?.observacion,
                    enabled: widget.persona?.activo ?? true,
                    decoration: CustomInputs.form(
                        hint: 'Observacion',
                        label: 'Observaciones',
                        icon: Icons.gps_fixed),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.minLength(5,
                          errorText: 'Observacion muy corta, de mas detalles',
                          allowEmpty: true),
                      FormBuilderValidators.maxLength(255,
                          errorText: 'Observacion muy larga')
                    ])),
                const SizedBox(height: defaultPadding / 2),
                FormBuilderImagePicker(
                    name: 'file',
                    decoration: CustomInputs.form(
                        hint: 'Selecciona una foto para el perfil',
                        label: 'Foto de perfil',
                        icon: Icons.image),
                    maxImages: 1),
                FormFooter(onConfirm: () async {
                  if (provider.saveAndValidate()) {
                    try {
                      await provider.registrar(provider.formData());
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    } catch (e) {
                      rethrow;
                    }
                  }
                })
              ],
            ),
          ))
        ],
      ),
    );
  }
}
