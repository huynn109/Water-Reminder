import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart' as sp;

// Created by huynn109 on 4/1/19.
class SharedPreferences {
  //
  /// Instantiation of the SharedPreferences library
  ///
  final String _kNotificationsPrefs = "allowNotifications";
  final String _kProfileUnitPrefs = "profileUnit";
  final String _kProfileGender = "profileGender";
  final String _kProfileWeight = "profileWeight";
  final String _kProfileGoal = "profileGoal";

  // Default value
  final bool _defaultUnitAsia = true;
  final String _defaultUnitWeightAsia = 'kg';
  final String _defaultUnitGoalAsia = 'ml';
  final String _defaultUnitWeightEu = 'lb';
  final String _defaultUnitGoalEu = 'oz';

  Future<bool> getAllowsNotifications() async {
    final sp.SharedPreferences prefs = await sp.SharedPreferences.getInstance();

    return prefs.getBool(_kNotificationsPrefs) ?? false;
  }

  Future<bool> setAllowsNotifications(bool value) async {
    final sp.SharedPreferences prefs = await sp.SharedPreferences.getInstance();

    return prefs.setBool(_kNotificationsPrefs, value);
  }

  Future<bool> getUnitAsia() async {
    final sp.SharedPreferences prefs = await sp.SharedPreferences.getInstance();

    return prefs.getBool(_kProfileUnitPrefs) ?? _defaultUnitAsia;
  }

  Future<void> setUnit(bool value, ProfileUnit unit) async {
    final sp.SharedPreferences prefs = await sp.SharedPreferences.getInstance();
    if (unit == ProfileUnit.asia) {
      prefs.setString(_kProfileWeight, _defaultUnitWeightAsia);
      prefs.setString(_kProfileGoal, _defaultUnitGoalAsia);
    } else {
      prefs.setString(_kProfileWeight, _defaultUnitWeightEu);
      prefs.setString(_kProfileGoal, _defaultUnitGoalEu);
    }
    return null;
  }
}

enum ProfileUnit { asia, eu }
