import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/language/ar.dart';
import 'package:wowondertimelineflutterapp/language/en.dart';
import 'package:wowondertimelineflutterapp/language/fr.dart';
import 'package:wowondertimelineflutterapp/language/ru.dart';

import '../../language/bn.dart';
import '../../language/da.dart';
import '../../language/de.dart';
import '../../language/es.dart';
import '../../language/fa.dart';
import '../../language/hi.dart';
import '../../language/hr.dart';
import '../../language/id.dart';
import '../../language/it.dart';
import '../../language/ko.dart';
import '../../language/nl.dart';
import '../../language/pt.dart';
import '../../language/sv.dart';
import '../../language/tr.dart';
import '../../language/ur.dart';
import '../../language/vi.dart';
import '../../language/zh.dart';
import '../../language/fi.dart';

///Example ara Arabic
// Emoje flags   https://emojipedia.org/flags/.

String languagedefault = eng;
String arabic = "Arabic 🇸🇦";
String bengali = "Bengali 🇧🇩";
String chinese = "Chinese 🇨🇳";
String croatian = "Croatian 🇭🇷";
String danish = "Danish 🇩🇰";
String dutch = "Dutch 🇳🇱";
String english = "English 🇬🇧";
String filipino = "Filipino 🇵🇭";
String french = "French 🇫🇷";
String german = "German 🇩🇪";
String hindi = "Hindi 🇮🇳";
String indonesian = "Indonesian 🇮🇩";
String italian = "Italian 🇮🇹";
String korean = "Korean 🇰🇷";
String persian = "Persian 🇮🇷";
String portuguese = "Portuguese 🇵🇹";
String russian = "Russian 🇷🇺";
String spanish = "Spanish 🇪🇸";
String swedish = "Swedish 🇸🇪";
String turkish = "Turkish 🇹🇷";
String urdu = "Urdu 🇵🇰";
String vietnamese = "Vietnamese 🇻🇳";

////
String ara = "ar";
String ben = "bn";
String zho = "zh";
String hrv = "hr";
String dan = "da";
String nld = "nl";
String eng = "en";
String fil = "fi";
String fra = "fr";
String deu = "de";
String hin = "hi";
String ind = "id";
String ita = "it";
String kor = "ko";
String per = "fa";
String por = "pt";
String rus = "ru";
String spa = "es";
String swe = "sv";
String tur = "tr";
String urd = "ur";
String vie = "vi";

////////////////////////////////////////

class LocaliztionApp extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        ara: ar,
        ben: bn,
        zho: zh,
        hrv: hr,
        dan: da,
        nld: nl,
        eng: en,
        fil: fi,
        fra: fr,
        deu: de,
        hin: hi,
        ind: id,
        ita: it,
        kor: ko,
        per: fa,
        por: pt,
        rus: ru,
        spa: es,
        swe: sv,
        tur: tr,
        urd: ur,
        vie: vi,
      };
}
