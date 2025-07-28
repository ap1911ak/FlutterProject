// 1. สัญญา (Abstraction/Interface)
abstract class ILogger {
  void log(String message);
}

// 2. สิ่งที่จะถูกฉีด (Implementation/Concrete Class)
class ConsoleLogger implements ILogger {
  @override
  void log(String message) {
    print('[Console] $message');
  }
}

// 3. สิ่งที่ต้องการ Dependency (Client)
class MyService {
  final ILogger _logger; // ประกาศว่าจะใช้ ILogger

  // ฉีด ILogger เข้ามาใน Constructor
  MyService(this._logger);

  void doSomething() {
    _logger.log('MyService is doing something.');
  }
}

// การใช้งาน:
// เพื่อให้โปรแกรมสามารถทำงานได้โดยสมบูรณ์ในฐานะ Dart script,
// การเรียกใช้ object และ method ต้องอยู่ภายในฟังก์ชัน `main`.
void main() {
  // สร้างสิ่งที่จะฉีด
  final logger = ConsoleLogger();
  // ฉีดเข้าไปใน MyService
  final myService = MyService(logger);
  myService.doSomething(); // Output: [Console] MyService is doing something.
}
