import 'package:agenda_front/constants.dart';
import 'package:agenda_front/providers/sidemenu_provider.dart';
import 'package:flutter/material.dart';

import 'package:agenda_front/ui/shared/navbar.dart';
import 'package:agenda_front/ui/shared/sidebar.dart';

class DashboardLayout extends StatefulWidget {
  final Widget child;

  const DashboardLayout({Key? key, required this.child}) : super(key: key);

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    SideMenuProvider.menuController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            Row(
              children: [
                if (size.width >= 700) const Sidebar(),

                Expanded(
                  child: Column(
                    children: [
                      // Navbar
                      const Navbar(),

                      // View
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: widget.child,
                      )),
                    ],
                  ),
                )
                // Contenedor de nuestro view
              ],
            ),
            if (size.width < 700)
              AnimatedBuilder(
                  animation: SideMenuProvider.menuController,
                  builder: (context, _) => Stack(
                        children: [
                          if (SideMenuProvider.isOpen)
                            Opacity(
                              opacity: SideMenuProvider.opacity.value,
                              child: GestureDetector(
                                onTap: () => SideMenuProvider.closeMenu(),
                                child: SizedBox(
                                    width: size.width, height: size.height),
                              ),
                            ),
                          Transform.translate(
                            offset: Offset(SideMenuProvider.movement.value, 0),
                            child: const Sidebar(),
                          )
                        ],
                      ))
          ],
        ));
  }
}
