import 'dart:convert';

import '../data_json.dart';
import 'material.dart';

/// Generates a list of `Material` objects from
/// predefined json of materials from Inara.
/// The list is then returned and can be used
/// for comparison with the text obtained from
/// the textarea.
List<Material> generateMaterialList() {
  var processed_data = json.decode(unprocessed);
  var newlist = [] as List<Material>;
  for (var mat in processed_data) {
    newlist
        .add(Material(mat['name'], mat['grade'], mat['section'], mat['kind']));
  }
  return newlist;
}
