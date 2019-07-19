import 'package:flutter/material.dart';
import 'county_phone_data.dart';
import 'country_list_tile.dart';
import 'phone_input_text_controller.dart';

/// 
/// Callback type define
/// Called when textcontroller get whole phone number
///
typedef void OnPhoneNumberComplete(String phoneNum);

///
/// Widget for allowing user to pick country and enter phone number
/// An OnPhoneNumberComplete callback is required to init this widget.
///
class PhoneInputTextField extends StatefulWidget {
  final OnPhoneNumberComplete onPhoneNumComplete;

  PhoneInputTextField({@required this.onPhoneNumComplete});

  @override
  State<StatefulWidget> createState() {
    return _PhoneInputTextFieldState();
  }
}

class _PhoneInputTextFieldState extends State<PhoneInputTextField> {
  Country _country;
  List<Country> countrys = [];
  PhoneInputTextController _controller;

  void _onCountrySelected(Country country) {
    setState(() {
      this._country = country;
      _controller = PhoneInputTextController(
          pattern: _country.pattern, onCompleted: _onEnterCompleted);
    });
  }

  ///
  /// Called TextController gets phone number
  ///
  void _onEnterCompleted(String phoneNum) {
    String countryCode = _country.countryCode;
    String phoneWithCouCode = countryCode + phoneNum.replaceAll('-', '');
    widget.onPhoneNumComplete(phoneWithCouCode);
  }

  @override
  void initState() {
    super.initState();
    // Default is set to U.S.
    // TODO: add default country support.
    countrys = PhoneData().getCountry();
    _country = Country("United States", "us", "000-000-1234", "1");
    _controller = PhoneInputTextController(
        pattern: _country.pattern, onCompleted: _onEnterCompleted);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Image.asset(
              "assets/country/${_country.iosCode.toLowerCase()}.png",
              height: 20.0,
              width: 30.0,
              fit: BoxFit.fill,
              package: 'phone_input_text_field',
            ),
            onPressed: () {
              _onCountryFlagTapped(context);
            },
          ),
          SizedBox(
            width: 4.0,
          ),
          Text('+${_country.countryCode}'),
          SizedBox(
            width: 4.0,
          ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: _country.pattern),
              controller: _controller,
            ),
          )
        ],
      ),
    );
  }

  ///
  /// Called when user tapped on change country.
  ///
  void _onCountryFlagTapped(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ListView.builder(
            itemCount: countrys.length,
            itemBuilder: (context, index) {
              return CountryListTile(countrys[index], _onCountrySelected);
            },
          );
        });
  }
}

