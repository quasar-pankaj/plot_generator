import 'package:plot_generator/pages/plotto.dart';
import 'package:xml/xml.dart';

class Character {
  Plotto _plotto;
  String designation;
  Sex sex;
  String description;

  Character(
    Plotto plotto, {
    this.designation,
    this.sex,
    this.description,
  }) : _plotto = plotto;

  Character.fromXml(Plotto plotto, XmlNode xmlNode) : _plotto = plotto {
    designation = xmlNode.getAttribute("designation");
    String gender = xmlNode.getAttribute("sex");
    switch (gender) {
      case "male":
        sex = Sex.male;
        break;
      case "female":
        sex = Sex.female;
        break;
      case "any":
        sex = Sex.any;
        break;
      case "none":
        sex = Sex.none;
        break;
    }
    description = xmlNode.text;
  }
}

enum Sex { male, female, any, none }
