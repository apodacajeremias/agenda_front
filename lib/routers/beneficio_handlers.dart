import 'package:agenda_front/providers/auth_provider.dart';
import 'package:agenda_front/providers/beneficio_provider.dart';
import 'package:agenda_front/providers/sidemenu_provider.dart';
import 'package:agenda_front/routers/router.dart';
import 'package:agenda_front/ui/views/forms/beneficio_form_view.dart';
import 'package:agenda_front/ui/views/indexs/beneficio_index_view.dart';
import 'package:agenda_front/ui/views/login_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

class BeneficioHandlers {
  static Handler index = Handler(handlerFunc: (context, parameters) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.beneficiosIndexRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const BeneficioIndexView();
    } else {
      return const LoginView();
    }
  });

  static Handler create = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.beneficiosIndexRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const BeneficioFormView();
    } else {
      return const LoginView();
    }
  });

  static Handler edit = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.beneficiosIndexRoute);
    final id = params['id']?.first;
    final beneficio =
        Provider.of<BeneficioProvider>(context, listen: false).buscar(id!);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return BeneficioFormView(beneficio: beneficio);
    } else {
      return const LoginView();
    }
  });
}
