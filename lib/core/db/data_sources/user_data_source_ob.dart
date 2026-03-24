import 'package:logging/logging.dart';
import 'package:objectbox/objectbox.dart';
import 'package:opennutritracker/core/data/dbo/user_dbo.dart';
import 'package:opennutritracker/core/data/dbo/user_gender_dbo.dart';
import 'package:opennutritracker/core/data/dbo/user_pal_dbo.dart';
import 'package:opennutritracker/core/data/dbo/user_weight_goal_dbo.dart';
import 'package:opennutritracker/core/db/entities/user_ob.dart';
import 'package:opennutritracker/objectbox.g.dart';

class UserDataSourceOB {
  /// We store a single UserOB row; this constant is used as the fixed OB id.
  static const int _singletonId = 1;

  final log = Logger('UserDataSourceOB');
  final Box<UserOB> _userBox;

  UserDataSourceOB(this._userBox);

  Future<void> saveUserData(UserDBO userDBO) async {
    log.fine('Updating user in db');
    final ob = _userDBOToOB(userDBO);
    ob.id = _singletonId;
    _userBox.put(ob);
  }

  Future<bool> hasUserData() async => _userBox.get(_singletonId) != null;

  // TODO remove dummy data
  Future<UserDBO> getUserData() async {
    final ob = _userBox.get(_singletonId);
    return ob != null
        ? _userOBToDBO(ob)
        : UserDBO(
            birthday: DateTime(2000, 1, 1),
            heightCM: 180,
            weightKG: 80,
            gender: UserGenderDBO.male,
            goal: UserWeightGoalDBO.maintainWeight,
            pal: UserPALDBO.active);
  }
}

// ---------------------------------------------------------------------------
// DBO <-> OB converters
// ---------------------------------------------------------------------------

UserOB _userDBOToOB(UserDBO dbo) {
  return UserOB(
    birthday: dbo.birthday,
    heightCM: dbo.heightCM,
    weightKG: dbo.weightKG,
    gender: dbo.gender.index,
    goal: dbo.goal.index,
    pal: dbo.pal.index,
  );
}

UserDBO _userOBToDBO(UserOB ob) {
  return UserDBO(
    birthday: ob.birthday,
    heightCM: ob.heightCM,
    weightKG: ob.weightKG,
    gender: UserGenderDBO.values[ob.gender],
    goal: UserWeightGoalDBO.values[ob.goal],
    pal: UserPALDBO.values[ob.pal],
  );
}
