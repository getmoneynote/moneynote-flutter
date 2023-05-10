import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluwx/fluwx.dart';
import '/commons/index.dart';
import '/login/index.dart';

// https://www.jianshu.com/p/422e903600ba
// https://niyangup.github.io/2020/07/23/Flutter集成微信登录分享等/
class WeChatBtn extends StatefulWidget {

  const WeChatBtn({super.key});

  @override
  State<WeChatBtn> createState() => _WeChatBtnState();
}

class _WeChatBtnState extends State<WeChatBtn> {

  bool isInstalled = false;
  late String state;

  _initFluwx() async {
    await registerWxApi(
      appId: "wx7dc963767d4ba362",
      doOnAndroid: true,
      doOnIOS: false,
      universalLink: "https://your.univerallink.com/link/"
    );
    isInstalled = await isWeChatInstalled;
  }

  @override
  void initState() {
    super.initState();
    _initFluwx();

    weChatResponseEventHandler.distinct((a, b) => a == b).listen((res) {
      if (res is WeChatAuthResponse) {
        int errCode = res.errCode!;
        if (errCode == 0) {
          context.read<LoginBloc>().add(WeChatLogIn(res.code!, state));
        }
      }
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
        onPressed: () {
          if (!isInstalled) {
            Message.error('请先安装微信');
          }
          state = DateTime.now().millisecondsSinceEpoch.toString();
          sendWeChatAuth(
            scope: 'snsapi_userinfo',
            state: state
          ).then((data) {

          });
        },
        icon: const Icon(Icons.wechat),
        label: const Text('使用微信账号登录')
    );
  }

}