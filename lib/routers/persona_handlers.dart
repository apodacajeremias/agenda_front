import 'package:agenda_front/providers/auth_provider.dart';
import 'package:agenda_front/providers/persona_provider.dart';
import 'package:agenda_front/providers/sidemenu_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/ui/views/forms/persona_form_view.dart';
import 'package:agenda_front/ui/views/indexs/persona_index_view.dart';
import 'package:agenda_front/ui/views/login_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class PersonaHandlers {
  static Handler index = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.personasIndexRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const PersonaIndexView();
    } else {
      return const LoginView();
    }
  });

  static Handler create = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.personasIndexRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const PersonaView();
    } else {
      return const LoginView();
    }
  });

  static Handler edit = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.personasIndexRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      final id = params['id']?.first;
      final persona = Provider.of<PersonaProvider>(context).buscar(id!);
      return PersonaView(persona: persona);
    } else {
      return const LoginView();
    }
  });
}
