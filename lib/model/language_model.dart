class LanguageModel {
  String titleId;
  String languageCode;
  String countryCode;
  bool isSelected;

  LanguageModel(this.titleId, this.languageCode, this.countryCode,
      {this.isSelected: false});

  LanguageModel.fromJson(Map<String, dynamic> json)
      : titleId = json['titleId'],
        languageCode = json['languageCode'],
        countryCode = json['countryCode'],
        isSelected = json['isSelected'];

  Map<String, dynamic> toJson() => {
        'titleId': titleId,
        'languageCode': languageCode,
        'countryCode': countryCode,
        'isSelected': isSelected,
      };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"titleId\":\"$titleId\"");
    sb.write(",\"languageCode\":\"$languageCode\"");
    sb.write(",\"countryCode\":\"$countryCode\"");
    sb.write('}');
    return sb.toString();
  }
}