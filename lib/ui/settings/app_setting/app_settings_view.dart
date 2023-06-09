import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'app_settings_viewmodel.dart';

class AppSettingsView extends StatelessWidget {
  const AppSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('앱 설정'),
      ),
      body: Consumer<AppSettingsViewModel>(
        builder: (context, viewModel, _) {
          // 폰트 메뉴에 사용하는 위젯
          List<SettingsTile> fontSettingsTiles = viewModel.fontList.map((font) {
            return SettingsTile(
              title: Text(
                font['title'],
                style: TextStyle(fontFamily: font['fontFamily']),
              ),
              onPressed: (BuildContext context) {
                viewModel.selectFont(context, font['fontFamily']);
              },
              trailing: viewModel.fontFamily == font['fontFamily']
                  ? Icon(Icons.check,
                      color: Theme.of(context).colorScheme.primary)
                  : null,
            );
          }).toList();

          List<SettingsTile> primaryColorSettingsTiles =
              viewModel.primaryColorList.map((color) {
            return SettingsTile(
              leading: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: color['primaryColor'],
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              title: Text(color['title']),
              onPressed: (BuildContext context) {
                viewModel.selectPrimaryColor(color['primaryColor']);
                viewModel.selectSecondaryColor(color['secondaryColor']);
              },
              trailing: viewModel.primaryColor == color['primaryColor']
                  ? Icon(Icons.check,
                      color: Theme.of(context).colorScheme.primary)
                  : null,
            );
          }).toList();

          return SettingsList(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            sections: [
              SettingsSection(
                margin: EdgeInsetsDirectional.only(bottom: 20.0),
                title: const Text('테마'),
                tiles: [
                  SettingsTile.switchTile(
                    leading: Icon(Icons.dark_mode),
                    initialValue: viewModel.isDarkModeEnabled,
                    onToggle: (value) {
                      viewModel.setDarkModeEnabled(value);
                    },
                    title: Text('다크모드'),
                  ),
                ],
              ),
              SettingsSection(
                margin: EdgeInsetsDirectional.only(bottom: 20.0),
                title: const Text('강조색'),
                tiles: primaryColorSettingsTiles,
              ),
              SettingsSection(
                margin: EdgeInsetsDirectional.only(bottom: 20.0),
                title: const Text('폰트'),
                tiles: fontSettingsTiles,
              ),
              SettingsSection(
                margin: EdgeInsetsDirectional.only(bottom: 20.0),
                title: const Text('글자 크기'),
                tiles: [
                  SettingsTile(
                    title: Text("작게"),
                    onPressed: (BuildContext context) {
                      viewModel.selectFontSize(0.8);
                    },
                    trailing: viewModel.fontSize == 0.8
                        ? Icon(Icons.check,
                            color: Theme.of(context).colorScheme.primary)
                        : null,
                  ),
                  SettingsTile(
                    title: Text("보통"),
                    onPressed: (BuildContext context) {
                      viewModel.selectFontSize(1.0);
                    },
                    trailing: viewModel.fontSize == 1.0
                        ? Icon(Icons.check,
                            color: Theme.of(context).colorScheme.primary)
                        : null,
                  ),
                  SettingsTile(
                    title: Text("크게"),
                    onPressed: (BuildContext context) {
                      viewModel.selectFontSize(1.2);
                    },
                    trailing: viewModel.fontSize == 1.2
                        ? Icon(Icons.check,
                            color: Theme.of(context).colorScheme.primary)
                        : null,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
