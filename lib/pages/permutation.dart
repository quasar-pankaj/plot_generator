import 'package:plot_generator/pages/conflict.dart';
import 'package:plot_generator/pages/group.dart';
import 'package:plot_generator/pages/plotto.dart';
import 'package:xml/xml.dart';

class Permutation {
  Plotto _plotto;
  String number;
  String description;
  List<String> characters;
  List<Group> includes;
  List<String> options;

  Permutation(
    Plotto plotto, {
    this.number,
    this.description,
    this.characters,
    this.includes,
    this.options,
  }) : _plotto = plotto;

  Permutation.fromXml(Plotto plotto, XmlNode node) : _plotto = plotto {
    number = node.getAttribute("number");
    description = node.innerText;
    final chnodes = node.findElements("character-link");
    characters = chnodes.map((e) => e.getAttribute("ref")).toList();
    final incnode = node.getElement("includes");
    if (incnode != null) {
      final children = incnode.findElements("group");
      includes = children.map((node) => Group.fromXml(_plotto, node)).toList();
    }
    final options = node.findElements("option");
    this.options = options.map((e) => e.text).toList();
  }

  String getOption(String ref) {
    return options[int.parse(ref) - 1];
  }
}
