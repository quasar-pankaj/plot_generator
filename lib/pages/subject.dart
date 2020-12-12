import 'package:plot_generator/pages/plotto.dart';
import 'package:xml/xml.dart';

class Subject {
  Plotto _plotto;
  String number;
  String description;

  Subject(Plotto plotto, {this.number, this.description}) : _plotto = plotto;

  Subject.fromXml(Plotto plotto, XmlNode xmlNode) : _plotto = plotto {
    XmlNode subject = xmlNode.getElement("description");
    number = xmlNode.getAttribute("number");
    description = subject.text;
  }
}
