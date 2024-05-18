import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../data/repository/apis/user_apis.dart';
import '../../../utils/Constants/image_string.dart';
import '../../../utils/helpers/helper_function.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 200,
              width: 300,
              child: Image(
                image: AssetImage(
                  AppImage.deleteAccoun,
                ),
              ),
            ),
            const Gap(80),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  AppHelperFunction.showAlert("Delete", "Are you confirming that you want to delete your account?",
                          () {
                        Navigator.pop(context);
                        UserApis.deleteUserAccount();
                      });
                },
                child: const Text("Delete"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
