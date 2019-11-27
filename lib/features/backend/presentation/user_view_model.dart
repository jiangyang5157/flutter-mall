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
    UserModel model,
    bool notify = false,
  }) async {
    Failure ret;
    await _sdip
        .call(User.SetDisplayImagePathParams(displayImagePath, entity: model))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastUser = entity, // TODO
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> setEmailAddress(
    String emailAddress, {
    UserModel model,
    bool notify = false,
  }) async {
    Failure ret;
    await _sea
        .call(User.SetEmailAddressParams(emailAddress, entity: model))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastUser = entity, // TODO
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> setName(
    String name, {
    UserModel model,
    bool notify = false,
  }) async {
    Failure ret;
    await _sn.call(User.SetNameParams(name, entity: model)).then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastUser = entity, // TODO
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> setPassword(
    String password, {
    UserModel model,
    bool notify = false,
  }) async {
    Failure ret;
    await _sp
        .call(User.SetPasswordParams(password, entity: model))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastUser = entity, // TODO
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> setType(
    UserType type, {
    UserModel model,
    bool notify = false,
  }) async {
    Failure ret;
    await _st.call(User.SetTypeParams(type, entity: model)).then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastUser = entity, // TODO
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> destroy({
    UserModel model,
    bool notify = false,
  }) async {
    Failure ret;
    await _d.call(User.DestroyParams(entity: model)).then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastUser = entity, // TODO is entity null?
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> save({
    UserModel model,
    bool notify = false,
  }) async {
    Failure ret;
    await _s.call(User.SaveParams(entity: model)).then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastUser = entity, // TODO
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> signOut({
    UserModel model,
    bool notify = false,
  }) async {
    Failure ret;
    await _so.call(User.SignOutParams(entity: model)).then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastUser = entity, // TODO is entity null?
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
    UserModel newModel =
        UserModel(user: ParseUser.createUser(username, password, emailAddress));
    Failure ret;
    await _si.call(User.SignInParams(entity: newModel)).then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) => _lastUser = entity, // TODO
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }

  Future<Failure> signInAnonymous({bool notify = false}) async {
    UserModel newModel = UserModel(user: ParseUser.createUser());
    Failure ret;
    await _sia
        .call(User.SignInAnonymousParams(entity: newModel))
        .then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) async {
          _lastUser = entity; // TODO
          await setType(UserType.Anonymous, model: entity);
          _lastUser = entity; // TODO
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
    UserModel newModel =
        UserModel(user: ParseUser.createUser(username, password, emailAddress));
    Failure ret;
    await _su.call(User.SignUpParams(entity: newModel)).then((result) {
      result.fold(
        (failure) => ret = failure,
        (entity) async {
          _lastUser = entity; // TODO
          await setType(type, model: entity);
          _lastUser = entity; // TODO
        },
      );
    });
    if (notify) {
      notifyListeners();
    }
    return ret;
  }
}
