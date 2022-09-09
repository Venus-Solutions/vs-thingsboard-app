import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:thingsboard_app/core/auth/login/login_page_background.dart';
import 'package:thingsboard_app/core/context/tb_context.dart';
import 'package:thingsboard_app/core/context/tb_context_widget.dart';
import 'package:thingsboard_app/widgets/tb_app_bar.dart';
import 'package:thingsboard_app/widgets/tb_progress_indicator.dart';

class ResetPasswordRequestPage extends TbPageWidget {

  ResetPasswordRequestPage(TbContext tbContext) : super(tbContext);

  @override
  _ResetPasswordRequestPageState createState() => _ResetPasswordRequestPageState();

}

class _ResetPasswordRequestPageState extends TbPageState<ResetPasswordRequestPage> {

  final _isLoadingNotifier = ValueNotifier<bool>(false);

  final _resetPasswordFormKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( children: [
        LoginPageBackground(),
        SizedBox.expand(
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: TbAppBar(
                tbContext,
                title: Text('เปลี่ยนรหัสผ่านใหม่'),
              ),
              body: Stack(
                children: [
                  SizedBox.expand(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                        child: FormBuilder(
                                key: _resetPasswordFormKey,
                                autovalidateMode: AutovalidateMode.disabled,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(height: 16),
                                      // Text('Enter the email associated with your account and we\'ll send an email with password reset link',
                                      Text('ป้อนอีเมลที่ได้สมัครสมาชิกไว้กับ Tony Space\ ระบบจะส่งลิงก์สำหรับตั้งรหัสผ่านใหม่ไปยังอีเมล',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFFAFAFAF),
                                          fontSize: 14,
                                          height: 24 / 14
                                        ),
                                      ),
                                      SizedBox(height: 61),
                                      FormBuilderTextField(
                                        name: 'email',
                                        autofocus: true,
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.required(context, errorText: 'กรุณาป้อนอีเมล'), // Email is required.
                                          FormBuilderValidators.email(context, errorText: 'รูปแบบอีเมลไม่ถูกต้อง') //Invalid email format.
                                        ]),
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'อีเมล *'
                                        ),
                                      ),
                                      Spacer(),
                                      ElevatedButton(
                                        child: Text('ร้องขอการตั้งรหัสผ่านใหม่'), // Request password reset
                                        style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16)),
                                        onPressed: () {
                                          _requestPasswordReset();
                                        },
                                      )
                                    ]
                                )
                        )
                    )
                  ),
                  ValueListenableBuilder<bool>(
                      valueListenable: _isLoadingNotifier,
                      builder: (BuildContext context, bool loading, child) {
                        if (loading) {
                          return SizedBox.expand(
                              child: Container(
                                color: Color(0x99FFFFFF),
                                child: Center(child: TbProgressIndicator(size: 50.0)),
                              )
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      }
                  )
                ]
              )
          )
        )
      ])
    );
  }

  void _requestPasswordReset() async {
    FocusScope.of(context).unfocus();
    if (_resetPasswordFormKey.currentState?.saveAndValidate() ?? false) {
      var formValue = _resetPasswordFormKey.currentState!.value;
      String email = formValue['email'];
      _isLoadingNotifier.value = true;
      try {
        await Future.delayed(Duration(milliseconds: 300));
        await tbClient.sendResetPasswordLink(email);
        _isLoadingNotifier.value = false;
        showSuccessNotification('ระบบส่งลิงก์สำหรับตั้งรหัสใหม่ไปยังอีเมลเรียบร้อยแล้ว'); // Password reset link was successfully sent!
      } catch(e) {
        _isLoadingNotifier.value = false;
      }
    }
  }
}
