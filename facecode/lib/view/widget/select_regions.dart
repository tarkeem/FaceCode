// ignore_for_file: must_be_immutable

import 'package:csc_picker/csc_picker.dart';
import 'package:facecode/providers/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectRegion extends StatelessWidget {
  String? country_;
  String? state_;
  String? city_;
  SelectRegion({super.key , required this.city_ , required this.country_ , required this.state_});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return CSCPicker(
      countryDropdownLabel: "Select Country",
      stateDropdownLabel: "Select State",
      cityDropdownLabel: "Select City",
      layout: Layout.vertical,
      flagState: CountryFlag.ENABLE,
      onCountryChanged: (country) {
        country_ = country;
        print(country_);
      },
      onStateChanged: (state) {
        state_ = state;
        print(state_);
      },
      onCityChanged: (city) {
        city_ = city;
        print(city_);
      },
      dropdownDialogRadius: 12,
      searchBarRadius: 30,
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color:
              provider.myTheme == ThemeMode.dark ? Colors.white : Colors.grey,
          width: 1,
        ),
      ),
      dropdownItemStyle: TextStyle(color: Colors.black, fontSize: 15),
      disabledDropdownDecoration: BoxDecoration(
        color: Colors.grey.shade600,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: provider.myTheme == ThemeMode.dark
              ? Colors.white
              : Colors.grey.shade600,
          width: 1,
        ),
      ),
    );
  }
}
