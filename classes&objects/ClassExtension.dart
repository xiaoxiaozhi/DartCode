/// 扩展类
/// extension 扩展类名 on 被扩展的类{扩展内容}
/// 1. 扩展内部类
/// 2. 扩展自定义类
///
class AA {
  say() {
    print('你好');
  }
}

main() {
  //1.
  print("${"123".parseInt()}");
  //2.
  print('${AA().eat()}');
}

// 1.扩展内部类
extension StringExtension on String {
  //字符串转整形
  parseInt() {
    return int.parse(this);
  }
}

//2.扩展自定义类
extension PersonExtension on AA {
  eat() {
    print('吃嘛嘛香');
  }
}
