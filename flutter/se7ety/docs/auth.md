# Authentication in Se7ety

Se7ety uses Firebase Authentication for email and password accounts. Cloud Firestore stores each account’s role (`patient` or `doctor`) and profile. The Firebase Authentication UID links these records.

## Entry point and form validation

`main.dart` initializes Firebase before the app starts. On the welcome screen, choosing **Doctor** or **Patient** opens `/login` with a `UserTypeEnum` passed through GoRouter’s `state.extra`. Switching between `/login` and `/register` replaces the current route and forwards the same role. Each route creates its own `AuthCubit`, which owns the form key and text controllers. See [app startup](../lib/main.dart), the [welcome screen](../lib/features/intro/welcome/welcome_screen.dart), and the [route definitions](../lib/core/routes/routes.dart).

Both forms require a nonempty email that passes `AppRegex.isEmailValid` and a nonempty password. Registration also requires a nonempty name. The screen calls the cubit after validation passes. Firebase Authentication enforces the password policy at registration.

## Registration

1. `RegisterScreen` calls `AuthCubit.register(userType)` with the role chosen on the welcome screen. The cubit emits `AuthLoadingState`.
2. The cubit calls `createUserWithEmailAndPassword`. With the returned Firebase user, it starts the display-name update and requests a verification email. Both calls run without being awaited.
3. The cubit awaits the write to `users/{uid}` with the account details and the role string. It then awaits the write to `doctor/{uid}` or `patient/{uid}` using the same UID.
4. Once both Firestore writes finish, the cubit emits `AuthSuccessState(userType: userType)`.

| Firestore document | What registration writes |
| --- | --- |
| `users/{uid}` | The UID, email, name, `userType` (`doctor` or `patient`), and `image` set to `null`. Login reads the role from this document. |
| `doctor/{uid}` | The UID, email, and name. Additional profile fields such as `specialization`, `phone1`, and `address` start as `null`. |
| `patient/{uid}` | The UID, email, and name. Additional profile fields such as `age`, `phone`, and `city` start as `null`. |

`FirestoreProvider` serializes each model with `toJson()` and writes the document with `set()`. See the [Firestore provider](../lib/core/services/firebase/firestore_provider.dart) and the [user](../lib/features/auth/data/models/user_model.dart), [doctor](../lib/features/auth/data/models/doctor_model.dart), and [patient](../lib/features/auth/data/models/patient_model.dart) models.

## Login

1. `LoginScreen` calls `AuthCubit.login()`. The cubit emits `AuthLoadingState` and calls `signInWithEmailAndPassword`.
2. After Firebase Authentication returns a user, the cubit passes the UID to `FirestoreProvider.getUserById` to read `users/{uid}`.
3. `UserTypeEnum.fromString` converts the stored `userType` into `AuthSuccessState.userType`. The role passed to `/login` controls the heading and carries through to the registration link. The success state uses the stored role even if the heading shows a different one.
4. A missing user document, a missing or unrecognized role string, or a read exception that the provider converts to `null` produces a successful login with the `patient` fallback.

See [AuthCubit](../lib/features/auth/presentation/cubit/auth_cubit.dart) and [UserTypeEnum](../lib/core/presentation/enum/user_enum.dart).

## Loading, errors, and navigation

Both screens listen to `AuthCubit`. Loading opens a dialog. Failure closes it and shows an Arabic message in a snackbar. Success closes the dialog. See the [auth state definitions](../lib/features/auth/presentation/cubit/auth_state.dart).

| Operation | Firebase Auth error codes with a specific message |
| --- | --- |
| Login | `user-not-found` and `wrong-password`. A null Firebase user also shows the user-not-found message. |
| Registration | `weak-password` and `email-already-in-use`. |

Other caught errors show a generic Arabic message. See the [login screen](../lib/features/auth/presentation/page/login_screen.dart), [registration screen](../lib/features/auth/presentation/page/register_screen.dart), and [dialog helpers](../lib/components/dialogs.dart).

## Current limits

- Successful login currently leaves the user on the form. Doctor registration opens `/doctorRegistration`. Patient registration targets `/mainPatient`, which still needs a registered page. `/mainDoctor` also still needs a registered page.
- Login currently allows unverified email accounts. Registration success confirms the Firestore writes finished, while the verification email request runs separately.
- Splash checks `FirebaseAuth.instance.currentUser`. Signed-out users go to onboarding or Welcome based on the saved onboarding flag. For signed-in users, `SplashCubit` reads `users/{uid}` and uses the same role conversion as login. Doctors with an incomplete profile go to doctor registration. Patients and doctors with complete profiles go to Welcome until their home routes are registered. See [SplashCubit](../lib/features/intro/splash/cubit/splash_cubit.dart).
- Account creation and the two Firestore writes run separately. If a Firestore write fails, registration shows an error and can leave an existing Firebase Authentication account with an incomplete profile.
