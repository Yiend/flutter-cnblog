import 'package:cnblog/model/enums.dart';
import 'package:cnblog/model/questions_model.dart';
import 'package:cnblog/utils/http_util.dart';

class QuestionsService {
  /* 
   *获取提问
   */
  Future<List<Questions>> getQuestions(QuestionsType type,
      {int pageIndex, int pageSize = 10}) async {
    String url = "";
    switch (type) {
      case QuestionsType.nosolved:
        url = "api/questions/@sitehome?pageIndex=$pageIndex&pageSize=$pageSize";
        break;
      case QuestionsType.highscore:
        url =
            "api/questions/@highscore?pageIndex=$pageIndex&pageSize=$pageSize";
        break;
      case QuestionsType.noanswer:
        url = "api/questions/@noanswer?pageIndex=$pageIndex&pageSize=$pageSize";
        break;
      case QuestionsType.solved:
        url = "api/questions/@solved?pageIndex=$pageIndex&pageSize=$pageSize";
        break;
      case QuestionsType.myquestion:
        url =
            "api/questions/@myquestion?pageIndex=$pageIndex&pageSize=$pageSize";
        break;
      default:
        url = "api/questions/@sitehome?pageIndex=$pageIndex&pageSize=$pageSize";
        break;
    }

    List<Questions> modules = [];
    var result = await HttpUtil.instance.doGet(url);
    result.data.forEach((data) {
      modules.add(Questions.fromJson(data));
    });

    return modules;
  }

}
