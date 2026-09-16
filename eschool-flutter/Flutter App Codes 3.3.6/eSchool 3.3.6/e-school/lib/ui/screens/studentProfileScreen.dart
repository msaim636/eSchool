import 'package:eschool/data/models/student.dart';
import 'package:eschool/ui/widgets/customAppbar.dart';
import 'package:eschool/ui/widgets/customUserProfileImageWidget.dart';
import 'package:eschool/ui/widgets/dynamicFieldListContainer.dart';
import 'package:eschool/utils/assets.dart';
import 'package:eschool/utils/labelKeys.dart';
import 'package:eschool/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StudentProfileScreen extends StatefulWidget {

  const StudentProfileScreen({required this.studentDetails, super.key});
  final Student studentDetails;

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();

  static Route route(RouteSettings routeSettings) {
    return CupertinoPageRoute(
      builder: (_) => StudentProfileScreen(
        studentDetails: routeSettings.arguments! as Student,
      ),
    );
  }
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  Widget _buildProfileDetailsTile({
    required String label,
    required String value,
    required String iconUrl,
    Color? iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12.5),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1a212121),
                  offset: Offset(0, 10),
                  blurRadius: 16,
                ),
              ],
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(15),
            ),
            child: SvgPicture.asset(
              iconUrl,
              colorFilter: iconColor == null
                  ? null
                  : ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ),
          SizedBox(width: MediaQuery.sizeOf(context).width * 0.05),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Align(
      alignment: Alignment.topCenter,
      child: CustomAppBar(
        title: UiUtils.getTranslatedLabel(context, profileKey),
      ),
    );
  }

  Widget _buildProfileDetailsContainer() {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: UiUtils.getScrollViewTopPadding(
            context: context,
            appBarHeightPercentage: UiUtils.appBarSmallerHeightPercentage,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 0.25,
              height: MediaQuery.sizeOf(context).width * 0.25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary,
              ),
              child: CustomUserProfileImageWidget(
                profileUrl: widget.studentDetails.image,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.studentDetails.getFullName(),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${UiUtils.getTranslatedLabel(context, grNumberKey)} - ${widget.studentDetails.admissionNo}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.075,
              ),
              child: Divider(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.75),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.075,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      UiUtils.getTranslatedLabel(context, personalDetailsKey),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  _buildProfileDetailsTile(
                    label: UiUtils.getTranslatedLabel(context, classKey),
                    value: UiUtils.formatEmptyValue(
                      widget.studentDetails.classSectionNameWithSemester(
                        context: context,
                      ),
                    ),
                    iconUrl: Assets.userProClassIcon,
                  ),
                  _buildProfileDetailsTile(
                    label: UiUtils.getTranslatedLabel(context, mediumKey),
                    value: UiUtils.formatEmptyValue(
                      widget.studentDetails.mediumName,
                    ),
                    iconUrl: Assets.mediumIcon,
                  ),
                  if (widget.studentDetails.shift != null &&
                      widget.studentDetails.shift!.title.trim().isNotEmpty)
                    _buildProfileDetailsTile(
                      label: UiUtils.getTranslatedLabel(context, shiftKey),
                      value: UiUtils.formatEmptyValue(
                        "${widget.studentDetails.shift!.title}${widget.studentDetails.shift!.startToEndTime == null ? '' : ' (${widget.studentDetails.shift!.startToEndTime})'}",
                      ),
                      iconUrl: Assets.userProShiftIcon,
                    ),
                  _buildProfileDetailsTile(
                    label: UiUtils.getTranslatedLabel(context, rollNumberKey),
                    value: widget.studentDetails.rollNumber.toString(),
                    iconUrl: Assets.userProRollNoIcon,
                  ),
                  _buildProfileDetailsTile(
                    label: UiUtils.getTranslatedLabel(context, dateOfBirthKey),
                    value: UiUtils.formatEmptyValue(
                      DateTime.tryParse(widget.studentDetails.dob) == null
                          ? widget.studentDetails.dob
                          : UiUtils.formatDate(
                              DateTime.tryParse(widget.studentDetails.dob)!,
                            ),
                    ),
                    iconUrl: Assets.userProDobIcon,
                  ),
                  _buildProfileDetailsTile(
                    label: UiUtils.getTranslatedLabel(
                      context,
                      currentAddressKey,
                    ),
                    value: UiUtils.formatEmptyValue(
                      widget.studentDetails.currentAddress,
                    ),
                    iconUrl: Assets.userProAddressIcon,
                  ),
                  _buildProfileDetailsTile(
                    label: UiUtils.getTranslatedLabel(
                      context,
                      permanentAddressKey,
                    ),
                    value: UiUtils.formatEmptyValue(
                      widget.studentDetails.permanentAddress,
                    ),
                    iconUrl: Assets.userProAddressIcon,
                  ),
                  _buildProfileDetailsTile(
                    label: UiUtils.getTranslatedLabel(context, bloodGroupKey),
                    value: UiUtils.formatEmptyValue(
                      widget.studentDetails.bloodGroup,
                    ),
                    iconUrl: Assets.bloodIcon,
                  ),
                  _buildProfileDetailsTile(
                    label: UiUtils.getTranslatedLabel(context, weightKey),
                    value: UiUtils.formatEmptyValue(
                      widget.studentDetails.weight,
                    ),
                    iconUrl: Assets.weightIcon,
                  ),
                  _buildProfileDetailsTile(
                    label: UiUtils.getTranslatedLabel(context, heightKey),
                    value: UiUtils.formatEmptyValue(
                      widget.studentDetails.height,
                    ),
                    iconUrl: Assets.heightIcon,
                  ),
                ],
              ),
            ),
            //dynamic field data
            if (widget.studentDetails.dynamicFields != null)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.075,
                ),
                child: Divider(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.75),
                ),
              ),
            if (widget.studentDetails.dynamicFields?.isNotEmpty ?? false) ...[
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.075,
                ),
                child: DynamicFieldListContainer(
                  dynamicFields: widget.studentDetails.dynamicFields!,
                ),
              ),
            ],
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [_buildProfileDetailsContainer(), _buildAppBar()]),
    );
  }
}
