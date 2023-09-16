import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:password_manager/Models/BankAccountModel.dart';
import 'package:provider/provider.dart';

class BankInputWidget extends StatefulWidget {
  const BankInputWidget({super.key});

  @override
  State<BankInputWidget> createState() => _BankInputWidgetState();
}

class _BankInputWidgetState extends State<BankInputWidget> {
  List<String> accounttypes = [
    'Savings Account',
    'Current Account',
    'Recurring Deposit',
    'Joint Account',
    'Fixed Deposit',
    'Money Market Account'
  ];
  String selectedItem = 'Select Account Type*';
  bool _isopen = false;
  final _formkey = GlobalKey<FormState>();

  final _bankAccount = BankAccountModel(
    bankName: '',
    branchName: '',
    accountHolderName: '',
    accountNumber: 0,
    accountType: '',
    cardNumber: 0,
    ifcCode: '',
    atmPin: 0,
  );

  var _intiValues;
  bool _istrue = true;
  var GetBankId;
  int _count = 0;
  bool _isErro = false;
  @override
  void didChangeDependencies() {
    if (_istrue) {
      GetBankId = ModalRoute.of(context)!.settings.arguments as String?;
      if (GetBankId != null) {
        final _Accountbank =
            Provider.of<BankData>(context).findBYidBank(GetBankId);
        _intiValues = {
          'bank name': _Accountbank.bankName,
          'branch name': _Accountbank.branchName,
          'holder name': _Accountbank.accountHolderName,
          'account number': _Accountbank.accountNumber,
          'debit card': _Accountbank.cardNumber,
          'ifsc': _Accountbank.ifcCode,
          'atm': _Accountbank.atmPin,
          'type': _Accountbank.accountType,
        };
        setState(
          () {
            selectedItem = _intiValues['type'];
            _bankAccount.accountType = _intiValues['type'];
          },
        );
      }
    }
    _istrue = false;
    super.didChangeDependencies();
  }

  void _saveANDcheck() {
    final valid = _formkey.currentState!.validate();
    if (selectedItem == 'Select Account Type*') {
      setState(() {
        _isErro = true;
        _isopen = false;
      });
    } else {
      setState(() {
        _isErro = false;
      });
    }
    if (!valid || selectedItem == 'Select Account Type*') {
      return;
    }

    _formkey.currentState!.save();

    if (GetBankId == null) {
      Provider.of<BankData>(context, listen: false)
          .addbankAccount(_bankAccount);
      _formkey.currentState!.reset();
    } else {
      Provider.of<BankData>(context, listen: false)
          .editbankAccount(_bankAccount, GetBankId);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            GetBankId == null ? 'Added sucesssfully' : 'Updated sucessfully',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          backgroundColor: Colors.grey.shade200,
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          duration: const Duration(seconds: 2),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      splashColor: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        setState(() {
                          _isopen = !_isopen;
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        margin: _isopen
                            ? EdgeInsets.zero
                            : const EdgeInsets.only(bottom: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: _isopen
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                )
                              : BorderRadius.circular(15),
                          border: Border.all(
                            width: 2,
                            color: _isErro
                                ? Colors.redAccent
                                : _isopen
                                    ? Colors.black
                                    : Colors.grey.shade400,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.piggyBank,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              selectedItem,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const Spacer(),
                            Icon(
                              _isopen
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_isopen)
                      Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          border: Border.all(
                            width: 2,
                            color: _isErro
                                ? Colors.red
                                : _isopen
                                    ? Colors.black
                                    : Colors.grey.shade400,
                          ),
                        ),
                        child: ListView(
                          primary: false,
                          shrinkWrap: true,
                          children: accounttypes.map(
                            (acctype) {
                              _count == 6 ? _count = 1 : _count++;
                              return InkWell(
                                splashColor: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  setState(
                                    () {
                                      selectedItem = acctype;
                                      _bankAccount.accountType = acctype;
                                      _isopen = false;
                                    },
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 2,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: selectedItem == acctype
                                          ? Colors.blue.shade100
                                          : Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          '$_count)',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 8),
                                            child: Text(
                                              acctype,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    if (_isErro)
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(
                          'Select Account type',
                          style: TextStyle(
                            color: Colors.red.shade600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              TextFormField(
                initialValue:
                    GetBankId == null ? null : _intiValues['bank name'],
                decoration: InputDecoration(
                  labelText: 'Bank name*',
                  labelStyle: const TextStyle(color: Colors.black),
                  prefixIcon: const Icon(
                    Icons.account_balance,
                    color: Colors.black,
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
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2, color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2, color: Colors.red),
                  ),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Bank name';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _bankAccount.bankName = newValue!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                initialValue:
                    GetBankId == null ? null : _intiValues['branch name'],
                decoration: InputDecoration(
                  labelText: 'Branch name*',
                  labelStyle: const TextStyle(color: Colors.black),
                  prefixIcon: const Icon(
                    FontAwesomeIcons.codeBranch,
                    color: Colors.black,
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
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2, color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2, color: Colors.red),
                  ),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Branch name';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _bankAccount.branchName = newValue!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                initialValue:
                    GetBankId == null ? null : _intiValues['holder name'],
                decoration: InputDecoration(
                  labelText: 'Account holder name*',
                  labelStyle: const TextStyle(color: Colors.black),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.black,
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
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2, color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2, color: Colors.red),
                  ),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Account holder name';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _bankAccount.accountHolderName = newValue!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                initialValue: GetBankId == null
                    ? null
                    : _intiValues['account number'].toString(),
                decoration: InputDecoration(
                  labelText: 'Bank Account number*',
                  labelStyle: const TextStyle(color: Colors.black),
                  prefixIcon: const Icon(
                    Icons.numbers,
                    color: Colors.black,
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
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2, color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2, color: Colors.red),
                  ),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.length >= 9 && value.length <= 18) {
                    return null;
                  }
                  return 'Invalid Account number';
                },
                onSaved: (newValue) {
                  _bankAccount.accountNumber = int.parse(newValue!);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                initialValue: GetBankId == null
                    ? null
                    : _intiValues['debit card'] != 0
                        ? _intiValues['debit card'].toString()
                        : '',
                decoration: InputDecoration(
                  labelText: 'Debit card number',
                  labelStyle: const TextStyle(color: Colors.black),
                  prefixIcon: const Icon(
                    Icons.add_card_sharp,
                    color: Colors.black,
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
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2, color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(width: 2, color: Colors.red),
                  ),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isNotEmpty && value.length != 16) {
                    return 'Invalid Debit card number';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  if (newValue!.isEmpty) {
                    _bankAccount.cardNumber = 0;
                  } else {
                    _bankAccount.cardNumber = int.parse(newValue);
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue:
                          GetBankId == null ? null : _intiValues['ifsc'],
                      decoration: InputDecoration(
                        labelText: 'IFSC code',
                        labelStyle: const TextStyle(color: Colors.black),
                        prefixIcon: const Icon(
                          Icons.code,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          borderSide:
                              BorderSide(width: 2, color: Colors.grey.shade400),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          borderSide: BorderSide(width: 2, color: Colors.black),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          borderSide: BorderSide(width: 2, color: Colors.red),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          borderSide: BorderSide(width: 2, color: Colors.red),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.streetAddress,
                      validator: (value) {
                        if (value!.isNotEmpty && value.length != 11) {
                          return 'Invalid IFSC code';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        if (newValue!.isEmpty) {
                          _bankAccount.ifcCode = '';
                        } else {
                          _bankAccount.ifcCode = newValue;
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      initialValue: GetBankId == null
                          ? null
                          : _intiValues['atm'] != 0
                              ? _intiValues['atm'].toString()
                              : '',
                      decoration: InputDecoration(
                        labelText: 'ATM pin',
                        labelStyle: const TextStyle(color: Colors.black),
                        prefixIcon: const Icon(
                          Icons.pin,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          borderSide:
                              BorderSide(width: 2, color: Colors.grey.shade400),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          borderSide: BorderSide(width: 2, color: Colors.black),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          borderSide: BorderSide(width: 2, color: Colors.red),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          borderSide: BorderSide(width: 2, color: Colors.red),
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isNotEmpty && value.length != 4) {
                          return 'Invalid ATM pin';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        if (newValue!.isEmpty) {
                          _bankAccount.atmPin = 0;
                        } else {
                          _bankAccount.atmPin = int.parse(newValue);
                        }
                      },
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () {
                    _saveANDcheck();
                  },
                  icon: Icon(
                    GetBankId == null ? Icons.add : Icons.update,
                    color: Colors.black,
                  ),
                  label: Text(
                    GetBankId == null ? 'Add' : 'Update',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.yellow,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
