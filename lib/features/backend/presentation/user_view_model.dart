import 'package:flutter/material.dart';
import 'package:mall/core/error/failures.dart';
import 'package:mall/features/backend/data/models/user_model.dart';
import 'package:mall/features/backend/domain/entities/user_entity.dart';
import 'package:mall/features/backend/domain/usecases/user/usecases.dart'
    as User;
import 'package:parse_server_sdk/parse_server_sdk.dart';

class UserViewModel extends ChangeNotifier {
  final User.GetLastUser _glu;
  final User.SetDisplayImagePath _sdip;
  final User.SetEmailAddress _sea;
  final User.SetName _sn;
  final User.SetPassword _sp;
  final User.SetType _st;
  final User.Destroy _d;
  final User.Save _s;
  final User.SignIn _si;
  final User.SignInAnonymous _sia;
  final User.SignOut _so;
  final User.SignUp _su;

  UserModel _lastUser;

  UserViewModel({
    @required User.GetLastUser glu,
    @required User.SetDisplayImagePath sdip,
    @required User.SetEmailAddress sea,
    @required User.SetName sn,
    @required User.SetPassword sp,
    @required User.SetType st,
    @required User.Destroy d,
    @required User.Save s,
    @required User.SignIn si,
    @required User.SignInAnonymous sia,
    @required User.SignOut so,
    @required User.SignUp su,
  })  : assert(glu != null),
        assert(sdip != null),
        assert(sea != null),
        assert(sn != null),
        assert(sp != null),
        assert(st != null),
        assert(d != null),
        assert(s != null),
        assert(si != null),
        assert(sia != null),
        assert(so != null),
        assert(su != null),
        _glu = glu,
        _sdip = sdip,
        _sea = sea,
        _sn = sn,
        _sp = sp,
        _d = d,
        _s = s,
        _si = si,
        _sia = sia,
        _so = so,
        _st = st,
        _su = su {
    print('#### UserViewModel - constructor');
  }

  @override
  void dispose() {
    super.dispose();
    print('#### UserViewModel - dispose');
  }

  UserModel getLastUser() {
    if (_lastUser == null) {
      fetchLastUser(notify: true);
    }
    return _lastUser;
  }

  Future<Failure> fetchLastUser({bool notify = false}) async {
    Failure ret;
    await _glu.call(User.GetLastUserParams()).then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastUser = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> setDisplayImagePath(
    String displayImagePath, {
    UserEntity entity,
    bool notify = false,
  }) async {
    Failure ret;
    await _sdip
        .call(User.SetDisplayImagePathParams(displayImagePath, entity: entity))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastUser = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> setEmailAddress(
    String emailAddress, {
    UserEntity entity,
    bool notify = false,
  }) async {
    Failure ret;
    await _sea
        .call(User.SetEmailAddressParams(emailAddress, entity: _lastUser))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastUser = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> setName(
    String name, {
    UserEntity entity,
    bool notify = false,
  }) async {
    Failure ret;
    await _sn
        .call(User.SetNameParams(entity: _lastUser, name: name))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastUser = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> setPassword(
    String password, {
    UserEntity entity,
    bool notify = false,
  }) async {
    Failure ret;
    await _sp
        .call(User.SetPasswordParams(entity: _lastUser, password: password))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastUser = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> setType(
    UserType type, {
    UserEntity entity,
    bool notify = false,
  }) async {
    Failure ret;
    await _st
        .call(User.SetTypeParams(entity: _lastUser, type: type))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastUser = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> destroy({bool notify = false}) async {
    Failure ret;
    await _d.call(User.DestroyParams(entity: _lastUser)).then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastUser = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> save({bool notify = false}) async {
    Failure ret;
    await _s.call(User.SaveParams(entity: _lastUser)).then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastUser = entity,
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> signOut({bool notify = false}) async {
    Failure ret;
    if (_lastUser.type == UserType.Anonymous) {
      await destroy();
    }
    await _so.call(User.SignOutParams(entity: _lastUser)).then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) async {
          _lastUser = entity;
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
    await _si.call(User.SignInParams(entity: newUserModel)).then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastUser = entity,
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
    await _sia
        .call(User.SignInAnonymousParams(entity: newUserModel))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) async {
          _lastUser = entity;
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
    if (_lastUser != null && _lastUser.type == UserType.Anonymous) {
      oldUserModel = UserModel(user: await ParseUser.currentUser());
    }

    UserModel newUserModel =
        UserModel(user: ParseUser.createUser(username, password, emailAddress));
    Failure ret;
    await _su.call(User.SignUpParams(entity: newUserModel)).then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) async {
          _lastUser = entity;
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
