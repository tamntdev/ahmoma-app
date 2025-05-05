import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ahmoma_app/utils/constants/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'network_manager_state.dart';

class NetworkManagerCubit extends Cubit<NetWorkMangerState> {
  NetworkManagerCubit()
    : super(const NetWorkMangerState(ConnectivityStatus.disconnected));

  void checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    _updateConnectivityStatus(connectivityResult);
  }

  void _updateConnectivityStatus(List<ConnectivityResult> result) async {
    if (result.contains(ConnectivityResult.none)) {
      emit(const NetWorkMangerState(ConnectivityStatus.disconnected));
    } else {
      emit(const NetWorkMangerState(ConnectivityStatus.connected));
    }
  }

  late StreamSubscription<List<ConnectivityResult>?> _subscription;

  void trackConnectivityChange() {
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      _updateConnectivityStatus(result);
    });
  }

  void disposeTrackNetwork() {
    _subscription.cancel();
  }
}
