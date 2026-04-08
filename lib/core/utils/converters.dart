import 'dart:convert';

int? convertToInt(dynamic valArg, {int? defValue}) {
  if (valArg == null) return defValue;
  if (valArg is int) return valArg;
  if (valArg is double) return valArg.toInt();
  if (valArg is String) return int.tryParse(valArg) ?? defValue;
  return defValue;
}

double? convertToDouble(dynamic valArg, {double? defValue}) {
  if (valArg == null) return defValue;
  if (valArg is double) return valArg;
  if (valArg is int) return valArg.toDouble();
  if (valArg is String) return double.tryParse(valArg) ?? defValue;
  return defValue;
}

bool? convertToBool(dynamic val, {bool? defValue}) {
  if (val == null) return defValue;
  if (val is bool) return val;
  if (val is int) return val == 1;
  if (val is String) {
    if (val.toLowerCase() == 'true') return true;
    if (val.toLowerCase() == 'false') return false;
    if (val == '1') return true;
    if (val == '0') return false;
  }
  return defValue;
}

String? convertToString(dynamic valArg, {String? defValue}) {
  if (valArg == null) return defValue;
  return valArg.toString();
}

Map<String, dynamic> convertToMap(dynamic valArg) {
  if (valArg == null) return {};
  if (valArg is Map<String, dynamic>) return valArg;
  if (valArg is String) {
    try {
      return jsonDecode(valArg) as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }
  return {};
}

List<T> convertToList<T>(dynamic valArg) {
  if (valArg == null) return [];
  if (valArg is List) return valArg.cast<T>();
  return [];
}
