/// Android channel IDs, names, descriptions, and iOS thread identifiers for each notification category.
abstract final class NotificationChannelConstants {
  /// Android channel ID for appointment reminder notifications.
  static const String appointmentChannelId = 'appointment_reminders';

  /// User-visible name of the appointment reminders channel.
  static const String appointmentChannelName = 'Promemoria appuntamenti';

  /// User-visible description of the appointment reminders channel.
  static const String appointmentChannelDescription =
      'Promemoria il giorno prima di un appuntamento';

  /// iOS thread identifier used to group appointment notifications together.
  static const String appointmentThreadId = 'appointments';

  /// Android channel ID for subscription payment reminder notifications.
  static const String subscriptionChannelId = 'subscription_reminders';

  /// User-visible name of the subscription reminders channel.
  static const String subscriptionChannelName = 'Promemoria pagamenti';

  /// User-visible description of the subscription reminders channel.
  static const String subscriptionChannelDescription =
      'Promemoria il giorno prima di un pagamento abbonamento';

  /// iOS thread identifier used to group subscription notifications together.
  static const String subscriptionThreadId = 'subscriptions';

  /// Android channel ID for financing instalment reminder notifications.
  static const String financingChannelId = 'financing_reminders';

  /// User-visible name of the financing reminders channel.
  static const String financingChannelName = 'Promemoria rate';

  /// User-visible description of the financing reminders channel.
  static const String financingChannelDescription =
      'Promemoria il giorno prima di una rata';

  /// iOS thread identifier used to group financing notifications together.
  static const String financingThreadId = 'financings';
}

/// Notification titles, body builders, and scheduling parameters for all expense categories.
abstract final class NotificationContentConstants {
  /// Title for appointment reminder notifications.
  static const String appointmentTitle = 'Promemoria appuntamento';

  /// Title for subscription payment reminder notifications.
  static const String subscriptionTitle = 'Promemoria pagamento';

  /// Title for financing instalment reminder notifications.
  static const String financingTitle = 'Promemoria rata';

  /// Body text for an appointment reminder, including the appointment [name].
  static String appointmentBody(String name) =>
      'L\'appuntamento $name è domani';

  /// Body text for a subscription reminder, including the subscription [name] and [amount].
  static String subscriptionBody(String name, double amount) =>
      '$name - ${amount.toStringAsFixed(2)}€ - Pagamento domani';

  /// Body text for a financing reminder, including the financing [name] and instalment [amount].
  static String financingBody(String name, double amount) =>
      '$name - ${amount.toStringAsFixed(2)}€ - Pagamento domani';

  /// Hour of the day (24-hour) at which reminders are delivered.
  static const int reminderHour = 9;

  /// Maximum value for notification IDs; used to partition ID namespaces per expense type.
  static const int notificationIdRange = 100000;
}
