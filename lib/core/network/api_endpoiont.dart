abstract class EndPoints {
  static const String baseUrl = 'https://grow-server-beta.vercel.app/api/v1';
  static const String refreshToken = 'refreshToken';
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String deleteAccount = '/auth/delete-account';
  static const String verifyOtp = '/auth/verify-otp';
  static const String resendOtp = '/auth/resend-otp';
  static const String sendOtp = '/auth/send-otp';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyToken = '/auth/verify';
  static const String kiosks = '/kiosks';
  static const String dashboardOwner = '/dashboard/owner';
  static const String dashboardWorker = '/dashboard/worker';
  static const String inviteWorker = '/kiosks/invite';
  static String kioskWorkers(String kioskId) => '/kiosks/$kioskId/workers';
  static String kioskDetails(String kioskId) => '/kiosks/$kioskId';
  static String kioskReports(String kioskId, int month, int year) =>
      '/kiosks/$kioskId/reports?month=$month&year=$year';
  static String kioskGoals(String kioskId) => '/goals/$kioskId';
  static const String transactions = '/transactions/';
  static const String redeem = '/wallet/redeem';
  static const String walletBalance = '/wallet/balance';
  static const String profile = '/profile';
  static const String invitations = '/kiosks/invitations';
  static String respondToInvitation(String invitationId) =>
      '/kiosks/invitations/$invitationId';
  static const String workerReport = '/kiosks/worker/report';
  static const String goals = '/goals';
  static const String profileWorker = '/profile/worker';
  static const String profileKiosks = '/kiosks/worker/kiosks';
  static const String notificationsOwner = '/notifications/owner';
  static const String notificationsWorker = '/notifications/worker';
  static String workerDetails(String workerId) => '/kiosks/workers/$workerId';
  static const String support = '/profile/support';
}
