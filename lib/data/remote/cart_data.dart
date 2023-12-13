import '../../core/services/dependency_injection.dart';
import '../crud_dio.dart';

class CartRemoteData {
  final _crud = AppInjection.getIt<Crud>();
}
