import 'package:auto_sparkle/common/functions.dart';
import 'package:auto_sparkle/common/models/serializable_model.dart';
import 'package:auto_sparkle/common/widgets/appbar.dart';
import 'package:auto_sparkle/common/widgets/drawer/custom_navigation_drawer.dart';
import 'package:auto_sparkle/message-component/models/message_model.dart';
import 'package:auto_sparkle/message-component/services/message_service.dart';
import 'package:auto_sparkle/message-component/widgets/expanding_message.dart';
import 'package:auto_sparkle/message-component/widgets/message_button.dart';
import 'package:auto_sparkle/message-component/widgets/no_messages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessagesPage extends StatelessWidget {
  final String _title = 'Messages';

  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget<MessagesPage>(title: _title),
      drawer: const CustomNavigationDrawer<MessagesPage>(),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Functions.horizontalScreenMargin(context),
          vertical: 10,
        ),
        child: Consumer<MessageService>(
          builder: (context, service, _) =>
              FutureBuilder<List<SerializableModel<Message>>>(
            future: service.getMessagesAsync(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final List<SerializableModel<Message>> messages = snapshot.data!;
              if (messages.isEmpty) {
                return const Align(
                  alignment: Alignment.topCenter,
                  child: NoMessagesWidget(),
                );
              }

              return Column(
                children: [
                  Expanded(child: _buildMessageList(messages)),
                  _buildButtonBar(service),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMessageList(List<SerializableModel<Message>> messages) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: messages.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) => ExpandingMessageWidget(
        key: ValueKey(messages[index].model.id),
        messageId: messages[index].model.id,
      ),
    );
  }

  Widget _buildButtonBar(MessageService service) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MessageButtonWidget(
            isPrimary: false,
            icon: const Icon(Icons.menu_book_outlined),
            text: 'Read All',
            onPressed: () => service.readAllMessagesAsync(),
          ),
          MessageButtonWidget(
            icon: const Icon(Icons.delete_sweep),
            text: 'Dismiss All',
            onPressed: () => service.dismissAllMessagesAsync(),
          ),
        ],
      ),
    );
  }
}
