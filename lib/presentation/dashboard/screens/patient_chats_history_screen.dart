import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/app_launch.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_service/response/chat_history_response.dart';
import 'package:naija_med_assistant/presentation/ai_chat/ai_chat_viewmodel/ai_chat_cubit.dart';
import 'package:naija_med_assistant/router/route.dart';

class PatientChatsHistoryScreen extends StatefulWidget {
  const PatientChatsHistoryScreen({super.key});

  @override
  State<PatientChatsHistoryScreen> createState() => _PatientChatsHistoryScreenState();
}

class _PatientChatsHistoryScreenState extends State<PatientChatsHistoryScreen> {
  @override
  void initState() {
    super.initState();
    final aiChatCubit = getIt<AiChatCubit>();
    if (aiChatCubit.state.chatsHistoryResponse == null &&
        !aiChatCubit.state.isLoadingChatHistory) {
      aiChatCubit.getChatsHistory();
    }
  }

  String _getRelativeTime(String? dateStr) {
    if (dateStr == null) return 'Recent';
    try {
      final parsedDate = DateTime.parse(dateStr);
      final difference = DateTime.now().difference(parsedDate).inDays;
      if (difference <= 0) return 'Today';
      if (difference == 1) return 'Yesterday';
      return '$difference Days Ago';
    } catch (_) {
      return 'Recent';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiChatCubit, AiChatState>(
      bloc: getIt<AiChatCubit>(),
      builder: (context, state) {
        if (state.isLoadingChatHistory) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.chatHistoryError != null &&
            (state.chatsHistoryResponse?.conversations?.isEmpty ?? true)) {
          return Center(
            child: Text(
              state.chatHistoryError ?? 'Unable to fetch conversations.',
              style: const TextStyle(color: Colors.grey, fontSize: 15),
            ),
          );
        }

        final conversations =
            state.chatsHistoryResponse?.conversations ?? <ConversationItem>[];

        if (conversations.isEmpty) {
          return const Center(
            child: Text(
              'No conversations found.',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: conversations.length,
          itemBuilder: (context, index) {
            final chat = conversations[index];
            final titleText = chat.medicalCase?.diagnosis ?? 'Conversation Thread';

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.grey.shade100),
              ),
              color: Colors.grey.shade50,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text(
                  titleText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    _getRelativeTime(chat.createdAt),
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                  ),
                ),
                trailing: const Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      'Open Chat',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 13),
                    ),
                    Icon(Icons.chevron_right, size: 16, color: Colors.black),
                  ],
                ),
                onTap: () async {
                  final conversationId = chat.conversationId;
                  if (conversationId == null) return;

                  final aiChatCubit = getIt<AiChatCubit>();
                  // Pre-fetch messages so destination screen can hydrate immediately.
                  await aiChatCubit.getConversationMessages(conversationId);
                  if (!context.mounted) return;

                  final conversationType = (chat.type ?? '').toLowerCase();
                  if (conversationType == 'patient_ai') {
                    context.push(
                      AppRoutes.chatWithAi,
                      extra: <String, dynamic>{
                        'conversationId': conversationId,
                      },
                    );
                    return;
                  }

                  context.push(
                    AppRoutes.doctorChatBoxPatient,
                    extra: <String, dynamic>{
                      'conversationId': conversationId,
                      'isDoctor': false,
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}