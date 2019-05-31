import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:mall/src.dart';

class AuthenticationPage extends StatefulWidget {
  AuthenticationPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
                decoration: InputDecoration(hintText: 'user name hint'),
                obscureText: false,
                onChanged: (text) {
                  print('#### user name change: $text');
                }),
            TextField(
                decoration: InputDecoration(hintText: 'password hint'),
                obscureText: true,
                onChanged: (text) {
                  print('#### password change: $text');
                }),
            RaisedButton(
              onPressed: () {},
              child: Text('sign up'),
            ),
            RaisedButton(
              onPressed: () {},
              child: Text('login'),
            ),
            RaisedButton(
              onPressed: () {
                appBloc.inDarkTheme.add(false);
              },
              child: Text('light'),
            ),
            RaisedButton(
              onPressed: () {
                appBloc.inDarkTheme.add(true);
              },
              child: Text('dark'),
            ),
          ],
        ),
      ),
    );
  }

  UserRepository userRepo;

  Future<void> initRepository() async {
    userRepo ??= UserRepository.init(await getDb());
  }

  Future<void> initData() async {
    // Initialize repository
    await initRepository();
    Parse().initialize(parseApplicationId, parseServerUrl,
        appName: parseApplicationName, masterKey: parseMasterKey, debug: true);
    final ParseResponse response = await Parse().healthCheck();
    if (response.success) {
      await runTestQueries();
      print('#### runTestQueries');
    } else {
      print(
          '#### Server health check failed: ${response.error.code}: ${response.error.message}');
    }
  }

  Future<void> runTestQueries() async {
    test();

    // Basic repository example
    //await repositoryAddUser();
    //await repositoryAddItems();
    //await repositoryGetAllItems();

    //Basic usage
    // createItem();
    // getAllItems();
    // getAllItemsByName();
    // getSingleItem();
    // getConfigs();
    // query();
    // initUser();
//    var instalattion = await ParseInstallation.currentInstallation();
//    var rees = instalattion.create();
//    print(rees);
    //function();
    //functionWithParameters();
  }

  Future<void> test() async {
    PUser user = PUser('test_user', 'test_password', 'test@gmail.com');
    final ParseResponse signUpResponse = await user.signUp();
    print('#### signUpResponse=${signUpResponse.result}');

    if (signUpResponse.success) {
      user = signUpResponse.result;
    } else {
      final ParseResponse loginResponse = await user.login();

      if (loginResponse.success) {
        user = loginResponse.result;
      }
    }
  }

  Future<void> createItem() async {
    final ParseObject newObject = ParseObject('TestObjectForApi');
    newObject.set<String>('name', 'testItem');
    newObject.set<int>('age', 26);

    final ParseResponse apiResponse = await newObject.create();

    if (apiResponse.success && apiResponse.count > 0) {
      print(keyAppName + ': ' + apiResponse.result.toString());
    }
  }

  Future<void> getAllItemsByName() async {
    final ParseResponse apiResponse =
        await ParseObject('TestObjectForApi').getAll();

    if (apiResponse.success && apiResponse.count > 0) {
      for (final ParseObject testObject in apiResponse.results) {
        print(keyAppName + ': ' + testObject.toString());
      }
    }
  }

  Future<void> query() async {
    final QueryBuilder<ParseObject> queryBuilder =
        QueryBuilder<ParseObject>(ParseObject('TestObjectForApi'))
          ..whereLessThan(keyVarCreatedAt, DateTime.now());

    final ParseResponse apiResponse = await queryBuilder.query();

    if (apiResponse.success && apiResponse.count > 0) {
      final List<ParseObject> listFromApi = apiResponse.result;
      final ParseObject parseObject = listFromApi?.first;
      print('Result: ${parseObject.toString()}');
    } else {
      print('Result: ${apiResponse.error.message}');
    }
  }

  Future<void> initUser() async {
    // All return type ParseUser except all
    ParseUser user =
        ParseUser('TestFlutter', 'TestPassword123', 'test.flutter@gmail.com');

    /// Sign-up
    ParseResponse response = await user.signUp();
    if (response.success) {
      user = response.result;
    }

    /// Login
    response = await user.login();
    if (response.success) {
      user = response.result;
    }

    /// Reset password
    response = await user.requestPasswordReset();
    if (response.success) {
      user = response.result;
    }

    /// Verify email
    response = await user.verificationEmailRequest();
    if (response.success) {
      user = response.result;
    }

    // Best practice for starting the app. This will check for a valid user from a previous session from a local storage
    user = await ParseUser.currentUser();

    /// Update current user from server - Best done to verify user is still a valid user
    response = await ParseUser.getCurrentUserFromServer(
        token: user?.get<String>(keyHeaderSessionToken));
    if (response.success) {
      user = response.result;
    }

    /// log user out
    response = await user.logout();
    if (response.success) {
      user = response.result;
    }

    user = await ParseUser.currentUser();

    user =
        ParseUser('TestFlutter', 'TestPassword123', 'phill.wiggins@gmail.com');
    response = await user.login();
    if (response.success) {
      user = response.result;
    }

    response = await user.save();
    if (response.success) {
      user = response.result;
    }

    // Returns type ParseResponse as its a query, not a single result
    response = await ParseUser.all();
    if (response.success) {
      // We have a list of all users (LIMIT SET VIA SDK)
      print(response.results);
    }

    final QueryBuilder<ParseUser> queryBuilder =
        QueryBuilder<ParseUser>(ParseUser.forQuery())
          ..whereStartsWith(ParseUser.keyUsername, 'phillw');

    final ParseResponse apiResponse = await queryBuilder.query();
    if (apiResponse.success && apiResponse.count > 0) {
      final List<ParseUser> users = response.result;
      for (final ParseUser user in users) {
        print(keyAppName + ': ' + user.toString());
      }
    }
  }

  Future<void> function() async {
    final ParseCloudFunction function = ParseCloudFunction('hello');
    final ParseResponse result =
        await function.executeObjectFunction<ParseObject>();
    if (result.success) {
      if (result.result is ParseObject) {
        final ParseObject parseObject = result.result;
        print(parseObject.className);
      }
    }
  }

  Future<void> functionWithParameters() async {
    final ParseCloudFunction function = ParseCloudFunction('hello');
    final Map<String, String> params = <String, String>{'plan': 'paid'};
    function.execute(parameters: params);
  }

  Future<void> getConfigs() async {
    final ParseConfig config = ParseConfig();
    final ParseResponse addResponse =
        await config.addConfig('TestConfig', 'testing');

    if (addResponse.success) {
      print('Added a config');
    }

    final ParseResponse getResponse = await config.getConfigs();

    if (getResponse.success) {
      print('We have our configs.');
    }
  }

  Future<void> repositoryAddUser() async {
    final PUser user = PUser('test_username', 'password', 'test@gmail.com');

    final ApiResponse response = await userRepo.save(user);

    if (!response.success) {
      await userRepo.login(user);
    }

    final PUser currentUser =
        await ParseUser.currentUser(customUserObject: PUser.clone());
    print(currentUser);
  }
}
