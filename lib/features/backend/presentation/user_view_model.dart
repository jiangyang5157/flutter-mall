import 'package:flutter/material.dart';
import 'package:mall/core/usecase/usecase.dart';
import 'package:mall/features/backend/data/models/user_model.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';
import 'package:mall/features/backend/domain/usecases/user/usecases.dart'
as User;
import 'package:parse_server_sdk/parse_server_sdk.dart';

class UserViewModel extends ChangeNotifier {
  final User.GetData _getData;
  final User.SetDisplayImagePath _setDisplayImagePath;
  final User.SetEmailAddress _setEmailAddress;
  final User.SetName _setName;
  final User.SetPassword _setPassword;
  final User.SetType _setType;
  final User.Destroy _destroy;
  final User.Save _save;
  final User.SignIn _signIn;
  final User.SignInAnonymous _signInAnonymous;
  final User.SignOut _signOut;
  final User.SignUp _signUp;

  UserModel _currentUserModel;

  UserViewModel({
    @required User.GetData getData,
    @required User.SetDisplayImagePath setDisplayImagePath,
    @required User.SetEmailAddress setEmailAddress,
    @required User.SetName setName,
    @required User.SetPassword setPassword,
    @required User.SetType setType,
    @required User.Destroy destroy,
    @required User.Save save,
    @required User.SignIn signIn,
    @required User.SignInAnonymous signInAnonymous,
    @required User.SignOut signOut,
    @required User.SignUp signUp,
  })
      : assert(getData != null),
        assert(setDisplayImagePath != null),
        assert(setEmailAddress != null),
        assert(setName != null),
        assert(setPassword != null),
        assert(setType != null),
        assert(destroy != null),
        assert(save != null),
        assert(signIn != null),
        assert(signInAnonymous != null),
        assert(signOut != null),
        assert(signUp != null),
        _getData = getData,
        _setDisplayImagePath = setDisplayImagePath,
        _setEmailAddress = setEmailAddress,
        _setName = setName,
        _setPassword = setPassword,
        _destroy = destroy,
        _save = save,
        _signIn = signIn,
        _signInAnonymous = signInAnonymous,
        _signOut = signOut,
        _setType = setType,
        _signUp = signUp {
    print('#### UserViewModel - constructor');
  }

  @override
  void dispose() {
    super.dispose();
    print('#### UserViewModel - dispose');
  }

  Future<UserModel> getCurrentData() async {
    if (_currentUserModel == null) {
      await _getData.call(NoParams()).then((result) {
        result.fold(
              (failure) => {},
              (entity) => _currentUserModel = entity,
        );
      });
    }
    return _currentUserModel;
  }

  Future<void> setDisplayImagePath(String displayImagePath, {
    @required bool notify,
  }) async {
    await _setDisplayImagePath
        .call(User.SetDisplayImagePathParams(
        entity: _currentUserModel, displayImagePath: displayImagePath))
        .then((result) {
      result.fold(
            (failure) => {},
            (entity) => _currentUserModel = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
  }

  Future<void> setEmailAddress(String emailAddress, {
    @required bool notify,
  }) async {
    await _setEmailAddress
        .call(User.SetEmailAddressParams(
        entity: _currentUserModel, emailAddress: emailAddress))
        .then((result) {
      result.fold(
            (failure) => {},
            (entity) => _currentUserModel = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
  }

  Future<void> setName(String name, {
    @required bool notify,
  }) async {
    await _setName
        .call(User.SetNameParams(entity: _currentUserModel, name: name))
        .then((result) {
      result.fold(
            (failure) => {},
            (entity) => _currentUserModel = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
  }

  Future<void> setPassword(String password, {
    @required bool notify,
  }) async {
    await _setPassword
        .call(User.SetPasswordParams(
        entity: _currentUserModel, password: password))
        .then((result) {
      result.fold(
            (failure) => {},
            (entity) => _currentUserModel = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
  }

  Future<void> setType(UserType type, {
    @required bool notify,
  }) async {
    await _setType
        .call(User.SetTypeParams(entity: _currentUserModel, type: type))
        .then((result) {
      result.fold(
            (failure) => {},
            (entity) => _currentUserModel = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
  }

  Future<void> destroy({@required bool notify}) async {
    await _destroy
        .call(User.DestroyParams(entity: _currentUserModel))
        .then((result) {
      result.fold(
            (failure) => {},
            (entity) => _currentUserModel = null,
      );
    });
    if (notify) {
      notifyListeners();
    }
  }

  Future<void> save({@required bool notify}) async {
    await _save.call(User.SaveParams(entity: _currentUserModel)).then((result) {
      result.fold(
            (failure) => {},
            (entity) => _currentUserModel = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
  }

  Future<void> signOut({@required bool notify}) async {
    await _signOut
        .call(User.SignOutParams(entity: _currentUserModel))
        .then((result) {
      result.fold(
            (failure) => {},
            (entity) async {
          _currentUserModel = entity;
          if (_currentUserModel.type == UserType.Anonymous) {
            await destroy(notify: false);
          }
        },
      );
    });
    if (notify) {
      notifyListeners();
    }
  }

  Future<void> signIn({
    String username,
    String password,
    String emailAddress,
    @required bool notify,
  }) async {
    UserModel newUserModel =
    UserModel(user: ParseUser.createUser(username, password, emailAddress));
    await _signIn.call(User.SignInParams(entity: newUserModel)).then((result) {
      result.fold(
            (failure) => {},
            (entity) => _currentUserModel = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
  }

  Future<void> signInAnonymous({@required bool notify}) async {
    UserModel newUserModel = UserModel(user: ParseUser.createUser());
    await _signInAnonymous
        .call(User.SignInAnonymousParams(entity: newUserModel))
        .then((result) {
      result.fold(
            (failure) => {},
            (entity) => _currentUserModel = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
  }

  Future<void> signUp({
    String username,
    String password,
    String emailAddress,
    @required bool notify,
  }) async {
    UserModel newUserModel =
    UserModel(user: ParseUser.createUser(username, password, emailAddress));
    await _signUp.call(User.SignUpParams(entity: newUserModel)).then((result) {
      result.fold(
            (failure) => {},
            (entity) => _currentUserModel = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
  }
}
