import 'package:eschool/utils/labelKeys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportTabSelectionState {

  ReportTabSelectionState({
    required this.reportFilterTabTitle,
  });
  //assignment or Online Exam
  final String reportFilterTabTitle;
}

class ReportTabSelectionCubit extends Cubit<ReportTabSelectionState> {
  ReportTabSelectionCubit()
      : super(
          ReportTabSelectionState(
            reportFilterTabTitle: assignmentKey,
          ),
        ); //assignment by default

  void changeReportFilterTabTitle(String reportFilterTabTitle) {
    emit(
      ReportTabSelectionState(
        reportFilterTabTitle: reportFilterTabTitle,
      ),
    );
  }

  bool isReportAssignment() {
    //change bool to int If required to use further for API
    return state.reportFilterTabTitle == assignmentKey;
  }
}
