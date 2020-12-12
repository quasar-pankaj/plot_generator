import 'package:plot_generator/pages/plotto.dart';
import 'package:xml/xml.dart';

class Outcome {
  Plotto _plotto;
  String number;
  String description;

  Outcome(Plotto plotto, {this.number, this.description}) : _plotto = plotto;

  Outcome.fromXml(Plotto plotto, XmlNode xmlNode) : _plotto = plotto {
    number = xmlNode.getAttribute("number");
    description = xmlNode.getElement("description").text;
  }
}
