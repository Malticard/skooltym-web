// core libraries
// ignore_for_file: depend_on_referenced_packages

export 'package:flutter/services.dart';
export 'dart:async';
export 'package:flutter/foundation.dart';
export 'dart:io';
export 'dart:convert';
export 'package:flutter/material.dart';
export 'package:google_fonts/google_fonts.dart';
export 'package:adaptive_theme/adaptive_theme.dart';
export 'dart:typed_data';

// constants
export '/constants/constants.dart';

// models
export '/models/MyFiles.dart';
export '/models/RecentFile.dart';
// controllers
export '/controllers/MainController.dart';
export '/controllers/WidgetController.dart';
// utils
export '/Utils/responsive.dart';

// 3rd party libs
export 'package:flutter_svg/flutter_svg.dart';
export 'package:data_table_2/data_table_2.dart';
export 'package:fl_chart/fl_chart.dart';
export 'package:provider/provider.dart';
export 'package:flutter_bloc/flutter_bloc.dart';

// screens
export '/screens/dashboard/dashboard_screen.dart';
export '/screens/dashboard/components/chart.dart';
export '/screens/dashboard/components/file_info_card.dart';
export '/screens/dashboard/components/header.dart';
export '/screens/Admin/pages/CroppingView.dart';
export '/screens/dashboard/components/my_fields.dart';
export '../screens/dashboard/components/CustomDataTable.dart';
export '/screens/dashboard/components/storage_details.dart';
export '/screens/dashboard/components/storage_info_card.dart';
export '/screens/main/main_screen.dart';
export '/screens/Auth/login.dart';
export '/screens/Auth/PhoneVerify.dart';
export '/screens/Auth/UpdatePassword.dart';
export '/screens/Auth/Verification.dart';
export '/screens/Auth/AdminProfile.dart';

// global
export '/global/index.dart';

// Observer
export '/Observers/Observer.dart';

// Controllers

// tools
export '/tools/TapEffect.dart';
export '/tools/RemoveFocus.dart';
export '/tools/Validator.dart';
export '/tools/TextThemes.dart';
export '/tools/Utils.dart';
export '/tools/Nav_helper.dart';
export '/screens/dashboard/Data/DataSources.dart';

// widgets
export '/widgets/CommonTextField.dart';
export '/widgets/CommonButton.dart';
export '/widgets/CustomDialog.dart';
export '/widgets/space.dart';
export '/widgets/CommonMenuWidget.dart';
export '/widgets/CommonAppBarView.dart';
export '/widgets/BottomUpAnimation.dart';
export '/widgets/LoaderWidget.dart';
export '/widgets/CommonDropDown.dart';
export '/widgets/CommonFormFields.dart';
export '/widgets/SettingsCard.dart';
export '/widgets/DropDown.dart';
export '/widgets/CommonDelete.dart';
export '/widgets/NoDataWidget.dart';
export '../widgets/ProfileCard_View.dart';
export '/widgets/DividerWidget.dart';
//routes paths
export '/routes/routes.dart';
// file picker

// third party libraries
export 'package:flutter_spinkit/flutter_spinkit.dart';
export 'package:animations/animations.dart';
export 'package:syncfusion_flutter_sliders/sliders.dart';
export 'package:http/http.dart';
export 'package:crop_your_image/crop_your_image.dart';
export 'package:currency_picker/currency_picker.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:file_picker/file_picker.dart';
export 'package:internet_connection_checker/internet_connection_checker.dart';
export 'package:pinput/pinput.dart';
export 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
// models
export '/models/PopUpOptions.dart'; 
export '/models/StaffPopUpOptions.dart';
export '/models/Roles.dart';
export '/models/PaymentModel.dart';
export '/models/StaffModel.dart';
// export '/models/OvertimeModel.dart';
export '/models/Students.dart';
export '/models/StepperModel.dart';

// export '/models/GuardianModel.dart';
export '/models/PickUpModel.dart';
export '/models/ClassModel.dart';
export '/models/DropOffModels.dart';
export '/models/ResultsModel.dart';
export '/models/DashboardModel.dart';
export '/models/StreamModel.dart';

// themes

// constants
export '/constants/app_urls.dart';
// icons
// icons
export '/Icons/SettingIcons.dart';
export '/Icons/StaffIcons.dart';
export '/Icons/Images.dart';

// Controllers
export '/controllers/ThemeController.dart';
export '/controllers/IntervalController.dart';
export '/controllers/OvertimeRateController.dart';
export '/controllers/PickUpAllowanceTimeController.dart';
export '/controllers/DropOffController.dart';
export '/controllers/SchoolController.dart';
export '/controllers/AllowOvertimeController.dart';
export '/controllers/LightDarkController.dart';
export '/controllers/StudentController.dart';
export '/controllers/TitleController.dart';
export '/controllers/OnlineCheckerController.dart';
export '/controllers/DashboardController.dart';
export '/controllers/OvertimeController.dart';
export '/controllers/StepperController.dart';
export '/controllers/ClassNameController.dart';
export '/controllers/SideBarController.dart';
export '/controllers/ImageUploadController.dart';
export '/controllers/ForgotPasswordController.dart';
export '/controllers/SettingsController.dart';
export '/controllers/FinanceViewController.dart';
export '/controllers/MultiStudentsController.dart';
export '/controllers/FinanceTitleController.dart';
export '/controllers/FetchStudents.dart';
export '/controllers/PickUpTimeController.dart';
export '/controllers/DropOffTimeController.dart';
export '/controllers/FirstTimeUserController.dart';
export '/controllers/FinanceFirstTimeController.dart';
export '/controllers/PaymentController.dart';
// util controllers
export '/controllers/utils/ClassesController.dart';
export '/controllers/utils/DropOffController.dart';
export '/controllers/utils/GuardianController.dart';
export '/controllers/utils/StaffController.dart';
export '/controllers/utils/StreamController.dart';
export '/controllers/utils/PickUpsController.dart';
export '/controllers/utils/DashboardData.dart';
export '/controllers/utils/DashboardCardController.dart';


// themes
export '/Themes/Themes.dart';

// ----> Admin routes
export '/screens/Admin/Settings.dart';
export '/screens/Admin/change_password.dart';
export '/screens/Admin/pages/AccountProfile.dart';
export '/screens/Admin/pages/AddGuardian.dart';
export '/screens/Admin/pages/AddStudent.dart';
export '/screens/Admin/pages/Reports.dart';
export '/screens/Admin/pages/Payment.dart';
export '/screens/Admin/pages/Staffs.dart';
export '/screens/Admin/pages/Test.dart';
export '/screens/Admin/pages/Student.dart';
export '/screens/Admin/pages/Guardians.dart';
export '/screens/Admin/pages/AddStaff.dart';
export '/screens/Admin/pages/AddPayment.dart';
export '/screens/Admin/pages/ViewDropOff.dart';
export '/screens/Admin/pages/ViewPickUps.dart';
export '/screens/Admin/pages/Classes.dart';
export '/screens/Admin/settings/AppSettings.dart';
export '/screens/Admin/settings/SystemSettings.dart';
export '/screens/Admin/settings/privacy_policy.dart';
export '/screens/Admin/settings/about.dart';
export '/screens/dashboard/dashboard.dart';
export '/screens/Admin/pages/Streams.dart';
// popups
export '/screens/Admin/pages/PopUps/AddStream.dart';
export '/screens/Admin/pages/PopUps/AddClass.dart';
// === Dash board popups
export '/screens/dashboard/popups/StudentsPopUp.dart';
// end of popups
// updates
export '/screens/Admin/pages/update/UpdateStudent.dart';
export '/screens/Admin/pages/update/UpdateStaff.dart';
export '/screens/Admin/pages/update/UpdateGuardian.dart';
export '/screens/Admin/pages/update/UpdateStream.dart';
export '/screens/Admin/pages/update/UpdateClass.dart';
// --> admin widgets
export '/screens/Admin/widgets/PopOptions.dart';
export '/screens/Admin/widgets/IntervalSlider.dart';
export '/screens/Admin/widgets/RateSlider.dart';
export '/screens/Admin/widgets/PickUpAllowanceSlider.dart';
export '/screens/Admin/widgets/DropOffAllowanceSlider.dart';
export '/screens/Admin/widgets/DashboardCard.dart';
export '/screens/Admin/widgets/ClearWindow.dart';
// --------------------------------------------------------

// --------------------------------------------------------