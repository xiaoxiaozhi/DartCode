class People1{
  String? name;
  num _money =1000;

  set setName(String value) {
    this.name = value;
  }

  // getter
  String get getName {
    return 'titanjun';
  }

  People1() : name = "李四";
}