import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:video_list/models/category_model.dart';

import '/pages/get_text_field.dart';

class ProfileTab extends StatefulWidget {
  final List<CategoryModel> categories;

  const ProfileTab({
    super.key,
    required this.categories,
  });

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final Map<String, TextEditingController> _login_text_controllers = {
    'email': TextEditingController(),
    'password': TextEditingController(),
  };

  final Map<String, TextEditingController> _sign_job_seeker_text_controllers = {
    'surname': TextEditingController(),
    'lastname': TextEditingController(),
    'email': TextEditingController(),
    'password': TextEditingController(),
    'confirm_password': TextEditingController(),
  };

  final Map<String, TextEditingController> _sign_text_controllers = {
    'username': TextEditingController(),
    'email': TextEditingController(),
    'password': TextEditingController(),
    'confirm_password': TextEditingController(),
  };

  int _sign_index = 0;
  late CategoryModel dropdown_value;

  @override
  void initState() {
    dropdown_value = widget.categories.first;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _login_text_controllers.forEach((key, value) {
      value.dispose();
    });

    _sign_job_seeker_text_controllers.forEach((key, value) {
      value.dispose();
    });

    _sign_text_controllers.forEach((key, value) {
      value.dispose();
    });
  }

  void setDialog(bool login) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            Size size = MediaQuery.of(context).size;
            return AlertDialog(
              surfaceTintColor: Colors.transparent,
              actionsPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              insetPadding: EdgeInsets.all(2.0),
              contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
              actions: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    !login && _sign_index != 1
                        ? DropdownMenu<CategoryModel>(
                            initialSelection: dropdown_value,
                            onSelected: (CategoryModel? value) {
                              setState(() {
                                dropdown_value = value!;
                              });
                            },
                            dropdownMenuEntries: widget.categories.map<DropdownMenuEntry<CategoryModel>>(
                              (CategoryModel value) {
                                return DropdownMenuEntry<CategoryModel>(
                                  value: value,
                                  labelWidget: SizedBox(
                                    width: size.width * .5,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                                      child: GetTextField(
                                        text: AppLocalizations.of(context).categories(value.code),
                                        smallSize: true,
                                      ),
                                    ),
                                  ),
                                  label: AppLocalizations.of(context).categories(value.code),
                                  trailingIcon: Icon(Icons.person_add),
                                );
                              }
                            ).toList(),
                          )
                        : SizedBox.shrink(),
                    login
                        ? SizedBox.shrink()
                        : Container(
                            width: size.width * .8,
                            height: 50,
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Row(
                                    children: <Widget>[
                                      Checkbox(
                                        value: _sign_index == index,
                                        onChanged: (value) => setState(() {
                                          _sign_index = index;
                                        }),
                                      ),
                                      GetTextField(
                                        text: AppLocalizations.of(context).sign_user(0, index),
                                        smallSize: true,
                                        underline: _sign_index == index,
                                      ),
                                    ]
                                  ),
                                );
                              }
                            ),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        OutlinedButton.icon(
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(24.0)),
                                side: BorderSide(
                                  color: Colors.black,
                                  width: 0.2
                                ),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all(Colors.blueAccent),
                            elevation: WidgetStateProperty.all(1.0),
                            shadowColor: WidgetStateProperty.all(Colors.white),
                            minimumSize: WidgetStateProperty.all(Size(12.0, 45.0)),
                          ),
                          label: GetTextField(
                            text: login
                                ? AppLocalizations.of(context).login
                                : AppLocalizations.of(context).sign,
                            light: true,
                          ),
                          icon: Icon(
                            login ? Icons.login : Icons.manage_accounts,
                          ),
                          onPressed: () {
                            setState(login
                                ? () {
                                    // test = _login_text_controllers['user']!.text;
                                  }
                                : () {
                                    // test = _sign_text_controllers['username']!.text;
                                  });
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              login = !login;
                            });
                          },
                          child: GetTextField(
                            text: login
                                ? AppLocalizations.of(context).sign
                                : AppLocalizations.of(context).login,
                            underline: true,
                          ),
                        ),
                      ],
                    ),
                  ]
                ),
              ],
              content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  Center(
                    child: GetTextField(
                      text: login
                          ? AppLocalizations.of(context).login
                          : AppLocalizations.of(context).sign,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        width: size.width * .8,
                        height: MediaQuery.of(context).orientation == Orientation.portrait
                            ? size.height * .7
                            : login
                                ? size.height * .4
                                : size.height * .2,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: login
                              ? _login_text_controllers.length
                              : _sign_index == 0
                                  ? _sign_job_seeker_text_controllers.length
                                  : _sign_text_controllers.length,
                          itemBuilder: (context, index) {
                            String key = login
                                ? _login_text_controllers.keys.elementAt(index)
                                : _sign_index == 0
                                    ? _sign_job_seeker_text_controllers.keys
                                        .elementAt(index)
                                    : _sign_text_controllers.keys
                                        .elementAt(index);
                            return Container(
                              padding: EdgeInsets.only(top: 12.0),
                              child: TextField(
                                scrollPadding: const EdgeInsets.all(25.0),
                                controller: login
                                    ? _login_text_controllers[key]
                                    : _sign_index == 0
                                        ? _sign_job_seeker_text_controllers[key]
                                        : _sign_text_controllers[key],
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)
                                      .user_hints(key),
                                  contentPadding: EdgeInsets.all(12.0),
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.only(top: 100.0),
            child: GetTextField(
              text: AppLocalizations.of(context).profile,
              light: true,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      setDialog(true);
                    });
                  },
                  child: GetTextField(text: 'Login', light: true),
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      setDialog(false);
                    });
                  },
                  child: GetTextField(text: 'Sign in', light: true),
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
