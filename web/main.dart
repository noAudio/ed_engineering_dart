import 'dart:convert';
import 'dart:html';

import 'data_json.dart';

void main() {
  (querySelector('#calculate') as ButtonElement).onClick.listen(read_textarea);
}

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

/// The `Material` class defines the properties that
/// are needed to create a defined material object.
///
/// `name` is the unique identifier of the material,
/// e.g `Untipycal Wake Scans`, and is of type String.
///
/// `grade` refers to the rarity of the material and
/// is of type int ranging from 1 to 5.
///
/// `section` refers to the category in which the material
/// is sorted into at the Material Trader screen in-game,
/// e.g `Wake Scans`, and is of type String.
///
/// `kind` refers to the material type, e.g. `Encoded`,
/// and is of type String.
///
/// `amount` refers to the user defined number of materials
/// that are to be collected, and is of type int?.
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

/// Accepts a material name from the textarea and
/// compares it to the generated list of materials
/// generated from `generateMaterialList()`. If the
/// given material name matches a `Material` object
/// in the list that object gets returned.
Material? matched_material(String material_name) {
  var material_list = generateMaterialList();
  try {
    for (var mat in material_list) {
      if (mat.name.replaceAll(' ', '') == material_name) {
        return mat;
      }
    }
  } catch (e) {
    print(e);
  }
}

/// Reads the content of the textarea and passes
/// it on to the `populateAccordion()` function
/// after a null check.
void read_textarea(Event event) {
  var textarea = querySelector('#materials') as TextAreaElement;
  var text = textarea.value;
  var content = [];
  if (text != null) {
    content = text.split('\n');
    populateAccordion(content);
  }
}

/// Accepts a list of strings from the text area and
/// populates the html accordions with the corresponding
/// `Material` objects.
void populateAccordion(List<dynamic> materials) async {
  var raw_accordion = querySelector('#raw-body') as DivElement;
  var encoded_accordion = querySelector('#encoded-body') as DivElement;
  var manufactured_accordion =
      querySelector('#manufactured-body') as DivElement;

  for (dynamic material in materials) {
    if (!material.isEmpty && material != null) {
      if (!material.contains(':')) {
        // checking the format of the text and break when the formatting criteria is not met
        (querySelector('.title') as HeadingElement)
            .children
            .add(ParagraphElement()
              ..id = 'info'
              ..classes.addAll(['text-muted', 'mark', 'small'])
              ..text = 'Please enter a valid material (ie Material: Amount)');
        await Future.delayed(const Duration(seconds: 3));
        (querySelector('#info') as ParagraphElement).remove();
        break;
      }
      var split_string = material.split(':');

      String material_name = split_string[0].replaceAll(' ', '');
      var material_amount = int.parse(split_string[1]);

      var matching_material = matched_material(material_name) as Material;
      matching_material.amount = material_amount;
      if (matching_material.kind == 'Encoded') {
        var partialID = matching_material.name.replaceAll(' ', '-');
        encoded_accordion.children.add(DivElement()
          ..classes.add('form-check')
          ..id = partialID
          ..children.addAll([
            CheckboxInputElement()
              ..id = partialID + '-checkbox'
              ..classes.add('form-check-input'),
            LabelElement()
              ..text = matching_material.name +
                  ': ' +
                  matching_material.amount.toString() +
                  ' (${matching_material.section})'
              ..htmlFor = partialID + '-checkbox'
              ..classes.add('form-check-label')
              ..id = partialID + '-label'
              ..onClick.listen((event) {
                (querySelector('#${partialID + "-label"}') as LabelElement)
                    .classes
                    .toggle('completed');
              })
          ]));
      } else if (matching_material.kind == 'Manufactured') {
        var partialID = matching_material.name.replaceAll(' ', '-');
        manufactured_accordion.children.add(DivElement()
          ..classes.add('form-check')
          ..id = partialID
          ..children.addAll([
            CheckboxInputElement()
              ..id = partialID + '-checkbox'
              ..classes.add('form-check-input'),
            LabelElement()
              ..text = matching_material.name +
                  ': ' +
                  matching_material.amount.toString() +
                  ' (${matching_material.section})'
              ..htmlFor = partialID + '-checkbox'
              ..classes.add('form-check-label')
              ..id = partialID + '-label'
              ..onClick.listen((event) {
                (querySelector('#${partialID + "-label"}') as LabelElement)
                    .classes
                    .toggle('completed');
              })
          ]));
      } else if (matching_material.kind == 'Raw') {
        var partialID = matching_material.name.replaceAll(' ', '-');
        raw_accordion.children.add(DivElement()
          ..classes.add('form-check')
          ..children.addAll([
            CheckboxInputElement()
              ..id = partialID + '-checkbox'
              ..classes.add('form-check-input'),
            LabelElement()
              ..text = matching_material.name +
                  ': ' +
                  matching_material.amount.toString() +
                  ' (${matching_material.section})'
              ..htmlFor = partialID + '-checkbox'
              ..classes.add('form-check-label')
              ..id = partialID + '-label'
              ..onClick.listen((event) {
                (querySelector('#${partialID + "-label"}') as LabelElement)
                    .classes
                    .toggle('completed');
              })
          ]));
      }
    }
  }
}
