// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i5;
import 'package:hive_flutter/hive_flutter.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:location/location.dart' as _i6;
import 'package:mobile/common/helpers/dio.helper.dart' as _i8;
import 'package:mobile/data/datasources/local/user_local.datasource.dart'
    as _i7;
import 'package:mobile/data/datasources/remote/address.datasource.dart' as _i15;
import 'package:mobile/data/datasources/remote/campaign.datasource.dart'
    as _i17;
import 'package:mobile/data/datasources/remote/organization.datasource.dart'
    as _i9;
import 'package:mobile/data/datasources/remote/place.datasource.dart' as _i11;
import 'package:mobile/data/datasources/remote/user_remote.datasource.dart'
    as _i13;
import 'package:mobile/data/repositories/address.repository.dart' as _i16;
import 'package:mobile/data/repositories/campaign.repository.dart' as _i18;
import 'package:mobile/data/repositories/organization.repository.dart' as _i10;
import 'package:mobile/data/repositories/place.repository.dart' as _i12;
import 'package:mobile/data/repositories/user.repository.dart' as _i14;
import 'package:mobile/di/modules/local_module.dart' as _i19;
import 'package:mobile/di/modules/network_module.dart' as _i20;
import 'package:mobile/di/providers/dio_provider.dart' as _i4;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final localModule = _$LocalModule();
  final networkModule = _$NetworkModule();
  await gh.lazySingletonAsync<_i3.Box<dynamic>>(
    () => localModule.authBox,
    instanceName: 'user_box',
    preResolve: true,
  );
  gh.lazySingleton<_i4.DioProvider>(() =>
      _i4.DioProvider(userBox: gh<_i5.Box<dynamic>>(instanceName: 'user_box')));
  gh.lazySingleton<_i6.Location>(() => networkModule.provideLocation());
  gh.lazySingleton<_i7.UserLocalDataSource>(() => _i7.UserLocalDataSource(
      userBox: gh<_i5.Box<dynamic>>(instanceName: 'user_box')));
  gh.lazySingleton<_i8.DioHelper>(
      () => networkModule.provideDioHelper(gh<_i4.DioProvider>()));
  gh.lazySingleton<_i9.OrganizationDataSource>(() => _i9.OrganizationDataSource(
        dioHelper: gh<_i8.DioHelper>(),
        userBox: gh<_i5.Box<dynamic>>(instanceName: 'user_box'),
      ));
  gh.lazySingleton<_i10.OrganizationRepository>(() =>
      _i10.OrganizationRepository(
          dataSource: gh<_i9.OrganizationDataSource>()));
  gh.lazySingleton<_i11.PlaceDataSource>(
      () => _i11.PlaceDataSource(dioHelper: gh<_i8.DioHelper>()));
  gh.lazySingleton<_i12.PlaceRepository>(
      () => _i12.PlaceRepository(placeDataSource: gh<_i11.PlaceDataSource>()));
  gh.lazySingleton<_i13.UserRemoteDataSource>(
      () => _i13.UserRemoteDataSource(dioHelper: gh<_i8.DioHelper>()));
  gh.lazySingleton<_i14.UserRepository>(() => _i14.UserRepository(
        dataSource: gh<_i13.UserRemoteDataSource>(),
        localDataSource: gh<_i7.UserLocalDataSource>(),
      ));
  gh.lazySingleton<_i15.AddressDataSource>(
      () => _i15.AddressDataSource(dioHelper: gh<_i8.DioHelper>()));
  gh.lazySingleton<_i16.AddressRepository>(
      () => _i16.AddressRepository(dataSource: gh<_i15.AddressDataSource>()));
  gh.lazySingleton<_i17.CampaignDataSource>(
      () => _i17.CampaignDataSource(dioHelper: gh<_i8.DioHelper>()));
  gh.lazySingleton<_i18.CampaignRepository>(
      () => _i18.CampaignRepository(dataSource: gh<_i17.CampaignDataSource>()));
  return getIt;
}

class _$LocalModule extends _i19.LocalModule {}

class _$NetworkModule extends _i20.NetworkModule {}
