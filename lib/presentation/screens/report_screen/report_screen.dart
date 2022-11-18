import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:fanchat/constants/app_colors.dart';
import 'package:fanchat/presentation/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({
    super.key,
    required this.postText,
    required this.postVideo,
    required this.postImage,
    required this.postId,
    required this.postOwner,
  });

  final String postOwner;
  final String postId;
  final String postText;
  final String postImage;
  final String postVideo;

  static List reportTitle = [
    'Nudity',
    'Spam',
    'Unauthorized sales',
    'Violence',
    'Terrorism',
    'Hate Speech',
    'False information',
    'Suicide or self_injury',
    'Harassment',
    'Something else',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is SendPostReportSuccessState) {
          customToast(
              title: 'Report has been sent to admins',
              color: AppColors.navBarActiveIcon);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor1,
          appBar: customAppbar('dsd', context),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Please select a problem',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'if someone is in immediate danger ,get help before reporting to facebook. Don\'t wait',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                        color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            AppCubit.get(context).sendPostReport(
                                reportType: reportTitle[index],
                                senderReport:
                                    AppCubit.get(context).userModel!.uId!,
                                postOwner: postOwner,
                                postId: postId,
                                postText: postText,
                                postImage: postImage,
                                postVideo: postVideo);
                          },
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      reportTitle[index],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: Colors.grey,
                        );
                      },
                      itemCount: reportTitle.length)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
