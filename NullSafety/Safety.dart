///由于dart的安全性检查 dart认为所有的变量都不能为null，所以必须赋值(类中声明的变量必须赋值否则就要用可空类型声明)只有可空类型才可以赋值null
main() {
  var coffee = Coffee();
  print(coffee.temperature);//late修饰符除了让编译器不报错之外，还有什么用处，调用的时候还是抛出异常
}

class Coffee {
  late String temperature;

  void heat() {
    temperature = 'hot';
  }

  void chill() {
    temperature = 'iced';
  }

  String serve() => temperature + ' coffee';
}
