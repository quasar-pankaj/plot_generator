import 'package:plot_generator/pages/group.dart';
import 'package:plot_generator/pages/permutation.dart';
import 'package:plot_generator/pages/xml_plotto.dart';
import 'package:plot_generator/pages/random_mixin.dart';
import 'package:xml/xml.dart';

class Conflict with RandomMixin {
  XmlPlotto _plotto;
  String id;
  String category;
  String subcategory;
  List<Permutation> permutations;
  List<Group> leadups;
  List<Group> carryons;

  Conflict(
    XmlPlotto plotto, {
    this.id,
    this.category,
    this.subcategory,
    this.permutations,
    this.leadups,
    this.carryons,
  }) : _plotto = plotto;

  Conflict.fromXml(XmlPlotto plotto, XmlNode node) : _plotto = plotto {
    id = node.getAttribute("id");
    category = node.getAttribute("category");
    subcategory = node.getAttribute("subcategory");
    final permnode = node.getElement("permutations");
    final pchildren = permnode.findElements("permutation");
    permutations =
        pchildren.map((node) => Permutation.fromXml(_plotto, node)).toList();
    final carrynodes =
        node.findElements("carry-ons").first.findElements("group");
    final leadnodes = node.findElements("lead-ups").first.findElements("group");
    leadups = leadnodes.map((node) => Group.fromXml(_plotto, node)).toList();
    carryons = carrynodes.map((node) => Group.fromXml(_plotto, node)).toList();
  }

  Permutation getPermutationById(String id) {
    return permutations.singleWhere((element) => element.number == id);
  }

  Group get leadupList {
    return leadups[getRandom(leadups.length)];
  }

  Group get carryonList {
    return carryons[getRandom(carryons.length)];
  }
}
