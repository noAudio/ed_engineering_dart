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
