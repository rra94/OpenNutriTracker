import 'package:logging/logging.dart';
import 'package:objectbox/objectbox.dart';
import 'package:opennutritracker/core/data/dbo/app_theme_dbo.dart';
import 'package:opennutritracker/core/data/dbo/config_dbo.dart';
import 'package:opennutritracker/core/db/entities/config_ob.dart';
import 'package:opennutritracker/objectbox.g.dart';

class ConfigDataSourceOB {
  /// We store a single ConfigOB row; this constant is used as the fixed OB id.
  static const int _singletonId = 1;

  final _log = Logger('ConfigDataSourceOB');
  final Box<ConfigOB> _configBox;

  ConfigDataSourceOB(this._configBox);

  Future<bool> configInitialized() async =>
      _configBox.get(_singletonId) != null;

  Future<void> initializeConfig() async {
    final ob = _configDBOToOB(ConfigDBO.empty());
    ob.id = _singletonId;
    _configBox.put(ob);
  }

  Future<void> addConfig(ConfigDBO configDBO) async {
    _log.fine('Adding new config item to db');
    final ob = _configDBOToOB(configDBO);
    ob.id = _singletonId;
    _configBox.put(ob);
  }

  Future<void> setConfigDisclaimer(bool hasAcceptedDisclaimer) async {
    _log.fine(
        'Updating config hasAcceptedDisclaimer to $hasAcceptedDisclaimer');
    final ob = _configBox.get(_singletonId);
    if (ob != null) {
      ob.hasAcceptedDisclaimer = hasAcceptedDisclaimer;
      _configBox.put(ob);
    }
  }

  Future<void> setConfigAcceptedAnonymousData(
      bool hasAcceptedAnonymousData) async {
    _log.fine(
        'Updating config hasAcceptedAnonymousData to $hasAcceptedAnonymousData');
    final ob = _configBox.get(_singletonId);
    if (ob != null) {
      ob.hasAcceptedSendAnonymousData = hasAcceptedAnonymousData;
      _configBox.put(ob);
    }
  }

  Future<AppThemeDBO> getAppTheme() async {
    final ob = _configBox.get(_singletonId);
    if (ob == null) return AppThemeDBO.defaultTheme;
    return _intToAppThemeDBO(ob.selectedAppTheme);
  }

  Future<void> setConfigAppTheme(AppThemeDBO appTheme) async {
    _log.fine('Updating config appTheme to $appTheme');
    final ob = _configBox.get(_singletonId);
    if (ob != null) {
      ob.selectedAppTheme = appTheme.index;
      _configBox.put(ob);
    }
  }

  Future<void> setConfigUsesImperialUnits(bool usesImperialUnits) async {
    _log.fine('Updating config usesImperialUnits to $usesImperialUnits');
    final ob = _configBox.get(_singletonId);
    if (ob != null) {
      ob.usesImperialUnits = usesImperialUnits;
      _configBox.put(ob);
    }
  }

  Future<double> getKcalAdjustment() async {
    final ob = _configBox.get(_singletonId);
    return ob?.userKcalAdjustment ?? 0;
  }

  Future<void> setConfigKcalAdjustment(double kcalAdjustment) async {
    _log.fine('Updating config kcalAdjustment to $kcalAdjustment');
    final ob = _configBox.get(_singletonId);
    if (ob != null) {
      ob.userKcalAdjustment = kcalAdjustment;
      _configBox.put(ob);
    }
  }

  Future<void> setConfigCarbGoalPct(double carbGoalPct) async {
    _log.fine('Updating config carbGoalPct to $carbGoalPct');
    final ob = _configBox.get(_singletonId);
    if (ob != null) {
      ob.userCarbGoalPct = carbGoalPct;
      _configBox.put(ob);
    }
  }

  Future<void> setConfigProteinGoalPct(double proteinGoalPct) async {
    _log.fine('Updating config proteinGoalPct to $proteinGoalPct');
    final ob = _configBox.get(_singletonId);
    if (ob != null) {
      ob.userProteinGoalPct = proteinGoalPct;
      _configBox.put(ob);
    }
  }

  Future<void> setConfigFatGoalPct(double fatGoalPct) async {
    _log.fine('Updating config fatGoalPct to $fatGoalPct');
    final ob = _configBox.get(_singletonId);
    if (ob != null) {
      ob.userFatGoalPct = fatGoalPct;
      _configBox.put(ob);
    }
  }

  Future<ConfigDBO> getConfig() async {
    final ob = _configBox.get(_singletonId);
    return ob != null ? _configOBToDBO(ob) : ConfigDBO.empty();
  }

  Future<bool> getHasAcceptedAnonymousData() async {
    final ob = _configBox.get(_singletonId);
    return ob?.hasAcceptedSendAnonymousData ?? false;
  }
}

// ---------------------------------------------------------------------------
// DBO <-> OB converters
// ---------------------------------------------------------------------------

AppThemeDBO _intToAppThemeDBO(int value) {
  switch (value) {
    case 0:
      return AppThemeDBO.light;
    case 1:
      return AppThemeDBO.dark;
    case 2:
    default:
      return AppThemeDBO.system;
  }
}

ConfigOB _configDBOToOB(ConfigDBO dbo) {
  return ConfigOB(
    hasAcceptedDisclaimer: dbo.hasAcceptedDisclaimer,
    hasAcceptedPolicy: dbo.hasAcceptedPolicy,
    hasAcceptedSendAnonymousData: dbo.hasAcceptedSendAnonymousData,
    selectedAppTheme: dbo.selectedAppTheme.index,
    usesImperialUnits: dbo.usesImperialUnits,
    userKcalAdjustment: dbo.userKcalAdjustment,
    userCarbGoalPct: dbo.userCarbGoalPct,
    userProteinGoalPct: dbo.userProteinGoalPct,
    userFatGoalPct: dbo.userFatGoalPct,
  );
}

ConfigDBO _configOBToDBO(ConfigOB ob) {
  final dbo = ConfigDBO(
    ob.hasAcceptedDisclaimer,
    ob.hasAcceptedPolicy,
    ob.hasAcceptedSendAnonymousData,
    _intToAppThemeDBO(ob.selectedAppTheme),
    usesImperialUnits: ob.usesImperialUnits,
    userKcalAdjustment: ob.userKcalAdjustment,
  );
  dbo.userCarbGoalPct = ob.userCarbGoalPct;
  dbo.userProteinGoalPct = ob.userProteinGoalPct;
  dbo.userFatGoalPct = ob.userFatGoalPct;
  return dbo;
}
