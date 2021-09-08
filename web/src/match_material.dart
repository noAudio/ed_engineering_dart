import 'generate_material_list.dart';
import 'material.dart';

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
