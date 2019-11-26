import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
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

  UserModel _currentEntity;

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
  })  : assert(getData != null),
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

  UserModel getCurrentData() {
    return _currentEntity;
  }

  Future<Failure> syncCurrentData({bool notify = false}) async {
    Failure ret;
    await _getData.call(NoParams()).then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _currentEntity = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> setDisplayImagePath(
    String displayImagePath, {
    bool notify = false,
  }) async {
    Failure ret;
    await _setDisplayImagePath
        .call(User.SetDisplayImagePathParams(
            entity: _currentEntity, displayImagePath: displayImagePath))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _currentEntity = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> setEmailAddress(
    String emailAddress, {
    bool notify = false,
  }) async {
    Failure ret;
    await _setEmailAddress
        .call(User.SetEmailAddressParams(
            entity: _currentEntity, emailAddress: emailAddress))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _currentEntity = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> setName(
    String name, {
    bool notify = false,
  }) async {
    Failure ret;
    await _setName
        .call(User.SetNameParams(entity: _currentEntity, name: name))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _currentEntity = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> setPassword(
    String password, {
    bool notify = false,
  }) async {
    Failure ret;
    await _setPassword
        .call(
            User.SetPasswordParams(entity: _currentEntity, password: password))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _currentEntity = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> setType(
    UserType type, {
    bool notify = false,
  }) async {
    Failure ret;
    await _setType
        .call(User.SetTypeParams(entity: _currentEntity, type: type))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _currentEntity = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> destroy({bool notify = false}) async {
    Failure ret;
    await _destroy
        .call(User.DestroyParams(entity: _currentEntity))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _currentEntity = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> save({bool notify = false}) async {
    Failure ret;
    await _save.call(User.SaveParams(entity: _currentEntity)).then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _currentEntity = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> signOut({bool notify = false}) async {
    Failure ret;
    if (_currentEntity.type == UserType.Anonymous) {
      await destroy();
    }
    await _signOut
        .call(User.SignOutParams(entity: _currentEntity))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) async {
          _currentEntity = entity;
        },
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> signIn({
    String username,
    String password,
    String emailAddress,
    bool notify = false,
  }) async {
    UserModel newUserModel =
        UserModel(user: ParseUser.createUser(username, password, emailAddress));
    Failure ret;
    await _signIn.call(User.SignInParams(entity: newUserModel)).then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _currentEntity = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> signInAnonymous({bool notify = false}) async {
    UserModel newUserModel = UserModel(user: ParseUser.createUser());
    Failure ret;
    await _signInAnonymous
        .call(User.SignInAnonymousParams(entity: newUserModel))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) async {
          _currentEntity = entity;
          await setType(UserType.Anonymous);
        },
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> signUp({
    UserType type,
    String username,
    String password,
    String emailAddress,
    bool notify = false,
  }) async {
    UserModel oldUserModel;
    if (_currentEntity != null && _currentEntity.type == UserType.Anonymous) {
      oldUserModel = UserModel(user: await ParseUser.currentUser());
    }

    UserModel newUserModel =
        UserModel(user: ParseUser.createUser(username, password, emailAddress));
    Failure ret;
    await _signUp.call(User.SignUpParams(entity: newUserModel)).then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) async {
          _currentEntity = entity;
          await setType(type);
          if (oldUserModel != null) {
            await oldUserModel.user.destroy();
          }
        },
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }
}
