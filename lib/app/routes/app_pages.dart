import 'package:get/get_navigation/src/routes/get_route.dart';
import '../screens/about_company/about_us_screen.dart';
import '../screens/app_settings/setting_screen.dart';
import '../screens/contact_us/contact_us_screen.dart';
import '../screens/email_verify/email_verify_screen.dart';
import '../screens/forget_password/forget_password_screen.dart';
import '../screens/home/home_page.dart';
import '../screens/home/home_widget/video_frame.dart';
import '../screens/home/video_in_full_screen.dart';
import '../screens/introduction/introduction.dart';
import '../screens/login/login_screen.dart';
import '../screens/login_user_profile_detail/login_user_personal_detail_screen.dart';
import '../screens/login_user_profile_detail/login_user_profile_detail_screen.dart';
import '../screens/login_user_profile_detail/login_user_set_availability_screen.dart';
import '../screens/messages/chat_user_list.dart';
import '../screens/messages/user_chat_screen.dart';
import '../screens/my_Orders/check_order_summary.dart';
import '../screens/my_Orders/my_order_screen.dart';
import '../screens/my_Orders/view_services_taker_profile_detail.dart';
import '../screens/my_accounts/change_password_screen.dart';
import '../screens/my_accounts/my_account_screen.dart';
import '../screens/my_accounts/user_availability_screen.dart';
import '../screens/my_accounts/user_profile_screen.dart';
import '../screens/my_accounts/user_services_screen.dart';
import '../screens/my_dispute/add_new_dispute_screen.dart';
import '../screens/my_dispute/dispute_screen.dart';
import '../screens/my_dispute/view_dispute_detail_screen.dart';
import '../screens/my_wallet/my_wallet_screen.dart';
import '../screens/my_wallet/view_wallet_order_summary.dart';
import '../screens/noification/notification_screen.dart';
import '../screens/payment/payments_screen.dart';
import '../screens/phone_verify/phone_number_verify_screen.dart';
import '../screens/signup/signup_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/user_info/user_information_screen.dart';
import '../screens/welcome/welcome_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const Splash(),
    ),
    GetPage(
      name: AppRoutes.introduction,
      page: () => const IntroScreen(),
    ),
    GetPage(
      name: AppRoutes.welcome_screen,
      page: () => const WelcomeScreen(),
    ),
    GetPage(
      name: AppRoutes.signUp_Screen,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () =>  const Login(),
    ),
    GetPage(
      name: AppRoutes.forGetPasswordScreen,
      page: () =>  const ForgetPassScreen(),
    ),
    GetPage(
      name: AppRoutes.emailVerify,
      page: () =>  const EmailVerify(),
    ),
    GetPage(
      name: AppRoutes.phoneVerify,
      page: () =>  const PhoneVerify(),
    ),
    GetPage(
      name: AppRoutes.userInformation,
      page: () =>  const UserInformation(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRoutes.myAccount,
      page: () => const MyAccountScreen(),
    ),
    GetPage(
      name: AppRoutes.myOrderScreen,
      page: () => const MyOrderScreen(),
    ),
    GetPage(
      name: AppRoutes.disputeScreen,
      page: () => const DisputeScreen(),
    ),
    GetPage(
      name: AppRoutes.notificationScreen,
      page: () => const NotificationScreen(),
    ),
    GetPage(
      name: AppRoutes.paymentsScreen,
      page: () => const PaymentsScreen(),
    ),
    GetPage(
      name: AppRoutes.walletScreen,
      page: () => const MyWalletScreen(),
    ),
    GetPage(
      name: AppRoutes.messagesScreen,
      page: () => const MessagesScreen(),
    ),
    GetPage(
      name: AppRoutes.settingsScreen,
      page: () => const SettingScreen(),
    ),
    GetPage(
      name: AppRoutes.changePasswordScreen,
      page: () => const ChangePasswordScreen(),
    ),
    GetPage(
      name: AppRoutes.userProfileScreen,
      page: () => const UserProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.userServicesScreen,
      page: () => const UserServicesScreen(),
    ),
    GetPage(
      name: AppRoutes.userAvailabilityScreen,
      page: () => const UserAvailabilityScreen(),
    ),
    GetPage(
      name: AppRoutes.orderSummary,
      page: () => const OrderSummaryScreen(),
    ),
    GetPage(
      name: AppRoutes.viewServicesTakerProfile,
      page: () => const ViewServicesTakerProfile(),
    ),
    GetPage(
      name: AppRoutes.createNewDispute,
      page: () => const AddNewDisputeScreen(),
    ),
    GetPage(
      name: AppRoutes.viewDisputeDetail,
      page: () => const ViewDisputeDetailScreen(),
    ),
    GetPage(
      name: AppRoutes.userChatScreen,
      page: () => const UserChatScreen(),
    ),
    GetPage(
      name: AppRoutes.viewWalletOrderSummary,
      page: () => const ViewWalletOrderSummary(),
    ),
    GetPage(
      name: AppRoutes.contactUsScreen,
      page: () => const ContactUsScreen(),
    ),
    GetPage(
      name: AppRoutes.aboutUsScreen,
      page: () => const AboutUsScreen(),
    ),
    GetPage(
      name: AppRoutes.youTubeFrame,
      page: () => const YouTube(),
    ),
    GetPage(
      name: AppRoutes.loginUserProfileDetail,
      page: () => const LoginUserProfileDetailScreen(),
    ),
    GetPage(
      name: AppRoutes.loginUserPersonalDetail,
      page: () => const LoginUserPersonalDetailsScreen(),
    ),
    GetPage(
      name: AppRoutes.loginUserSetAvailability,
      page: () => const SetLoginUserAvailabilityScreen(),
    ),
    GetPage(
      name: AppRoutes.openVideoInFullScreen,
      page: () =>  FullScreenVideoPage(),
    ),
  ];
}
