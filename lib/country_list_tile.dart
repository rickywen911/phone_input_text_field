import 'package:flutter/material.dart';
import 'phone_input_text_field.dart';

class CountryListTile extends StatelessWidget {
  final Country _country;
  final Function onItemSelect;
  CountryListTile(this._country, this.onItemSelect);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        "assets/country/${_country.iosCode.toLowerCase()}.png",
        height: 20.0,
        width: 30.0,
        fit: BoxFit.fill,
        package: "phone_input_text_field",
      ),
      title: Text(_country.name),
      trailing: Text('+' + _country.countryCode),
      onTap: () {
        onItemSelect(_country);
        Navigator.pop(context);
      },
    );
  }
}
