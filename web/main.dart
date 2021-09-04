import 'dart:html';

void main() {
  querySelector('#output')?.text = 'Your Dart app is running.';
}

class Material {
  String name;
  String grade;
  int amount;

  Material(
    this.name,
    this.grade,
    this.amount,
  );
}

class Module {
  String name;
  String engineer;
  List<Material> materials;

  Module(
    this.name,
    this.engineer,
    this.materials,
  );
}
