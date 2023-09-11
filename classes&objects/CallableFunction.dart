/// 类中声明call方法,不需要
/// 将类的实例用作函数会自动调用call方法
///
main() {
  ApplePhone()("123");
}

class ApplePhone {
  call(String num) {
    print('phone num is $num');
  }
}
