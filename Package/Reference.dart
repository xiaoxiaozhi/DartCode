import 'lib/MyCustom.dart';
import 'dart:math';
import 'dart:core'; //默认引入
import 'lib/Common.dart' hide f1;//一起使用的时候 隐藏不了f1
import 'lib/Common.dart' show f1 ;
import 'lib/Function.dart' as func;//3.3
import 'lib/Deferred.dart' deferred as def;//3.4
import 'lib/Util.dart';//3.5



/// 1.自定义库 (import '库位置/库名称.dart')
/// 2.系统库 (import 'dart:库名称')
/// 3.引入部分库
///   show包含引入 (这个库文件包含了很多方法，不是一个类文件)
///   hide排除引入
///   引入冲突 引入的库具有相同名称的属性和方法会引起冲突，使用as关键字 增加前缀解决冲突
///   延迟加载 deferred as  需要调用loadLibrary 加载库，这是异步过程
///   part和part of 有时候库文件太多要分好多文件加载这时候使用，在分库中使用part of 主库  让分库和主库建立联系。在主库中part 分库名 引入分库
///                 在main方法中可以使用来主库和分库的文件
///   3.6 第三方库 在文件夹下创建pubspec.yaml 声明第三方依赖库 执行pub get安装  在项目中引入已经安装的第三方库 import 'package:xxx/xxx.dart';
///       第三方库的结构，必须包含一个pubspec.yaml   详情 https://dart.cn/tools/pub/pubspec
///       项目本身就是一个包
main() {
  // var mc = MyCustom();
  // mc.info();
  f1();
  //3.3
  func.f1();
  // def.loadLibrary();
  // def.f3();
  hello();
}
