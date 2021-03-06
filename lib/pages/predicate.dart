import 'package:plot_generator/pages/conflict.dart';
import 'package:plot_generator/pages/plotto.dart';
import 'package:xml/xml.dart';

import 'conflict_reference.dart';

class Predicate {
  Plotto _plotto;
  String number;
  String description;
  List<ConflictLink> links;

  Predicate(Plotto plotto, {this.number, this.description, this.links})
      : _plotto = plotto;

  Predicate.fromXml(Plotto plotto, XmlNode xmlNode) : _plotto = plotto {
    number = xmlNode.getAttribute("number");
    description = xmlNode.getElement("description").text;
    final nodes = xmlNode.findElements("conflict-link");
    links = nodes.map((node) => ConflictLink.fromXml(_plotto, node)).toList();
  }

  Conflict followup(){
    final n = _plotto.getRandom(links.length);
    final g = links[n];
    return _plotto.conflicts.singleWhere((element) => element.id == g.ref);
  }
}
