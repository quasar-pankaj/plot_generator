import 'package:plot_generator/pages/plotto.dart';
import 'package:xml/xml.dart';

class ConflictLink {
  Plotto _plotto;
  String ref;
  String category;
  String subcategory;
  String permutation;
  String option;

  ConflictLink(
    Plotto plotto, {
    this.ref,
    this.category,
    this.subcategory,
    this.permutation,
    this.option,
  }) : _plotto = plotto;

  ConflictLink.fromXml(Plotto plotto, XmlNode xmlNode) : _plotto = plotto {
    ref = xmlNode.getAttribute("ref");
    category = xmlNode.getAttribute("category");
    subcategory = xmlNode.getAttribute("subcategory");
    permutation = xmlNode.getAttribute("permutations");
    option = xmlNode.getAttribute("option");
  }

  factory ConflictLink.createFromXml(Plotto plotto, XmlNode node) {
    if (node.children.length > 0) {
      return TransformableLink.fromXml(plotto, node);
    } else {
      return ConflictLink.fromXml(plotto, node);
    }
  }
}

class TransformableLink extends ConflictLink {
  Map<String, String> transform;
  List<String> add;
  List<String> remove;

  TransformableLink(
    Plotto plotto, {
    ref,
    category,
    subcategory,
    this.transform,
    this.add,
    this.remove,
  }) : super(plotto, ref: ref, category: category, subcategory: subcategory);

  TransformableLink.fromXml(Plotto plotto, XmlNode xmlNode)
      : super.fromXml(plotto, xmlNode) {
    final tnodes = xmlNode.findElements("transform");
    final anodes = xmlNode.findElements("add");
    final snodes = xmlNode.findElements("remove");

    transform = Map<String, String>.fromIterable(
      tnodes,
      key: (item) => item.getAttribute("from"),
      value: (item) => item.getAttribute("to"),
    );
    if (anodes != null) {
      add = anodes.map((e) => e.text).toList();
    }
    if (snodes != null) {
      remove = snodes.map((e) => e.text).toList();
    }
  }

  String rectify(String text) {
    String copy = text;
    if (transform != null && transform.isNotEmpty) {
      for (final key in transform.keys) {
        copy = copy.replaceAll(key, transform[key]);
      }
    }

    if (add != null && add.isNotEmpty) {
      copy += add.reduce((value, element) => value + element);
    }

    if (remove != null && remove.isNotEmpty) {
      for (String s in remove) {
        copy = copy.replaceAll(s, "");
      }
    }

    return copy;
  }
}
