import 'package:flutter/material.dart';
import 'package:ez_rappel/ui/routes/primary_routes.dart' as routes;

Drawer mainDrawer(context) => Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Header Text'),
          ),
          ListTile(
            title: const Text("Practice"),
            onTap: () {
              Navigator.pop(context);
              routes.pushPractice(context);
            },
          ),
          ListTile(
            title: const Text("Modify Wordgroups"),
            onTap: () {
              Navigator.pop(context);
              routes.pushModifyWordgroups(context);
            },
          ),
          ListTile(
            title: const Text("Modify Words"),
            onTap: () {
              Navigator.pop(context);
              routes.pushModifyWordpairs(context);
            },
          )
        ],
      ),
    );
