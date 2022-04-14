import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tree_app/providers/user_provider.dart';

class SessionScreen extends StatefulWidget {
  final Widget success;

  const SessionScreen({
    Key? key,
    required this.success,
  }) : super(key: key);

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return widget.success;
  }
}
