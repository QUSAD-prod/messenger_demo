part of 'confirm_email_bloc.dart';

abstract class ConfirmEmailEvent {}

class CheckConfirmEmailEvent extends ConfirmEmailEvent {}

class SendConfirmEmailEvent extends ConfirmEmailEvent {}
