import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/AccountModel.dart';

class InputWidget extends StatefulWidget {
  InputWidget({super.key});

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final _account = AccountModel(
    appName: '',
    userName: '',
    password: '',
    email: '',
    lastUpdatedDate: DateTime.now(),
    id: DateTime.now().toString(),
  );
  bool istrue = true;
  var _initvalues;
  var accountID;
  bool _eye = true;
  @override
  void didChangeDependencies() {
    if (istrue) {
      accountID = ModalRoute.of(context)!.settings.arguments as String?;
      if (accountID != null) {
        final editAccount =
            Provider.of<Datalist>(context, listen: false).findById(accountID);
        _initvalues = {
          'appname': editAccount.appName,
          'username': editAccount.userName,
          'password': editAccount.password,
          'email': editAccount.email,
        };
      }
    }
    istrue = false;
    super.didChangeDependencies();
  }

  final _formkey = GlobalKey<FormState>();

  void saveform(BuildContext context) {
    final isValid = _formkey.currentState!.validate();
    if (!isValid) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            accountID == null ? 'Added sucessfully' : 'Updated sucesssfully',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          backgroundColor: Colors.grey.shade200,
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          duration: const Duration(seconds: 2),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
    );

    _formkey.currentState!.save();

    if (accountID == null) {
      Provider.of<Datalist>(context, listen: false).addnewAccount(
          _account.appName,
          _account.userName,
          _account.password,
          _account.email);
      _formkey.currentState!.reset();
    } else {
      Provider.of<Datalist>(context, listen: false).editAccount(
          accountID,
          _account.appName,
          _account.userName,
          _account.password,
          _account.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                initialValue: accountID != null ? _initvalues['appname'] : "",
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter App name or Website name.... ';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.app_registration,
                    color: Colors.black,
                    size: 27,
                  ),
                  labelText: 'App Name or Website Name....',
                  labelStyle: const TextStyle(color: Colors.black),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2, color: Colors.red),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2, color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(width: 2, color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2, color: Colors.black),
                  ),
                ),
                textInputAction: TextInputAction.next,
                onSaved: (newValue) {
                  _account.appName = newValue!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                initialValue: accountID != null ? _initvalues['username'] : "",
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter UserName';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 27,
                  ),
                  labelText: 'UserName',
                  labelStyle: const TextStyle(color: Colors.black),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2, color: Colors.red),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2, color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(width: 2, color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2, color: Colors.black),
                  ),
                ),
                textInputAction: TextInputAction.next,
                onSaved: (newValue) {
                  _account.userName = newValue!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                initialValue: accountID != null ? _initvalues['email'] : "",
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter E-mail';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.black,
                    size: 27,
                  ),
                  labelText: 'E-mail',
                  labelStyle: const TextStyle(color: Colors.black),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2, color: Colors.red),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2, color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(width: 2, color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2, color: Colors.black),
                  ),
                ),
                textInputAction: TextInputAction.next,
                onSaved: (newValue) {
                  _account.email = newValue!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                obscureText: _eye,
                initialValue: accountID != null ? _initvalues['password'] : "",
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.black,
                    size: 27,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _eye = !_eye;
                      });
                    },
                    icon: Icon(
                      _eye ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.black),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2, color: Colors.red),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2, color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(width: 2, color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2, color: Colors.black),
                  ),
                ),
                textInputAction: TextInputAction.done,
                onSaved: (newValue) {
                  _account.password = newValue!;
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 13),
                width: double.infinity,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.yellow,
                  ),
                  onPressed: () {
                    saveform(context);
                  },
                  icon: Icon(
                    accountID == null ? Icons.add : Icons.update,
                    color: Colors.black,
                  ),
                  label: Text(
                    accountID == null ? 'Add' : 'Update',
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
