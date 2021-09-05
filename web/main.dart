import 'dart:convert';
import 'dart:html';

import 'data_json.dart';

void main() {
  var button = querySelector('#calculate') as ButtonElement;
  button.onClick.listen(read_textarea);
}

List<Material> generateMaterialList() {
  var processed_data = json.decode(unprocessed);
  var newlist = [Material('Test', 1, 'idk', 'idk')];
  for (var mat in processed_data) {
    newlist
        .add(Material(mat['name'], mat['grade'], mat['section'], mat['kind']));
  }
  return newlist;
}

class Material {
  String name;
  int grade;
  String section;
  String kind;
  int? amount;

  Material(
    this.name,
    this.grade,
    this.section,
    this.kind,
  );
}

Material? matched_material(String material_name) {
  var material_list = generateMaterialList();
  try {
    for (var mat in material_list) {
      if (mat.name == material_name) {
        return mat;
      }
    }
  } catch (e) {
    print(e);
  }
}

void read_textarea(Event event) {
  var textarea = querySelector('#materials') as TextAreaElement;
  var text = textarea.value;
  var content = [];
  if (text != null) {
    content = text.split('\n');
    populate_accordion(content);
  }
}

void populate_accordion(List<dynamic> materials) {
  var raw_accordion = querySelector('#raw-body') as DivElement;
  var encoded_accordion = querySelector('#encoded-body') as DivElement;
  var manufactured_accordion =
      querySelector('#manufactured-body') as DivElement;

  for (dynamic material in materials) {
    if (!material.isEmpty) {
      var split_string = material.split(':');
      print(split_string);
      var material_name = split_string[0];
      var material_amount = int.parse(split_string[1]);
      var matching_material = matched_material(material_name) as Material;
      matching_material.amount = material_amount;
      if (matching_material.kind == 'Encoded') {
        encoded_accordion.children.add(ParagraphElement()
          ..text = matching_material.name +
              ': ' +
              matching_material.amount.toString());
      } else if (matching_material.kind == 'Manufactured') {
        manufactured_accordion.children.add(ParagraphElement()
          ..text = matching_material.name +
              ': ' +
              matching_material.amount.toString());
      } else if (matching_material.kind == 'Raw') {
        raw_accordion.children.add(ParagraphElement()
          ..text = matching_material.name +
              ': ' +
              matching_material.amount.toString());
      }
    }
  }
}
