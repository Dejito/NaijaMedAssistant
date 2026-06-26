import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_viewmodel/ai_chat_cubit.dart';
import 'package:naija_med_assistant/presentation/dashboard/widgets/dashboard_widgets.dart';
import 'package:naija_med_assistant/app_launch.dart';
import 'package:naija_med_assistant/router/route.dart';

class SymptomCheckListview extends StatefulWidget {
  const SymptomCheckListview({super.key});

  @override
  State<SymptomCheckListview> createState() => _SymptomCheckListviewState();
}

class _SymptomCheckListviewState extends State<SymptomCheckListview> {
  @override
  void initState() {
    super.initState();
    final aiChatCubit = getIt<AiChatCubit>();
    if (aiChatCubit.state.patientSymptomCheckHistoryResponse == null &&
        !aiChatCubit.state.isLoadingSymptomHistory) {
      aiChatCubit.getPatientSymptomChecksHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiChatCubit, AiChatState>(
      bloc: getIt<AiChatCubit>(),
      builder: (context, state) {
        if (state.isLoadingSymptomHistory) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.symptomHistoryError != null &&
            (state.patientSymptomCheckHistoryResponse?.items?.isEmpty ?? true)) {
          return Center(child: Text(state.symptomHistoryError!));
        }

        final items = state.patientSymptomCheckHistoryResponse?.items ?? [];
        if (items.isEmpty) {
          return const Center(child: Text('No symptom checks found.'));
        }

        return Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: items.length,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () {
                  context.push(AppRoutes.patientSymptomCheckSummaryScreen,
                      extra: items[i]);
                },
                child: symptomCheckHistoryItemFromServer(items[i]),
              );
            },
          ),
        );
      },
    );
  }
}
