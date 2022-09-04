import 'package:plot_generator/pages/xml_plotto.dart';
import 'package:xml/xml.dart';

class Subject {
  XmlPlotto _plotto;
  String number;
  String description;

  Subject(XmlPlotto plotto, {this.number, this.description}) : _plotto = plotto;

  Subject.fromXml(XmlPlotto plotto, XmlNode xmlNode) : _plotto = plotto {
    XmlNode subject = xmlNode.getElement("description");
    number = xmlNode.getAttribute("number");
    description = subject.text;
  }
}
