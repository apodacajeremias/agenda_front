import 'package:agenda_front/api/agenda_api.dart';
import 'package:agenda_front/models/entities/transaccion.dart';
import 'package:agenda_front/services/notifications_service.dart';
import 'package:agenda_front/utils/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TransaccionProvider extends ChangeNotifier {
  List<Transaccion> transacciones = [];
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  buscarTodos() async {
    final response = await AgendaAPI.httpGet('/transacciones');
    List<Transaccion> transaccionesResponse = List<Transaccion>.from(
        response.map((model) => Transaccion.fromJson(model)));
    transacciones = [...transaccionesResponse];
    notifyListeners();
  }

  Transaccion? buscar(String id) {
    return transacciones.where((element) => element.id.contains(id)).first;
  }

  registrar() async {
    // Se guardan los datos y se valida
    if (formKey.currentState!.saveAndValidate()) {
      // Datos guardados
      var data = formKey.currentState!.value;
      // Si data tiene un campo ID y este tiene informacion
      if (data.containsKey('id') && data['id'] != null) {
        // Actualiza
        await _actualizar(data['id'], data);
      } else {
        await _guardar(data);
      }
    }
  }

  _guardar(Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPost('/transacciones', data);
      final transaccion = Transaccion.fromJson(json);
      transacciones.add(transaccion);
      notifyListeners();
      NotificationsService.showSnackbar('Agregado a transacciones');
    } catch (e) {
      NotificationsService.showSnackbarError('No agregado a transacciones');
      rethrow;
    }
  }

  _actualizar(String id, Map<String, dynamic> data) async {
    try {
      final json = await AgendaAPI.httpPut('/transacciones/$id', data);
      final transaccion = Transaccion.fromJson(json);
      // Buscamos el index en lista del ID Transaccion
      final index =
          transacciones.indexWhere((element) => element.id.contains(id));
      // Se substituye la informacion del index por la informacion actualizada
      transacciones[index] = transaccion;
      notifyListeners();
      NotificationsService.showSnackbar('Transaccion actualizado');
    } catch (e) {
      NotificationsService.showSnackbarError('Transaccion no actualizado');
      rethrow;
    }
  }

  eliminar(String id) async {
    try {
      final json = await AgendaAPI.httpDelete('/transacciones/$id', {});
      final confirmado = json.toString().toBoolean();
      if (confirmado) {
        transacciones.removeWhere((transaccion) => transaccion.id == id);
        notifyListeners();
        NotificationsService.showSnackbar('1 transaccion eliminado');
      }
    } catch (e) {
      NotificationsService.showSnackbarError('Transaccion no eliminado');
      rethrow;
    }
  }
}
