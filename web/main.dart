import 'dart:html';

import 'src/dom_manipulation.dart';

void main() {
  (querySelector('#calculate') as ButtonElement).onClick.listen(read_textarea);
}
