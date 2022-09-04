import 'package:plot_generator/pages/xml_plotto.dart';
import 'package:xml/xml.dart';

class Outcome {
  XmlPlotto _plotto;
  String number;
  String description;

  Outcome(XmlPlotto plotto, {this.number, this.description}) : _plotto = plotto;

  Outcome.fromXml(XmlPlotto plotto, XmlNode xmlNode) : _plotto = plotto {
    number = xmlNode.getAttribute("number");
    description = xmlNode.getElement("description").text;
  }
}
