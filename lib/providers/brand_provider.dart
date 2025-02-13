import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../apis/api.dart';

final brandProvider = FutureProvider((ref) async {
  return await Api.fetchBrands();
});