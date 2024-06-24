import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:review_provider_sqlite/app/core/auth/auth_controller.dart';
import 'package:review_provider_sqlite/app/core/extensions/theme_extension.dart';
import 'package:review_provider_sqlite/app/core/ui/messages.dart';
import 'package:review_provider_sqlite/app/services/user/user_service.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {

  final _nameVN = ValueNotifier<String>("");

  @override
  void dispose() {
    _nameVN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor.withAlpha(70),
            ),
            child: Row(
              children: [
                Selector<AuthController, String>(
                  selector: (context, controller) => controller.user?.photoURL ?? "https://uxwing.com/wp-content/themes/uxwing/download/peoples-avatars/no-profile-picture-icon.png",
                  builder: (context, value, child) {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(value),
                      radius: 30,
                    );
                  }
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Selector<AuthController, String>(
                      selector: (context, controller) => controller.user?.displayName ?? "No name provided",
                      builder: (context, value, child) {
                        return Text(
                          value,
                          style: context.textTheme.titleMedium,
                        );
                      }
                    ),   
                  ),
                ),
              ],
            ),
          ),

          ListTile(
            title: const Text("Update name"),
            onTap: () => {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text("Update name"),
                    content: TextField(
                      decoration: const InputDecoration(
                        label: Text("Name")
                      ),
                      onChanged: (value) {
                        _nameVN.value = value;
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {

                          final name = _nameVN.value;

                          if(name.isEmpty) {
                            Messages.of(context).showError("Name is required");
                            return;
                          } else {
                            await context.read<UserService>().updateDisplayName(name: name);
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text("Update"),
                      ),
                    ],
                  );
                }
              )
            }
          ),
          ListTile(
            title: Text("Logout"),
            onTap: () => context.read<AuthController>().logout(),
          ),
        ],
      ),
    );
  }
}
