import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authenticate.dart';
import 'home.dart';
import 'models/users.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if (user == null)
      return Authenticate();
    else
      return Home();
  }
}
