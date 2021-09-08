import 'dart:html';

import 'match_material.dart';
import 'material.dart';

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
