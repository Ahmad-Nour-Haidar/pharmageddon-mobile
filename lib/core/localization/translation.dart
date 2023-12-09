import 'package:get/get.dart';

import '../constant/app_strings.dart';

class MyTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          AppStrings.language: 'Language',
          AppStrings.arabic: 'عربي',
          AppStrings.english: 'English',
          AppStrings.login: 'Login',
          AppStrings.createAccount: 'Create account',
          AppStrings.email: 'Email',
          AppStrings.emailOrPhone: 'Email or Phone',
          AppStrings.emailOrPhoneNotValid: 'Email or Phone not valid',
          AppStrings.userName: 'User Name',
          AppStrings.phoneNumber: 'Phone Number',
          AppStrings.address: 'Address',
          AppStrings.password: 'Password',
          AppStrings.register: 'Register',
          AppStrings.edit: 'Edit',
          AppStrings.haveAnAccount: 'Have an account ?',
          AppStrings.loginNow: 'Login now',
          AppStrings.or: 'OR',
          AppStrings.thisFieldCantBeEmpty: 'This field can\'t be empty',
          AppStrings.lengthMustBeBetween: 'Length must be between',
          AppStrings.notValid: 'Not valid',
          AppStrings.emailMustBeEndWith: 'Email must be end with',
          AppStrings.phone: 'Phone',
          AppStrings.thePhoneNumberMustStartWith:
              'The phone number must start with 09 and have a total of 10 digits',
          AppStrings.passwordMustBeAtLeast8:
              'Password must be at least 8 characters and contain a mix of uppercase and lowercase letters, numbers, and special characters.',
          AppStrings.doNotHaveAnAccount: 'Don\'t have an account ?',
          AppStrings.passwordNotCorrect: 'Password not correct',
          AppStrings.userNotFound: 'User not found',
          AppStrings.verifyCodeNotCorrect: 'Verify code not correct',
          AppStrings.verifyCodeNotSentTryAgain:
              'Verify code not sent, Try again!',
          AppStrings.goToTheOtherPlatform: 'Go to the other platform',
          AppStrings.resendVerifyCode: 'Resend verify code',
          AppStrings.emailOrPasswordIsWrong: 'Email or password is wrong.',
          AppStrings.phoneOrPasswordIsWrong: 'Phone or password is wrong.',
          AppStrings.forgetPassword: 'Forget Password',
          AppStrings.check: 'Check',
          AppStrings.checkEmail: 'Check email',
          AppStrings.reset: 'Reset',
          AppStrings.resetPassword: 'Reset password',
          AppStrings.confirm: 'Confirm',
          AppStrings.passwordsNoMatch: 'Passwords No Match',
          AppStrings.somethingWentWrong: 'Something went wrong',
          AppStrings.welcomeBack: 'Welcome Back',
          AppStrings.name: 'Name',
          AppStrings.youAreOffline: 'You are offline',
          AppStrings.field: 'Field',
          AppStrings.alreadyBeenTaken: 'already been taken.',
          AppStrings.enterTheVerificationCodeYouReceivedOnGmail:
              'Enter the verification code you received on Gmail',
          AppStrings.enterTheCompleteVerificationCode:
              'Enter the complete verification code.',
          AppStrings.verify: 'Verify',
          AppStrings.verifyCode: 'Verify Code',
          AppStrings.price: 'Price',
          AppStrings.totalPrice: 'Total price',
          AppStrings.totalQuantity: 'Total quantity',
          AppStrings.numberOfMedications: 'Number of medications',
          AppStrings.priceAfterDiscount: 'Price after discount',
          AppStrings.discount: 'Discount',
          AppStrings.saveInCart: 'Save in cart',
          AppStrings.done: 'Done',
          AppStrings.home: 'Home',
          AppStrings.manufacturers: 'Manufacturers',
          AppStrings.pharmacologicalEffect: 'Pharmacological effect',
          AppStrings.profile: 'Profile',
          AppStrings.cart: 'Cart',
          AppStrings.favorite: 'Favorite',
          AppStrings.orders: 'Orders',
          AppStrings.reports: 'Reports',
          AppStrings.logOut: 'Log Out',
          AppStrings.doYouWantToLogOut: 'Do you want to log out?',
          AppStrings.yes: 'Yes',
          AppStrings.no: 'No',
          AppStrings.pressBackAgainToExit: 'Press back again to exit',
          AppStrings.searchResultsFor: 'Search results for',
          AppStrings.search: 'Search',
          AppStrings.typeSomethingToSearchOnIt:
              'Type something\nto search on it ...',
          AppStrings.medicationDetails: 'Medication details',
          AppStrings.scientificName: 'Scientific name',
          AppStrings.commercialName: 'Commercial name',
          AppStrings.description: 'Description',
          AppStrings.availableQuantity: 'Available quantity',
          AppStrings.expirationDate: 'Expiration Date',
          AppStrings.manufacturer: 'Manufacturer',
          AppStrings.effect: 'Effect',
          AppStrings.sp: 'S.P',
          AppStrings.all: 'All',
          AppStrings.savedSuccessfully: 'Saved successfully',
          AppStrings.quantity: 'Quantity',
          AppStrings.order: 'Order',
          AppStrings.yourBillIsEmpty: 'Your bill is empty ..!',
          AppStrings.start: 'Start',
          AppStrings.end: 'End',
          AppStrings.preparing: 'Preparing',
          AppStrings.hasBeenSent: 'Has been sent',
          AppStrings.received: 'Received',
        },
        'ar': {
          AppStrings.language: 'اللغة',
          AppStrings.arabic: 'عربي',
          AppStrings.english: 'English',
          AppStrings.login: 'تسجيل الدخول',
          AppStrings.createAccount: 'انشاء حساب',
          AppStrings.email: 'البريد الإلكتروني',
          AppStrings.emailOrPhone: 'البريد الإلكتروني او رقم الهاتف',
          AppStrings.emailOrPhoneNotValid:
              'البريد الإلكتروني او رقم الهاتف غير صالح',
          AppStrings.userName: 'اسم المستخدم',
          AppStrings.phoneNumber: 'رقم الهاتف',
          AppStrings.address: 'العنوان',
          AppStrings.password: 'كلمة المرور',
          AppStrings.register: 'سجل',
          AppStrings.edit: 'تعديل',
          AppStrings.haveAnAccount: 'لديك حساب ؟',
          AppStrings.loginNow: 'سجل الآن',
          AppStrings.or: 'او',
          AppStrings.thisFieldCantBeEmpty: 'هذا الحقل لا يمكن ان يكون فارغا',
          AppStrings.lengthMustBeBetween: 'يجب أن يكون الطول بين',
          AppStrings.notValid: 'غير صالح',
          AppStrings.emailMustBeEndWith: 'يجب أن ينتهي البريد الإلكتروني بـ',
          AppStrings.phone: 'رقم الهاتف',
          AppStrings.thePhoneNumberMustStartWith:
              'يجب أن يبدأ رقم الهاتف بالرقم 09 وأن يتكون من 10 أرقام',
          AppStrings.passwordMustBeAtLeast8:
              'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل وأن تحتوي على مزيج من الأحرف الكبيرة والصغيرة والأرقام والأحرف الخاصة.',
          AppStrings.passwordNotCorrect: 'كلمة المرور غير صحيحة',
          AppStrings.userNotFound: 'لم يتم العثور على المستخدم',
          AppStrings.verifyCodeNotCorrect: 'رمز التحقق غير صحيح',
          AppStrings.verifyCodeNotSentTryAgain:
              'لم يتم إرسال رمز التحقق، حاول مرة أخرى!',
          AppStrings.goToTheOtherPlatform: 'انتقل إلى المنصة الأخرى',
          AppStrings.check: 'تحقق',
          AppStrings.checkEmail: 'فحص البريد الإلكتروني',
          AppStrings.reset: 'إعادة ضبط',
          AppStrings.verify: 'تحقق',
          AppStrings.verifyCode: 'التحقق من الكود',
          AppStrings.resetPassword: 'إعادة تعيين كلمة المرور',
          AppStrings.confirm: 'تأكيد',
          AppStrings.passwordsNoMatch: 'كلمات المرور غير متطابقة',
          AppStrings.somethingWentWrong: 'هناك خطأ ما',
          AppStrings.name: 'الاسم',
          AppStrings.welcomeBack: 'اهلا بعودتك',
          AppStrings.forgetPassword: 'نسيت كلمة المرور',
          AppStrings.resendVerifyCode: 'إعادة إرسال رمز التحقق',
          AppStrings.emailOrPasswordIsWrong:
              'البريد الإلكتروني أو كلمة المرور خاطئة.',
          AppStrings.phoneOrPasswordIsWrong: 'الهاتف أو كلمة المرور خاطئة.',
          AppStrings.doNotHaveAnAccount: 'ليس لديك حساب ؟',
          AppStrings.field: 'حقل',
          AppStrings.alreadyBeenTaken: 'بالفعل تم اخذها.',
          AppStrings.enterTheVerificationCodeYouReceivedOnGmail:
              'أدخل رمز التحقق الذي تلقيته على Gmail',
          AppStrings.enterTheCompleteVerificationCode: 'ادخل كامل رمز التحقق.',
          AppStrings.price: 'السعر',
          AppStrings.totalPrice: 'السعر الاجمالي',
          AppStrings.totalQuantity: 'الكمية الإجمالية',
          AppStrings.numberOfMedications: 'عدد الأدوية',
          AppStrings.priceAfterDiscount: 'السعر بعد الخصم',
          AppStrings.discount: 'خصم',
          AppStrings.saveInCart: 'حفظ في السلة',
          AppStrings.done: 'تم',
          AppStrings.home: 'الرئيسية',
          AppStrings.manufacturers: 'الشركات المصنعة',
          AppStrings.pharmacologicalEffect: 'التأثير الدوائي',
          AppStrings.profile: 'الملف الشخصي',
          AppStrings.cart: 'السلة',
          AppStrings.favorite: 'المفضلة',
          AppStrings.orders: 'طلبات',
          AppStrings.reports: 'التقارير',
          AppStrings.logOut: 'تسجيل الخروج',
          AppStrings.doYouWantToLogOut: 'هل تريد تسجيل خروج ؟',
          AppStrings.yes: 'نعم',
          AppStrings.no: 'لا',
          AppStrings.pressBackAgainToExit: 'اضغط مرة أخرى للخروج',
          AppStrings.searchResultsFor: 'نتائج البحث عن',
          AppStrings.search: 'بحث',
          AppStrings.typeSomethingToSearchOnIt: 'اكتب شيئًا\nللبحث عنه ...',
          AppStrings.medicationDetails: 'تفاصيل الدواء',
          AppStrings.scientificName: 'الاسم العلمي',
          AppStrings.commercialName: 'الاسم التجاري',
          AppStrings.description: 'الوصف',
          AppStrings.availableQuantity: 'الكمية المتوفرة',
          AppStrings.expirationDate: 'تاريخ انتهاء الصلاحية',
          AppStrings.manufacturer: 'الصانع',
          AppStrings.effect: 'التأثير',
          AppStrings.sp: 'ل.س',
          AppStrings.all: 'الكل',
          AppStrings.savedSuccessfully: 'تم الحفظ بنجاح',
          AppStrings.quantity: 'الكمية',
          AppStrings.order: 'طلب',
          AppStrings.yourBillIsEmpty: 'فاتورتك فارغة ..!',
          AppStrings.start: 'بداية',
          AppStrings.end: 'نهاية',
          AppStrings.preparing: 'قيد التحضير',
          AppStrings.hasBeenSent: 'تم الإرسال',
          AppStrings.received: 'تم الإستلام',

        },
      };
}
