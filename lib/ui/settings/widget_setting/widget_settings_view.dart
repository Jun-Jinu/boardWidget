import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import './widget_settings_viewmodel.dart';

const BIG_FONT_SIZE = 28.0;
const NOMAL_FONT_SIZE = 24.0;
const SMALL_FONT_SIZE = 20.0;

class WidgetSettingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('위젯 설정'),
      ),
      body: WidgetSettingBody(),
    );
  }
}

class WidgetSettingBody extends StatelessWidget {
  const WidgetSettingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<WidgetSettingsViewModel>(context);

    return Column(
      children: [
        Container(
          // 위젯 밖의 배경 색
          color: Colors.black12,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Container(
            width: double.infinity,
            height: 140,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: viewModel.backgroundColorExample,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                '오랫동안 꿈을 그리는 사람은 \n마침내 그 꿈을 닮아간다',
                style: TextStyle(
                  color: viewModel.fontColorExample,
                  fontSize: viewModel.fontSize,
                  fontFamily: viewModel.fontFamily,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
          child: SettingsList(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
            sections: [
              // SettingsSection(
              //   margin: const EdgeInsetsDirectional.only(bottom: 20.0),
              //   title: const Text('위젯 다짐 변경 주기'),
              //   tiles: [
              //     SettingsTile.switchTile(
              //       onToggle: (value) {
              //         viewModel.setIsTextChangeHourly(value);
              //       },
              //       initialValue: viewModel.isTextChangeHourly,
              //       title: const Text('시간별 텍스트 변경'),
              //     ),
              //     if (viewModel.isTextChangeHourly) ...[
              //       SettingsTile(
              //         title: const Text('2시간'),
              //         onPressed: (BuildContext context) {
              //           viewModel.setIsTextChangeHour(2);
              //         },
              //         trailing: viewModel.isTextChangeHour == 2
              //             ? const Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
              //             : null,
              //       ),
              //       SettingsTile(
              //         title: const Text('6시간'),
              //         onPressed: (BuildContext context) {
              //           viewModel.setIsTextChangeHour(6);
              //         },
              //         trailing: viewModel.isTextChangeHour == 6
              //             ? const Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
              //             : null,
              //       ),
              //       SettingsTile(
              //         title: const Text('12시간'),
              //         onPressed: (BuildContext context) {
              //           viewModel.setIsTextChangeHour(12);
              //         },
              //         trailing: viewModel.isTextChangeHour == 12
              //             ? const Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
              //             : null,
              //       ),
              //       SettingsTile(
              //         title: const Text('하루'),
              //         onPressed: (BuildContext context) {
              //           viewModel.setIsTextChangeHour(24);
              //         },
              //         trailing: viewModel.isTextChangeHour == 24
              //             ? const Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
              //             : null,
              //       ),
              //       SettingsTile(
              //         title: const Text('일주일'),
              //         onPressed: (BuildContext context) {
              //           viewModel.setIsTextChangeHour(168);
              //         },
              //         trailing: viewModel.isTextChangeHour == 168
              //             ? const Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
              //             : null,
              //       ),
              //     ],
              //   ],
              // ),

              SettingsSection(
                margin: const EdgeInsetsDirectional.only(bottom: 20.0),
                title: const Text('위젯 배경색'),
                tiles: [
                  SettingsTile(
                    title: const Text('검정색'),
                    onPressed: (BuildContext context) {
                      viewModel.setBackgroundColor("black");
                    },
                    trailing: viewModel.backgroundColor == "black"
                        ? Icon(Icons.check,
                            color: Theme.of(context).colorScheme.primary)
                        : null,
                  ),
                  SettingsTile(
                    title: const Text('회색'),
                    onPressed: (BuildContext context) {
                      viewModel.setBackgroundColor("grey");
                    },
                    trailing: viewModel.backgroundColor == "grey"
                        ? Icon(Icons.check,
                            color: Theme.of(context).colorScheme.primary)
                        : null,
                  ),
                  SettingsTile(
                    title: const Text('남색'),
                    onPressed: (BuildContext context) {
                      viewModel.setBackgroundColor("navy");
                    },
                    trailing: viewModel.backgroundColor == "navy"
                        ? Icon(Icons.check,
                            color: Theme.of(context).colorScheme.primary)
                        : null,
                  ),
                ],
              ),
              SettingsSection(
                margin: const EdgeInsetsDirectional.only(bottom: 20.0),
                title: const Text('글자 색'),
                tiles: [
                  SettingsTile(
                    title: const Text('흰색'),
                    onPressed: (BuildContext context) {
                      viewModel.setFontColor("white");
                    },
                    trailing: viewModel.fontColor == "white"
                        ? Icon(Icons.check,
                            color: Theme.of(context).colorScheme.primary)
                        : null,
                  ),
                  SettingsTile(
                    title: const Text('연한 회색'),
                    onPressed: (BuildContext context) {
                      viewModel.setFontColor("light_grey");
                    },
                    trailing: viewModel.fontColor == "light_grey"
                        ? Icon(Icons.check,
                            color: Theme.of(context).colorScheme.primary)
                        : null,
                  ),
                  SettingsTile(
                    title: const Text('노란색'),
                    onPressed: (BuildContext context) {
                      viewModel.setFontColor("yellow");
                    },
                    trailing: viewModel.fontColor == "yellow"
                        ? Icon(Icons.check,
                            color: Theme.of(context).colorScheme.primary)
                        : null,
                  ),
                ],
              ),
              SettingsSection(
                margin: const EdgeInsetsDirectional.only(bottom: 20.0),
                title: const Text('폰트'),
                tiles: [
                  SettingsTile(
                    title: const Text(
                      '애플 산돌고딕 NEO',
                      style: TextStyle(fontFamily: "AppleSDGothicNeo-Medium"),
                    ),
                    onPressed: (BuildContext context) {
                      viewModel.setFontFamily("AppleSDGothicNeo-Medium");
                    },
                    trailing: viewModel.fontFamily == "AppleSDGothicNeo-Medium"
                        ? Icon(Icons.check,
                            color: Theme.of(context).colorScheme.primary)
                        : null,
                  ),
                  SettingsTile(
                    title: const Text(
                      '노토산스(NotoSansKR)',
                      style: TextStyle(fontFamily: "NotoSansKR"),
                    ),
                    onPressed: (BuildContext context) {
                      viewModel.setFontFamily("NotoSansKR-Medium");
                    },
                    trailing: viewModel.fontFamily == "NotoSansKR-Medium"
                        ? Icon(Icons.check,
                            color: Theme.of(context).colorScheme.primary)
                        : null,
                  ),
                  SettingsTile(
                    title: const Text(
                      '교보손글씨 2019',
                      style: TextStyle(fontFamily: "KyoboHandwriting2019"),
                    ),
                    onPressed: (BuildContext context) {
                      viewModel.setFontFamily("KyoboHandwriting2019");
                    },
                    trailing: viewModel.fontFamily == "KyoboHandwriting2019"
                        ? Icon(Icons.check,
                            color: Theme.of(context).colorScheme.primary)
                        : null,
                  ),
                  SettingsTile(
                    title: const Text(
                      '코트라 희망체',
                      style: TextStyle(fontFamily: "KOTRAHOPE"),
                    ),
                    onPressed: (BuildContext context) {
                      viewModel.setFontFamily("KOTRAHOPE");
                    },
                    trailing: viewModel.fontFamily == "KOTRAHOPE"
                        ? Icon(Icons.check,
                            color: Theme.of(context).colorScheme.primary)
                        : null,
                  ),
                  SettingsTile(
                    title: const Text(
                      '태백 은하수체',
                      style: TextStyle(fontFamily: "TAEBAEK-milkyway"),
                    ),
                    onPressed: (BuildContext context) {
                      viewModel.setFontFamily("TAEBAEK-milkyway");
                    },
                    trailing: viewModel.fontFamily == "TAEBAEK-milkyway"
                        ? Icon(Icons.check,
                            color: Theme.of(context).colorScheme.primary)
                        : null,
                  ),
                ],
              ),
              SettingsSection(
                margin: const EdgeInsetsDirectional.only(bottom: 20.0),
                title: const Text('글자 크기'),
                tiles: [
                  SettingsTile(
                    title: const Text('크게'),
                    onPressed: (BuildContext context) {
                      viewModel.setFontSize(BIG_FONT_SIZE);
                    },
                    trailing: viewModel.fontSize == BIG_FONT_SIZE
                        ? Icon(Icons.check,
                            color: Theme.of(context).colorScheme.primary)
                        : null,
                  ),
                  SettingsTile(
                    title: const Text('보통'),
                    onPressed: (BuildContext context) {
                      viewModel.setFontSize(NOMAL_FONT_SIZE);
                    },
                    trailing: viewModel.fontSize == NOMAL_FONT_SIZE
                        ? Icon(Icons.check,
                            color: Theme.of(context).colorScheme.primary)
                        : null,
                  ),
                  SettingsTile(
                    title: const Text('작게'),
                    onPressed: (BuildContext context) {
                      viewModel.setFontSize(SMALL_FONT_SIZE);
                    },
                    trailing: viewModel.fontSize == SMALL_FONT_SIZE
                        ? Icon(Icons.check,
                            color: Theme.of(context).colorScheme.primary)
                        : null,
                  ),
                ],
              ),
              // SettingsSection(
              //   margin: const EdgeInsetsDirectional.only(bottom: 20.0),
              //   title: const Text('날짜 형식'),
              //   tiles: [
              //     SettingsTile(
              //       title: const Text('방법1'),
              //       onPressed: (BuildContext context) {
              //         // Handle version settings
              //       },
              //     ),
              //     SettingsTile(
              //       title: const Text('방법2'),
              //       onPressed: (BuildContext context) {
              //         // Handle developer settings
              //       },
              //       // TODO: 요일 표시 체크박스 만들기
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
