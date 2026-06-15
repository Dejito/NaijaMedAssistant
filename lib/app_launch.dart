import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:naija_med_assistant/presentation/di/di.dart';

import 'dart:async';

import 'core/bloc_observer/bloc_observer.dart';
import 'core/storage/local_storage_utils.dart';

GetIt getIt = GetIt.instance;

class AppLaunch {

  Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Bloc.observer = MyGlobalObserver();
    getIt.allowReassignment = true;
    await registerServices(getIt);
    ScreenUtil.ensureScreenSize();
    await LocalStorageUtils().init();

  }

  Future<void> registerServices(ioc) async {
    setUpEndpointCalls();
    setupAuthToken(ioc);
    // setupSharedServices(ioc);
  }
}

