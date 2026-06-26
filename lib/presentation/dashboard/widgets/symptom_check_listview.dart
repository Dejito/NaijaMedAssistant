import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_viewmodel/ai_chat_cubit.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_viewmodel/ai_chat_module_states/get_patient_symptoms_check_history.dart';
import 'package:naija_med_assistant/presentation/dashboard/widgets/dashboard_widgets.dart';
import 'package:naija_med_assistant/app_launch.dart';
import 'package:naija_med_assistant/router/route.dart';

class SymptomCheckListview extends StatelessWidget {
  const SymptomCheckListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiChatCubit, AiChatState>(
      bloc: getIt<AiChatCubit>(),
      builder: (context, state) {
        if (state is GetPatientSymptomsCheckLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetPatientSymptomsCheckSuccessful) {
          final items = state.patientSymptomCheckHistoryResponse.items ?? [];
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
                    onTap: (){context.push(AppRoutes.patientSymptomCheckSummaryScreen, extra: items[i]);},
                    child: symptomCheckHistoryItemFromServer(items[i]));
              },
            ),
          );
        }

        return const Center(child: Text('No symptom checks found.'));
      },
    );
  }
}
