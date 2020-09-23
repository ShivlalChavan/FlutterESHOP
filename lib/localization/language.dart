class Language {

  final int id;
  final String flag;
  final String name;
  final String langaugeCode;

  Language(this.id,this.flag,this.name,this.langaugeCode);

  static List<Language> languageList() {
    return <Language>[
    Language(1,"US","English",'en'),
    Language(2,"IN","हिंदी",'hi'),
    Language(3,"IN","मराठी",'mr')
    ];
  }
}