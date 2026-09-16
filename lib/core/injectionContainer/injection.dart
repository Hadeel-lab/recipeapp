import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

// Authentication
import '../../presentation/authentication/data/data_source/auth_remote_datasource.dart';
import '../../presentation/authentication/data/repositories/auth_repository_impl.dart';
import '../../presentation/authentication/domain/repositories/auth_repository.dart';
import '../../presentation/authentication/domain/usecases/register_with_email.dart';
import '../../presentation/authentication/domain/usecases/sign_in_with_email.dart';
import '../../presentation/authentication/domain/usecases/sign_in_with_google.dart';
import '../../presentation/authentication/features/bloc/auth_bloc.dart';

// Recipes
import '../../presentation/health_recipe/data/datasources/recipe_remote_datasource.dart';
import '../../presentation/health_recipe/data/repositories/recipe_repository_impl.dart';
import '../../presentation/health_recipe/domain/repositories/recipe_repository.dart';
import '../../presentation/health_recipe/domain/usecases/get_recipes.dart';
import '../../presentation/health_recipe/features/bloc/recipe_bloc.dart';

// Core
import '../network/dio_client.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  sl.registerLazySingleton<DioClient>(() => DioClient());

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(firebaseAuth: sl<FirebaseAuth>()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
  );

  sl.registerLazySingleton<SignInWithGoogle>(
    () => SignInWithGoogle(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<SignInWithEmail>(
    () => SignInWithEmail(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<RegisterWithEmail>(
    () => RegisterWithEmail(sl<AuthRepository>()),
  );

  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      signInWithGoogle: sl<SignInWithGoogle>(),
      signInWithEmail: sl<SignInWithEmail>(),
      registerWithEmail: sl<RegisterWithEmail>(),
    ),
  );

  sl.registerLazySingleton<RecipeRemoteDataSource>(
    () => RecipeRemoteDataSource(dioClient: sl<DioClient>()),
  );

  sl.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImpl(sl<RecipeRemoteDataSource>()),
  );

  sl.registerLazySingleton<GetRecipes>(
    () => GetRecipes(sl<RecipeRepository>()),
  );

  sl.registerFactory<RecipeBloc>(
    () => RecipeBloc(getRecipes: sl<GetRecipes>()),
  );
}
