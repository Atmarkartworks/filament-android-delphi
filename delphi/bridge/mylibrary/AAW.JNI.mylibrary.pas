
unit AAW.JNI.mylibrary;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Java.Security,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os,
  Androidapi.JNI.Util,
  Androidapi.JNI.Widget;

type
// ===== Forward declarations =====

  JAnimator = interface;//android.animation.Animator
  JAnimator_AnimatorListener = interface;//android.animation.Animator$AnimatorListener
  JAnimator_AnimatorPauseListener = interface;//android.animation.Animator$AnimatorPauseListener
  JKeyframe = interface;//android.animation.Keyframe
  JLayoutTransition = interface;//android.animation.LayoutTransition
  JLayoutTransition_TransitionListener = interface;//android.animation.LayoutTransition$TransitionListener
  JPropertyValuesHolder = interface;//android.animation.PropertyValuesHolder
  JStateListAnimator = interface;//android.animation.StateListAnimator
  JTimeInterpolator = interface;//android.animation.TimeInterpolator
  JTypeConverter = interface;//android.animation.TypeConverter
  JTypeEvaluator = interface;//android.animation.TypeEvaluator
  JValueAnimator = interface;//android.animation.ValueAnimator
  JValueAnimator_AnimatorUpdateListener = interface;//android.animation.ValueAnimator$AnimatorUpdateListener
  JValueAnimator_DurationScaleChangeListener = interface;//android.animation.ValueAnimator$DurationScaleChangeListener
  JGetCredentialRequest = interface;//android.credentials.GetCredentialRequest
  JULocale = interface;//android.icu.util.ULocale
  JULocale_AvailableType = interface;//android.icu.util.ULocale$AvailableType
  JULocale_Category = interface;//android.icu.util.ULocale$Category
  JPathMotion = interface;//android.transition.PathMotion
  JScene = interface;//android.transition.Scene
  JTransition = interface;//android.transition.Transition
  JTransition_EpicenterCallback = interface;//android.transition.Transition$EpicenterCallback
  JTransition_TransitionListener = interface;//android.transition.Transition$TransitionListener
  JTransitionManager = interface;//android.transition.TransitionManager
  JTransitionPropagation = interface;//android.transition.TransitionPropagation
  JTransitionValues = interface;//android.transition.TransitionValues
  JInterpolator = interface;//android.view.animation.Interpolator
  JToolbar_LayoutParams = interface;//android.widget.Toolbar$LayoutParams
  JInputTransferToken = interface;//android.window.InputTransferToken
  JOnBackInvokedCallback = interface;//android.window.OnBackInvokedCallback
  JOnBackInvokedDispatcher = interface;//android.window.OnBackInvokedDispatcher
  JSplashScreen = interface;//android.window.SplashScreen
  JSplashScreen_OnExitAnimationListener = interface;//android.window.SplashScreen$OnExitAnimationListener
  JSplashScreenView = interface;//android.window.SplashScreenView
  JTrustedPresentationThresholds = interface;//android.window.TrustedPresentationThresholds
  JMyLibMainActivityUtil = interface;//com.gyabinet.filament.mylibrary.MyLibMainActivityUtil
  JUserPrincipal = interface;//java.nio.file.attribute.UserPrincipal
  JGroupPrincipal = interface;//java.nio.file.attribute.GroupPrincipal

// ===== Interface declarations =====

  JAnimatorClass = interface(JObjectClass)
    ['{3F76A5DF-389E-4BD3-9861-04C5B00CEADE}']
    {class} function _GetDURATION_INFINITE: Int64; cdecl;
    {class} function init: JAnimator; cdecl;
    {class} property DURATION_INFINITE: Int64 read _GetDURATION_INFINITE;
  end;

  [JavaSignature('android/animation/Animator')]
  JAnimator = interface(JObject)
    ['{FA13E56D-1B6D-4A3D-8327-9E5BA785CF21}']
    procedure addListener(listener: JAnimator_AnimatorListener); cdecl;
    procedure addPauseListener(listener: JAnimator_AnimatorPauseListener); cdecl;
    procedure cancel; cdecl;
    function clone: JAnimator; cdecl;
    procedure &end; cdecl;
    function getDuration: Int64; cdecl;
    function getInterpolator: JTimeInterpolator; cdecl;
    function getListeners: JArrayList; cdecl;
    function getStartDelay: Int64; cdecl;
    function getTotalDuration: Int64; cdecl;
    function isPaused: Boolean; cdecl;
    function isRunning: Boolean; cdecl;
    function isStarted: Boolean; cdecl;
    procedure pause; cdecl;
    procedure removeAllListeners; cdecl;
    procedure removeListener(listener: JAnimator_AnimatorListener); cdecl;
    procedure removePauseListener(listener: JAnimator_AnimatorPauseListener); cdecl;
    procedure resume; cdecl;
    function setDuration(duration: Int64): JAnimator; cdecl;
    procedure setInterpolator(value: JTimeInterpolator); cdecl;
    procedure setStartDelay(startDelay: Int64); cdecl;
    procedure setTarget(target: JObject); cdecl;
    procedure setupEndValues; cdecl;
    procedure setupStartValues; cdecl;
    procedure start; cdecl;
  end;
  TJAnimator = class(TJavaGenericImport<JAnimatorClass, JAnimator>) end;

  JAnimator_AnimatorListenerClass = interface(IJavaClass)
    ['{5ED6075A-B997-469C-B8D9-0AA8FB7E4798}']
  end;

  [JavaSignature('android/animation/Animator$AnimatorListener')]
  JAnimator_AnimatorListener = interface(IJavaInstance)
    ['{E2DE8DD6-628B-4D84-AA46-8A1E3F00FF13}']
    procedure onAnimationCancel(animation: JAnimator); cdecl;
    procedure onAnimationEnd(animation: JAnimator); cdecl; overload;
    procedure onAnimationEnd(animation: JAnimator; isReverse: Boolean); cdecl; overload;
    procedure onAnimationRepeat(animation: JAnimator); cdecl;
    procedure onAnimationStart(animation: JAnimator); cdecl; overload;
    procedure onAnimationStart(animation: JAnimator; isReverse: Boolean); cdecl; overload;
  end;
  TJAnimator_AnimatorListener = class(TJavaGenericImport<JAnimator_AnimatorListenerClass, JAnimator_AnimatorListener>) end;

  JAnimator_AnimatorPauseListenerClass = interface(IJavaClass)
    ['{CB0DC3F0-63BC-4284-ADD0-2ED367AE11E5}']
  end;

  [JavaSignature('android/animation/Animator$AnimatorPauseListener')]
  JAnimator_AnimatorPauseListener = interface(IJavaInstance)
    ['{43C9C106-65EA-4A7D-A958-FAB9E43FA4A6}']
    procedure onAnimationPause(animation: JAnimator); cdecl;
    procedure onAnimationResume(animation: JAnimator); cdecl;
  end;
  TJAnimator_AnimatorPauseListener = class(TJavaGenericImport<JAnimator_AnimatorPauseListenerClass, JAnimator_AnimatorPauseListener>) end;

  JKeyframeClass = interface(JObjectClass)
    ['{D383116E-5CCF-48D8-9EA1-B26FBF24BA39}']
    {class} function init: JKeyframe; cdecl;
    {class} function ofFloat(fraction: Single): JKeyframe; cdecl; overload;
    {class} function ofFloat(fraction: Single; value: Single): JKeyframe; cdecl; overload;
    {class} function ofInt(fraction: Single): JKeyframe; cdecl; overload;
    {class} function ofInt(fraction: Single; value: Integer): JKeyframe; cdecl; overload;
    {class} function ofObject(fraction: Single): JKeyframe; cdecl; overload;
    {class} function ofObject(fraction: Single; value: JObject): JKeyframe; cdecl; overload;
  end;

  [JavaSignature('android/animation/Keyframe')]
  JKeyframe = interface(JObject)
    ['{9D0687A4-669E-440F-8290-154739405019}']
    function clone: JKeyframe; cdecl;
    function getFraction: Single; cdecl;
    function getInterpolator: JTimeInterpolator; cdecl;
    function getType: Jlang_Class; cdecl;
    function getValue: JObject; cdecl;
    function hasValue: Boolean; cdecl;
    procedure setFraction(fraction: Single); cdecl;
    procedure setInterpolator(interpolator: JTimeInterpolator); cdecl;
    procedure setValue(value: JObject); cdecl;
  end;
  TJKeyframe = class(TJavaGenericImport<JKeyframeClass, JKeyframe>) end;

  JLayoutTransitionClass = interface(JObjectClass)
    ['{433C5359-0A96-4796-AD7B-8084EF7EF7C4}']
    {class} function _GetAPPEARING: Integer; cdecl;
    {class} function _GetCHANGE_APPEARING: Integer; cdecl;
    {class} function _GetCHANGE_DISAPPEARING: Integer; cdecl;
    {class} function _GetCHANGING: Integer; cdecl;
    {class} function _GetDISAPPEARING: Integer; cdecl;
    {class} function init: JLayoutTransition; cdecl;
    {class} property APPEARING: Integer read _GetAPPEARING;
    {class} property CHANGE_APPEARING: Integer read _GetCHANGE_APPEARING;
    {class} property CHANGE_DISAPPEARING: Integer read _GetCHANGE_DISAPPEARING;
    {class} property CHANGING: Integer read _GetCHANGING;
    {class} property DISAPPEARING: Integer read _GetDISAPPEARING;
  end;

  [JavaSignature('android/animation/LayoutTransition')]
  JLayoutTransition = interface(JObject)
    ['{42450BEE-EBF2-4954-B9B7-F8DAE7DF0EC1}']
    procedure addChild(parent: JViewGroup; child: JView); cdecl;
    procedure addTransitionListener(listener: JLayoutTransition_TransitionListener); cdecl;
    procedure disableTransitionType(transitionType: Integer); cdecl;
    procedure enableTransitionType(transitionType: Integer); cdecl;
    function getAnimator(transitionType: Integer): JAnimator; cdecl;
    function getDuration(transitionType: Integer): Int64; cdecl;
    function getInterpolator(transitionType: Integer): JTimeInterpolator; cdecl;
    function getStagger(transitionType: Integer): Int64; cdecl;
    function getStartDelay(transitionType: Integer): Int64; cdecl;
    function getTransitionListeners: JList; cdecl;
    procedure hideChild(parent: JViewGroup; child: JView); cdecl; overload;//Deprecated
    procedure hideChild(parent: JViewGroup; child: JView; newVisibility: Integer); cdecl; overload;
    function isChangingLayout: Boolean; cdecl;
    function isRunning: Boolean; cdecl;
    function isTransitionTypeEnabled(transitionType: Integer): Boolean; cdecl;
    procedure removeChild(parent: JViewGroup; child: JView); cdecl;
    procedure removeTransitionListener(listener: JLayoutTransition_TransitionListener); cdecl;
    procedure setAnimateParentHierarchy(animateParentHierarchy: Boolean); cdecl;
    procedure setAnimator(transitionType: Integer; animator: JAnimator); cdecl;
    procedure setDuration(transitionType: Integer; duration: Int64); cdecl; overload;
    procedure setDuration(duration: Int64); cdecl; overload;
    procedure setInterpolator(transitionType: Integer; interpolator: JTimeInterpolator); cdecl;
    procedure setStagger(transitionType: Integer; duration: Int64); cdecl;
    procedure setStartDelay(transitionType: Integer; delay: Int64); cdecl;
    procedure showChild(parent: JViewGroup; child: JView); cdecl; overload;//Deprecated
    procedure showChild(parent: JViewGroup; child: JView; oldVisibility: Integer); cdecl; overload;
  end;
  TJLayoutTransition = class(TJavaGenericImport<JLayoutTransitionClass, JLayoutTransition>) end;

  JLayoutTransition_TransitionListenerClass = interface(IJavaClass)
    ['{9FA6F1EC-8EDB-4A05-AF58-B55A525AE114}']
  end;

  [JavaSignature('android/animation/LayoutTransition$TransitionListener')]
  JLayoutTransition_TransitionListener = interface(IJavaInstance)
    ['{0FBE048F-FCDA-4692-B6F1-DE0F07FAE885}']
    procedure endTransition(transition: JLayoutTransition; container: JViewGroup; view: JView; transitionType: Integer); cdecl;
    procedure startTransition(transition: JLayoutTransition; container: JViewGroup; view: JView; transitionType: Integer); cdecl;
  end;
  TJLayoutTransition_TransitionListener = class(TJavaGenericImport<JLayoutTransition_TransitionListenerClass, JLayoutTransition_TransitionListener>) end;

  JPropertyValuesHolderClass = interface(JObjectClass)
    ['{36C77AFF-9C3F-42B6-88F3-320FE8CF9B25}']
    {class} function ofFloat(property_: JProperty; values: TJavaArray<Single>): JPropertyValuesHolder; cdecl; overload;
    {class} function ofFloat(propertyName: JString; values: TJavaArray<Single>): JPropertyValuesHolder; cdecl; overload;
    {class} function ofInt(property_: JProperty; values: TJavaArray<Integer>): JPropertyValuesHolder; cdecl; overload;
    {class} function ofInt(propertyName: JString; values: TJavaArray<Integer>): JPropertyValuesHolder; cdecl; overload;
    {class} function ofKeyframe(property_: JProperty; values: TJavaObjectArray<JKeyframe>): JPropertyValuesHolder; cdecl; overload;
    {class} function ofKeyframe(propertyName: JString; values: TJavaObjectArray<JKeyframe>): JPropertyValuesHolder; cdecl; overload;
    {class} function ofMultiFloat(propertyName: JString; converter: JTypeConverter; evaluator: JTypeEvaluator; values: TJavaObjectArray<JKeyframe>): JPropertyValuesHolder; cdecl; overload;
    {class} function ofMultiFloat(propertyName: JString; converter: JTypeConverter; evaluator: JTypeEvaluator; values: TJavaObjectArray<JObject>): JPropertyValuesHolder; cdecl; overload;
    {class} function ofMultiFloat(propertyName: JString; path: JPath): JPropertyValuesHolder; cdecl; overload;
    {class} function ofMultiFloat(propertyName: JString; values: TJavaBiArray<Single>): JPropertyValuesHolder; cdecl; overload;
    {class} function ofMultiInt(propertyName: JString; converter: JTypeConverter; evaluator: JTypeEvaluator; values: TJavaObjectArray<JKeyframe>): JPropertyValuesHolder; cdecl; overload;
    {class} function ofMultiInt(propertyName: JString; converter: JTypeConverter; evaluator: JTypeEvaluator; values: TJavaObjectArray<JObject>): JPropertyValuesHolder; cdecl; overload;
    {class} function ofMultiInt(propertyName: JString; path: JPath): JPropertyValuesHolder; cdecl; overload;
    {class} function ofMultiInt(propertyName: JString; values: TJavaBiArray<Integer>): JPropertyValuesHolder; cdecl; overload;
    {class} function ofObject(property_: JProperty; evaluator: JTypeEvaluator; values: TJavaObjectArray<JObject>): JPropertyValuesHolder; cdecl; overload;
    {class} function ofObject(property_: JProperty; converter: JTypeConverter; path: JPath): JPropertyValuesHolder; cdecl; overload;
    {class} function ofObject(property_: JProperty; converter: JTypeConverter; evaluator: JTypeEvaluator; values: TJavaObjectArray<JObject>): JPropertyValuesHolder; cdecl; overload;
    {class} function ofObject(propertyName: JString; converter: JTypeConverter; path: JPath): JPropertyValuesHolder; cdecl; overload;
    {class} function ofObject(propertyName: JString; evaluator: JTypeEvaluator; values: TJavaObjectArray<JObject>): JPropertyValuesHolder; cdecl; overload;
  end;

  [JavaSignature('android/animation/PropertyValuesHolder')]
  JPropertyValuesHolder = interface(JObject)
    ['{12B4ABFD-CBCA-4636-AF2D-C386EF895DC3}']
    function clone: JPropertyValuesHolder; cdecl;
    function getPropertyName: JString; cdecl;
    procedure setConverter(converter: JTypeConverter); cdecl;
    procedure setEvaluator(evaluator: JTypeEvaluator); cdecl;
    procedure setFloatValues(values: TJavaArray<Single>); cdecl;
    procedure setIntValues(values: TJavaArray<Integer>); cdecl;
    procedure setKeyframes(values: TJavaObjectArray<JKeyframe>); cdecl;
    procedure setObjectValues(values: TJavaObjectArray<JObject>); cdecl;
    procedure setProperty(property_: JProperty); cdecl;
    procedure setPropertyName(propertyName: JString); cdecl;
    function toString: JString; cdecl;
  end;
  TJPropertyValuesHolder = class(TJavaGenericImport<JPropertyValuesHolderClass, JPropertyValuesHolder>) end;

  JStateListAnimatorClass = interface(JObjectClass)
    ['{109E4067-E218-47B1-93EB-65B8916A98D8}']
    {class} function init: JStateListAnimator; cdecl;
  end;

  [JavaSignature('android/animation/StateListAnimator')]
  JStateListAnimator = interface(JObject)
    ['{CA2A9587-26AA-4DC2-8DFF-A1305A37608F}']
    procedure addState(specs: TJavaArray<Integer>; animator: JAnimator); cdecl;
    function clone: JStateListAnimator; cdecl;
    procedure jumpToCurrentState; cdecl;
  end;
  TJStateListAnimator = class(TJavaGenericImport<JStateListAnimatorClass, JStateListAnimator>) end;

  JTimeInterpolatorClass = interface(IJavaClass)
    ['{1E682A1C-9102-461D-A3CA-5596683F1D66}']
  end;

  [JavaSignature('android/animation/TimeInterpolator')]
  JTimeInterpolator = interface(IJavaInstance)
    ['{639F8A83-7D9B-49AF-A19E-96B27E46D2AB}']
    function getInterpolation(input: Single): Single; cdecl;
  end;
  TJTimeInterpolator = class(TJavaGenericImport<JTimeInterpolatorClass, JTimeInterpolator>) end;

  JTypeConverterClass = interface(JObjectClass)
    ['{BE2DD177-6D79-4B0C-B4F5-4E4CD9D7436D}']
    {class} function init(fromClass: Jlang_Class; toClass: Jlang_Class): JTypeConverter; cdecl;
  end;

  [JavaSignature('android/animation/TypeConverter')]
  JTypeConverter = interface(JObject)
    ['{BFEA4116-0766-4AD9-AA8F-4C15A583EB2E}']
    function convert(value: JObject): JObject; cdecl;
  end;
  TJTypeConverter = class(TJavaGenericImport<JTypeConverterClass, JTypeConverter>) end;

  JTypeEvaluatorClass = interface(IJavaClass)
    ['{15B67CAF-6F50-4AA3-A88F-C5AF78D62FD4}']
  end;

  [JavaSignature('android/animation/TypeEvaluator')]
  JTypeEvaluator = interface(IJavaInstance)
    ['{F436383D-6F44-40D8-ACDD-9057777691FC}']
    function evaluate(fraction: Single; startValue: JObject; endValue: JObject): JObject; cdecl;
  end;
  TJTypeEvaluator = class(TJavaGenericImport<JTypeEvaluatorClass, JTypeEvaluator>) end;

  JValueAnimatorClass = interface(JAnimatorClass)
    ['{FF3B71ED-5A33-45B0-8500-7672B0B98E2C}']
    {class} function _GetINFINITE: Integer; cdecl;
    {class} function _GetRESTART: Integer; cdecl;
    {class} function _GetREVERSE: Integer; cdecl;
    {class} function init: JValueAnimator; cdecl;
    {class} function areAnimatorsEnabled: Boolean; cdecl;
    {class} function getDurationScale: Single; cdecl;
    {class} function getFrameDelay: Int64; cdecl;
    {class} function ofArgb(values: TJavaArray<Integer>): JValueAnimator; cdecl;
    {class} function ofFloat(values: TJavaArray<Single>): JValueAnimator; cdecl;
    {class} function ofInt(values: TJavaArray<Integer>): JValueAnimator; cdecl;
    {class} function ofObject(evaluator: JTypeEvaluator; values: TJavaObjectArray<JObject>): JValueAnimator; cdecl;
    {class} function ofPropertyValuesHolder(values: TJavaObjectArray<JPropertyValuesHolder>): JValueAnimator; cdecl;
    {class} function registerDurationScaleChangeListener(listener: JValueAnimator_DurationScaleChangeListener): Boolean; cdecl;
    {class} procedure setFrameDelay(frameDelay: Int64); cdecl;
    {class} function unregisterDurationScaleChangeListener(listener: JValueAnimator_DurationScaleChangeListener): Boolean; cdecl;
    {class} property INFINITE: Integer read _GetINFINITE;
    {class} property RESTART: Integer read _GetRESTART;
    {class} property REVERSE: Integer read _GetREVERSE;
  end;

  [JavaSignature('android/animation/ValueAnimator')]
  JValueAnimator = interface(JAnimator)
    ['{70F92B14-EFD4-4DC7-91DE-6617417AE194}']
    procedure addUpdateListener(listener: JValueAnimator_AnimatorUpdateListener); cdecl;
    procedure cancel; cdecl;
    function clone: JValueAnimator; cdecl;
    procedure &end; cdecl;
    function getAnimatedFraction: Single; cdecl;
    function getAnimatedValue: JObject; cdecl; overload;
    function getAnimatedValue(propertyName: JString): JObject; cdecl; overload;
    function getCurrentPlayTime: Int64; cdecl;
    function getDuration: Int64; cdecl;
    function getInterpolator: JTimeInterpolator; cdecl;
    function getRepeatCount: Integer; cdecl;
    function getRepeatMode: Integer; cdecl;
    function getStartDelay: Int64; cdecl;
    function getTotalDuration: Int64; cdecl;
    function getValues: TJavaObjectArray<JPropertyValuesHolder>; cdecl;
    function isRunning: Boolean; cdecl;
    function isStarted: Boolean; cdecl;
    procedure pause; cdecl;
    procedure removeAllUpdateListeners; cdecl;
    procedure removeUpdateListener(listener: JValueAnimator_AnimatorUpdateListener); cdecl;
    procedure resume; cdecl;
    procedure reverse; cdecl;
    procedure setCurrentFraction(fraction: Single); cdecl;
    procedure setCurrentPlayTime(playTime: Int64); cdecl;
    function setDuration(duration: Int64): JValueAnimator; cdecl;
    procedure setEvaluator(value: JTypeEvaluator); cdecl;
    procedure setFloatValues(values: TJavaArray<Single>); cdecl;
    procedure setIntValues(values: TJavaArray<Integer>); cdecl;
    procedure setInterpolator(value: JTimeInterpolator); cdecl;
    procedure setObjectValues(values: TJavaObjectArray<JObject>); cdecl;
    procedure setRepeatCount(value: Integer); cdecl;
    procedure setRepeatMode(value: Integer); cdecl;
    procedure setStartDelay(startDelay: Int64); cdecl;
    procedure setValues(values: TJavaObjectArray<JPropertyValuesHolder>); cdecl;
    procedure start; cdecl;
    function toString: JString; cdecl;
  end;
  TJValueAnimator = class(TJavaGenericImport<JValueAnimatorClass, JValueAnimator>) end;

  JValueAnimator_AnimatorUpdateListenerClass = interface(IJavaClass)
    ['{9CA50CBF-4462-4445-82CD-13CE985E2DE4}']
  end;

  [JavaSignature('android/animation/ValueAnimator$AnimatorUpdateListener')]
  JValueAnimator_AnimatorUpdateListener = interface(IJavaInstance)
    ['{0F883491-52EF-4A40-B7D2-FC23E11E46FE}']
    procedure onAnimationUpdate(animation: JValueAnimator); cdecl;
  end;
  TJValueAnimator_AnimatorUpdateListener = class(TJavaGenericImport<JValueAnimator_AnimatorUpdateListenerClass, JValueAnimator_AnimatorUpdateListener>) end;

  JValueAnimator_DurationScaleChangeListenerClass = interface(IJavaClass)
    ['{D2EE6258-2FAB-4690-B129-41C9858944A5}']
  end;

  [JavaSignature('android/animation/ValueAnimator$DurationScaleChangeListener')]
  JValueAnimator_DurationScaleChangeListener = interface(IJavaInstance)
    ['{9234CE4E-FDC4-49B9-9B92-D95BBF89D216}']
    procedure onChanged(scale: Single); cdecl;
  end;
  TJValueAnimator_DurationScaleChangeListener = class(TJavaGenericImport<JValueAnimator_DurationScaleChangeListenerClass, JValueAnimator_DurationScaleChangeListener>) end;

  JGetCredentialRequestClass = interface(JObjectClass)
    ['{537E5E73-DB4B-4362-8879-34EDD17E3D70}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/credentials/GetCredentialRequest')]
  JGetCredentialRequest = interface(JObject)
    ['{BA4C1EFF-476E-4265-835E-1C72562C5211}']
    function alwaysSendAppInfoToProvider: Boolean; cdecl;
    function describeContents: Integer; cdecl;
    function getCredentialOptions: JList; cdecl;
    function getData: JBundle; cdecl;
    function getOrigin: JString; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJGetCredentialRequest = class(TJavaGenericImport<JGetCredentialRequestClass, JGetCredentialRequest>) end;

  JULocaleClass = interface(JObjectClass)
    ['{F1371E5B-1B55-4D2A-B747-0FCB0F988365}']
    {class} function _GetCANADA: JULocale; cdecl;
    {class} function _GetCANADA_FRENCH: JULocale; cdecl;
    {class} function _GetCHINA: JULocale; cdecl;
    {class} function _GetCHINESE: JULocale; cdecl;
    {class} function _GetENGLISH: JULocale; cdecl;
    {class} function _GetFRANCE: JULocale; cdecl;
    {class} function _GetFRENCH: JULocale; cdecl;
    {class} function _GetGERMAN: JULocale; cdecl;
    {class} function _GetGERMANY: JULocale; cdecl;
    {class} function _GetITALIAN: JULocale; cdecl;
    {class} function _GetITALY: JULocale; cdecl;
    {class} function _GetJAPAN: JULocale; cdecl;
    {class} function _GetJAPANESE: JULocale; cdecl;
    {class} function _GetKOREA: JULocale; cdecl;
    {class} function _GetKOREAN: JULocale; cdecl;
    {class} function _GetPRC: JULocale; cdecl;
    {class} function _GetPRIVATE_USE_EXTENSION: Char; cdecl;
    {class} function _GetROOT: JULocale; cdecl;
    {class} function _GetSIMPLIFIED_CHINESE: JULocale; cdecl;
    {class} function _GetTAIWAN: JULocale; cdecl;
    {class} function _GetTRADITIONAL_CHINESE: JULocale; cdecl;
    {class} function _GetUK: JULocale; cdecl;
    {class} function _GetUNICODE_LOCALE_EXTENSION: Char; cdecl;
    {class} function _GetUS: JULocale; cdecl;
    {class} function init(localeID: JString): JULocale; cdecl; overload;
    {class} function init(a: JString; b: JString): JULocale; cdecl; overload;
    {class} function init(a: JString; b: JString; c: JString): JULocale; cdecl; overload;
    {class} function acceptLanguage(acceptLanguageList: TJavaObjectArray<JULocale>; availableLocales: TJavaObjectArray<JULocale>; fallback: TJavaArray<Boolean>): JULocale; cdecl; overload;
    {class} function acceptLanguage(acceptLanguageList: TJavaObjectArray<JULocale>; fallback: TJavaArray<Boolean>): JULocale; cdecl; overload;
    {class} function acceptLanguage(acceptLanguageList: JString; availableLocales: TJavaObjectArray<JULocale>; fallback: TJavaArray<Boolean>): JULocale; cdecl; overload;
    {class} function acceptLanguage(acceptLanguageList: JString; fallback: TJavaArray<Boolean>): JULocale; cdecl; overload;
    {class} function addLikelySubtags(loc: JULocale): JULocale; cdecl;
    {class} function canonicalize(localeID: JString): JString; cdecl;
    {class} function createCanonical(locale: JULocale): JULocale; cdecl; overload;
    {class} function createCanonical(nonCanonicalID: JString): JULocale; cdecl; overload;
    {class} function forLanguageTag(languageTag: JString): JULocale; cdecl;
    {class} function forLocale(loc: JLocale): JULocale; cdecl;
    {class} function getAvailableLocales: TJavaObjectArray<JULocale>; cdecl;
    {class} function getAvailableLocalesByType(type_: JULocale_AvailableType): JCollection; cdecl;
    {class} function getBaseName(localeID: JString): JString; cdecl; overload;
    {class} function getCountry(localeID: JString): JString; cdecl; overload;
    {class} function getDefault: JULocale; cdecl; overload;
    {class} function getDefault(category: JULocale_Category): JULocale; cdecl; overload;
    {class} function getDisplayCountry(localeID: JString; displayLocale: JULocale): JString; cdecl; overload;
    {class} function getDisplayCountry(localeID: JString; displayLocaleID: JString): JString; cdecl; overload;
    {class} function getDisplayKeyword(keyword: JString): JString; cdecl; overload;
    {class} function getDisplayKeyword(keyword: JString; displayLocale: JULocale): JString; cdecl; overload;
    {class} function getDisplayKeyword(keyword: JString; displayLocaleID: JString): JString; cdecl; overload;
    {class} function getDisplayKeywordValue(localeID: JString; keyword: JString; displayLocale: JULocale): JString; cdecl; overload;
    {class} function getDisplayKeywordValue(localeID: JString; keyword: JString; displayLocaleID: JString): JString; cdecl; overload;
    {class} function getDisplayLanguage(localeID: JString; displayLocale: JULocale): JString; cdecl; overload;
    {class} function getDisplayLanguage(localeID: JString; displayLocaleID: JString): JString; cdecl; overload;
    {class} function getDisplayLanguageWithDialect(localeID: JString; displayLocale: JULocale): JString; cdecl; overload;
    {class} function getDisplayLanguageWithDialect(localeID: JString; displayLocaleID: JString): JString; cdecl; overload;
    {class} function getDisplayName(localeID: JString; displayLocale: JULocale): JString; cdecl; overload;
    {class} function getDisplayName(localeID: JString; displayLocaleID: JString): JString; cdecl; overload;
    {class} function getDisplayNameWithDialect(localeID: JString; displayLocale: JULocale): JString; cdecl; overload;
    {class} function getDisplayNameWithDialect(localeID: JString; displayLocaleID: JString): JString; cdecl; overload;
    {class} function getDisplayScript(localeID: JString; displayLocale: JULocale): JString; cdecl; overload;
    {class} function getDisplayScript(localeID: JString; displayLocaleID: JString): JString; cdecl; overload;
    {class} function getDisplayVariant(localeID: JString; displayLocale: JULocale): JString; cdecl; overload;
    {class} function getDisplayVariant(localeID: JString; displayLocaleID: JString): JString; cdecl; overload;
    {class} function getFallback(localeID: JString): JString; cdecl; overload;
    {class} function getISO3Country(localeID: JString): JString; cdecl; overload;
    {class} function getISO3Language(localeID: JString): JString; cdecl; overload;
    {class} function getISOCountries: TJavaObjectArray<JString>; cdecl;
    {class} function getISOLanguages: TJavaObjectArray<JString>; cdecl;
    {class} function getKeywordValue(localeID: JString; keywordName: JString): JString; cdecl; overload;
    {class} function getKeywords(localeID: JString): JIterator; cdecl; overload;
    {class} function getLanguage(localeID: JString): JString; cdecl; overload;
    {class} function getName(localeID: JString): JString; cdecl; overload;
    {class} function getScript(localeID: JString): JString; cdecl; overload;
    {class} function getVariant(localeID: JString): JString; cdecl; overload;
    {class} function minimizeSubtags(loc: JULocale): JULocale; cdecl;
    {class} function setKeywordValue(localeID: JString; keyword: JString; value: JString): JString; cdecl; overload;
    {class} function toLegacyKey(keyword: JString): JString; cdecl;
    {class} function toLegacyType(keyword: JString; value: JString): JString; cdecl;
    {class} function toUnicodeLocaleKey(keyword: JString): JString; cdecl;
    {class} function toUnicodeLocaleType(keyword: JString; value: JString): JString; cdecl;
    {class} property CANADA: JULocale read _GetCANADA;
    {class} property CANADA_FRENCH: JULocale read _GetCANADA_FRENCH;
    {class} property CHINA: JULocale read _GetCHINA;
    {class} property CHINESE: JULocale read _GetCHINESE;
    {class} property ENGLISH: JULocale read _GetENGLISH;
    {class} property FRANCE: JULocale read _GetFRANCE;
    {class} property FRENCH: JULocale read _GetFRENCH;
    {class} property GERMAN: JULocale read _GetGERMAN;
    {class} property GERMANY: JULocale read _GetGERMANY;
    {class} property ITALIAN: JULocale read _GetITALIAN;
    {class} property ITALY: JULocale read _GetITALY;
    {class} property JAPAN: JULocale read _GetJAPAN;
    {class} property JAPANESE: JULocale read _GetJAPANESE;
    {class} property KOREA: JULocale read _GetKOREA;
    {class} property KOREAN: JULocale read _GetKOREAN;
    {class} property PRC: JULocale read _GetPRC;
    {class} property PRIVATE_USE_EXTENSION: Char read _GetPRIVATE_USE_EXTENSION;
    {class} property ROOT: JULocale read _GetROOT;
    {class} property SIMPLIFIED_CHINESE: JULocale read _GetSIMPLIFIED_CHINESE;
    {class} property TAIWAN: JULocale read _GetTAIWAN;
    {class} property TRADITIONAL_CHINESE: JULocale read _GetTRADITIONAL_CHINESE;
    {class} property UK: JULocale read _GetUK;
    {class} property UNICODE_LOCALE_EXTENSION: Char read _GetUNICODE_LOCALE_EXTENSION;
    {class} property US: JULocale read _GetUS;
  end;

  [JavaSignature('android/icu/util/ULocale')]
  JULocale = interface(JObject)
    ['{2D2A3A39-79FB-4393-A3C4-06738C0DB270}']
    function clone: JObject; cdecl;
    function compareTo(other: JULocale): Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function getBaseName: JString; cdecl; overload;
    function getCharacterOrientation: JString; cdecl;
    function getCountry: JString; cdecl; overload;
    function getDisplayCountry: JString; cdecl; overload;
    function getDisplayCountry(displayLocale: JULocale): JString; cdecl; overload;
    function getDisplayKeywordValue(keyword: JString): JString; cdecl; overload;
    function getDisplayKeywordValue(keyword: JString; displayLocale: JULocale): JString; cdecl; overload;
    function getDisplayLanguage: JString; cdecl; overload;
    function getDisplayLanguage(displayLocale: JULocale): JString; cdecl; overload;
    function getDisplayLanguageWithDialect: JString; cdecl; overload;
    function getDisplayLanguageWithDialect(displayLocale: JULocale): JString; cdecl; overload;
    function getDisplayName: JString; cdecl; overload;
    function getDisplayName(displayLocale: JULocale): JString; cdecl; overload;
    function getDisplayNameWithDialect: JString; cdecl; overload;
    function getDisplayNameWithDialect(displayLocale: JULocale): JString; cdecl; overload;
    function getDisplayScript: JString; cdecl; overload;
    function getDisplayScript(displayLocale: JULocale): JString; cdecl; overload;
    function getDisplayVariant: JString; cdecl; overload;
    function getDisplayVariant(displayLocale: JULocale): JString; cdecl; overload;
    function getExtension(key: Char): JString; cdecl;
    function getExtensionKeys: JSet; cdecl;
    function getFallback: JULocale; cdecl; overload;
    function getISO3Country: JString; cdecl; overload;
    function getISO3Language: JString; cdecl; overload;
    function getKeywordValue(keywordName: JString): JString; cdecl; overload;
    function getKeywords: JIterator; cdecl; overload;
    function getLanguage: JString; cdecl; overload;
    function getLineOrientation: JString; cdecl;
    function getName: JString; cdecl; overload;
    function getScript: JString; cdecl; overload;
    function getUnicodeLocaleAttributes: JSet; cdecl;
    function getUnicodeLocaleKeys: JSet; cdecl;
    function getUnicodeLocaleType(key: JString): JString; cdecl;
    function getVariant: JString; cdecl; overload;
    function hashCode: Integer; cdecl;
    function isRightToLeft: Boolean; cdecl;
    function setKeywordValue(keyword: JString; value: JString): JULocale; cdecl; overload;
    function toLanguageTag: JString; cdecl;
    function toLocale: JLocale; cdecl;
    function toString: JString; cdecl;
  end;
  TJULocale = class(TJavaGenericImport<JULocaleClass, JULocale>) end;

  JULocale_AvailableTypeClass = interface(JEnumClass)
    ['{E0DA8714-EF50-4E2A-9B18-466AA5A44A38}']
    {class} function _GetDEFAULT: JULocale_AvailableType; cdecl;
    {class} function _GetONLY_LEGACY_ALIASES: JULocale_AvailableType; cdecl;
    {class} function _GetWITH_LEGACY_ALIASES: JULocale_AvailableType; cdecl;
    {class} function valueOf(name: JString): JULocale_AvailableType; cdecl;
    {class} function values: TJavaObjectArray<JULocale_AvailableType>; cdecl;
    {class} property DEFAULT: JULocale_AvailableType read _GetDEFAULT;
    {class} property ONLY_LEGACY_ALIASES: JULocale_AvailableType read _GetONLY_LEGACY_ALIASES;
    {class} property WITH_LEGACY_ALIASES: JULocale_AvailableType read _GetWITH_LEGACY_ALIASES;
  end;

  [JavaSignature('android/icu/util/ULocale$AvailableType')]
  JULocale_AvailableType = interface(JEnum)
    ['{D4A72408-BDF1-4B18-8B73-02818F42B883}']
  end;
  TJULocale_AvailableType = class(TJavaGenericImport<JULocale_AvailableTypeClass, JULocale_AvailableType>) end;

  JULocale_CategoryClass = interface(JEnumClass)
    ['{2A1B1561-F979-4CC0-B181-70EAF90E0C42}']
    {class} function _GetDISPLAY: JULocale_Category; cdecl;
    {class} function _GetFORMAT: JULocale_Category; cdecl;
    {class} function valueOf(name: JString): JULocale_Category; cdecl;
    {class} function values: TJavaObjectArray<JULocale_Category>; cdecl;
    {class} property DISPLAY: JULocale_Category read _GetDISPLAY;
    {class} property FORMAT: JULocale_Category read _GetFORMAT;
  end;

  [JavaSignature('android/icu/util/ULocale$Category')]
  JULocale_Category = interface(JEnum)
    ['{DF754990-B298-414D-A2B8-31A80E41E5D1}']
  end;
  TJULocale_Category = class(TJavaGenericImport<JULocale_CategoryClass, JULocale_Category>) end;

  JPathMotionClass = interface(JObjectClass)
    ['{E1CD1A94-115C-492C-A490-37F0E72956EB}']
    {class} function init: JPathMotion; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JPathMotion; cdecl; overload;
  end;

  [JavaSignature('android/transition/PathMotion')]
  JPathMotion = interface(JObject)
    ['{BDC08353-C9FB-42D7-97CC-C35837D2F536}']
    function getPath(startX: Single; startY: Single; endX: Single; endY: Single): JPath; cdecl;
  end;
  TJPathMotion = class(TJavaGenericImport<JPathMotionClass, JPathMotion>) end;

  JSceneClass = interface(JObjectClass)
    ['{8B9120CA-AEEA-4DE3-BDC9-15CFD23A7B07}']
    {class} function init(sceneRoot: JViewGroup): JScene; cdecl; overload;
    {class} function init(sceneRoot: JViewGroup; layout: JView): JScene; cdecl; overload;
    {class} function init(sceneRoot: JViewGroup; layout: JViewGroup): JScene; cdecl; overload;//Deprecated
    {class} function getCurrentScene(sceneRoot: JViewGroup): JScene; cdecl;
    {class} function getSceneForLayout(sceneRoot: JViewGroup; layoutId: Integer; context: JContext): JScene; cdecl;
  end;

  [JavaSignature('android/transition/Scene')]
  JScene = interface(JObject)
    ['{85A60B99-5837-4F1F-A344-C627DD586B82}']
    procedure enter; cdecl;
    procedure exit; cdecl;
    function getSceneRoot: JViewGroup; cdecl;
    procedure setEnterAction(action: JRunnable); cdecl;
    procedure setExitAction(action: JRunnable); cdecl;
  end;
  TJScene = class(TJavaGenericImport<JSceneClass, JScene>) end;

  JTransitionClass = interface(JObjectClass)
    ['{60EC06BC-8F7A-4416-A04B-5B57987EB18E}']
    {class} function _GetMATCH_ID: Integer; cdecl;
    {class} function _GetMATCH_INSTANCE: Integer; cdecl;
    {class} function _GetMATCH_ITEM_ID: Integer; cdecl;
    {class} function _GetMATCH_NAME: Integer; cdecl;
    {class} function init: JTransition; cdecl; overload;
    {class} function init(context: JContext; attrs: JAttributeSet): JTransition; cdecl; overload;
    {class} property MATCH_ID: Integer read _GetMATCH_ID;
    {class} property MATCH_INSTANCE: Integer read _GetMATCH_INSTANCE;
    {class} property MATCH_ITEM_ID: Integer read _GetMATCH_ITEM_ID;
    {class} property MATCH_NAME: Integer read _GetMATCH_NAME;
  end;

  [JavaSignature('android/transition/Transition')]
  JTransition = interface(JObject)
    ['{C2F8200F-1C83-40AE-8C5B-C0C8BFF17F88}']
    function addListener(listener: JTransition_TransitionListener): JTransition; cdecl;
    function addTarget(target: JView): JTransition; cdecl; overload;
    function addTarget(targetId: Integer): JTransition; cdecl; overload;
    function addTarget(targetType: Jlang_Class): JTransition; cdecl; overload;
    function addTarget(targetName: JString): JTransition; cdecl; overload;
    function canRemoveViews: Boolean; cdecl;
    procedure captureEndValues(transitionValues: JTransitionValues); cdecl;
    procedure captureStartValues(transitionValues: JTransitionValues); cdecl;
    function clone: JTransition; cdecl;
    function createAnimator(sceneRoot: JViewGroup; startValues: JTransitionValues; endValues: JTransitionValues): JAnimator; cdecl;
    function excludeChildren(target: JView; exclude: Boolean): JTransition; cdecl; overload;
    function excludeChildren(targetId: Integer; exclude: Boolean): JTransition; cdecl; overload;
    function excludeChildren(type_: Jlang_Class; exclude: Boolean): JTransition; cdecl; overload;
    function excludeTarget(target: JView; exclude: Boolean): JTransition; cdecl; overload;
    function excludeTarget(targetId: Integer; exclude: Boolean): JTransition; cdecl; overload;
    function excludeTarget(type_: Jlang_Class; exclude: Boolean): JTransition; cdecl; overload;
    function excludeTarget(targetName: JString; exclude: Boolean): JTransition; cdecl; overload;
    function getDuration: Int64; cdecl;
    function getEpicenter: JRect; cdecl;
    function getEpicenterCallback: JTransition_EpicenterCallback; cdecl;
    function getInterpolator: JTimeInterpolator; cdecl;
    function getName: JString; cdecl;
    function getPathMotion: JPathMotion; cdecl;
    function getPropagation: JTransitionPropagation; cdecl;
    function getStartDelay: Int64; cdecl;
    function getTargetIds: JList; cdecl;
    function getTargetNames: JList; cdecl;
    function getTargetTypes: JList; cdecl;
    function getTargets: JList; cdecl;
    function getTransitionProperties: TJavaObjectArray<JString>; cdecl;
    function getTransitionValues(view: JView; start: Boolean): JTransitionValues; cdecl;
    function isTransitionRequired(startValues: JTransitionValues; endValues: JTransitionValues): Boolean; cdecl;
    function removeListener(listener: JTransition_TransitionListener): JTransition; cdecl;
    function removeTarget(target: JView): JTransition; cdecl; overload;
    function removeTarget(targetId: Integer): JTransition; cdecl; overload;
    function removeTarget(target: Jlang_Class): JTransition; cdecl; overload;
    function removeTarget(targetName: JString): JTransition; cdecl; overload;
    function setDuration(duration: Int64): JTransition; cdecl;
    procedure setEpicenterCallback(epicenterCallback: JTransition_EpicenterCallback); cdecl;
    function setInterpolator(interpolator: JTimeInterpolator): JTransition; cdecl;
    procedure setMatchOrder(matches: TJavaArray<Integer>); cdecl;
    procedure setPathMotion(pathMotion: JPathMotion); cdecl;
    procedure setPropagation(transitionPropagation: JTransitionPropagation); cdecl;
    function setStartDelay(startDelay: Int64): JTransition; cdecl;
    function toString: JString; cdecl;
  end;
  TJTransition = class(TJavaGenericImport<JTransitionClass, JTransition>) end;

  JTransition_EpicenterCallbackClass = interface(JObjectClass)
    ['{8141257A-130B-466C-A08D-AA3A00946F4C}']
    {class} function init: JTransition_EpicenterCallback; cdecl;
  end;

  [JavaSignature('android/transition/Transition$EpicenterCallback')]
  JTransition_EpicenterCallback = interface(JObject)
    ['{CE004917-266F-4076-8913-F23184824FBA}']
    function onGetEpicenter(transition: JTransition): JRect; cdecl;
  end;
  TJTransition_EpicenterCallback = class(TJavaGenericImport<JTransition_EpicenterCallbackClass, JTransition_EpicenterCallback>) end;

  JTransition_TransitionListenerClass = interface(IJavaClass)
    ['{D5083752-E8A6-46DF-BE40-AE11073C387E}']
  end;

  [JavaSignature('android/transition/Transition$TransitionListener')]
  JTransition_TransitionListener = interface(IJavaInstance)
    ['{C32BE107-6E05-4898-AF0A-FAD970D66E29}']
    procedure onTransitionCancel(transition: JTransition); cdecl;
    procedure onTransitionEnd(transition: JTransition); cdecl;
    procedure onTransitionPause(transition: JTransition); cdecl;
    procedure onTransitionResume(transition: JTransition); cdecl;
    procedure onTransitionStart(transition: JTransition); cdecl;
  end;
  TJTransition_TransitionListener = class(TJavaGenericImport<JTransition_TransitionListenerClass, JTransition_TransitionListener>) end;

  JTransitionManagerClass = interface(JObjectClass)
    ['{4160EFA0-3499-4964-817E-46497BB5B957}']
    {class} function init: JTransitionManager; cdecl;
    {class} procedure beginDelayedTransition(sceneRoot: JViewGroup); cdecl; overload;
    {class} procedure beginDelayedTransition(sceneRoot: JViewGroup; transition: JTransition); cdecl; overload;
    {class} procedure endTransitions(sceneRoot: JViewGroup); cdecl;
    {class} procedure go(scene: JScene); cdecl; overload;
    {class} procedure go(scene: JScene; transition: JTransition); cdecl; overload;
  end;

  [JavaSignature('android/transition/TransitionManager')]
  JTransitionManager = interface(JObject)
    ['{FF5E1210-1F04-4F81-9CAC-3D7A5C4E972B}']
    procedure setTransition(fromScene: JScene; toScene: JScene; transition: JTransition); cdecl; overload;
    procedure setTransition(scene: JScene; transition: JTransition); cdecl; overload;
    procedure transitionTo(scene: JScene); cdecl;
  end;
  TJTransitionManager = class(TJavaGenericImport<JTransitionManagerClass, JTransitionManager>) end;

  JTransitionPropagationClass = interface(JObjectClass)
    ['{A881388A-C877-4DD9-9BAD-1BA4F56133EE}']
    {class} function init: JTransitionPropagation; cdecl;
  end;

  [JavaSignature('android/transition/TransitionPropagation')]
  JTransitionPropagation = interface(JObject)
    ['{7595B7EF-6BCE-4281-BC67-335E2FB6C091}']
    procedure captureValues(transitionValues: JTransitionValues); cdecl;
    function getPropagationProperties: TJavaObjectArray<JString>; cdecl;
    function getStartDelay(sceneRoot: JViewGroup; transition: JTransition; startValues: JTransitionValues; endValues: JTransitionValues): Int64; cdecl;
  end;
  TJTransitionPropagation = class(TJavaGenericImport<JTransitionPropagationClass, JTransitionPropagation>) end;

  JTransitionValuesClass = interface(JObjectClass)
    ['{3BF98CFA-6A4D-4815-8D42-15E97C916D91}']
    {class} function init: JTransitionValues; cdecl; overload;//Deprecated
    {class} function init(view: JView): JTransitionValues; cdecl; overload;
  end;

  [JavaSignature('android/transition/TransitionValues')]
  JTransitionValues = interface(JObject)
    ['{178E09E6-D32C-48A9-ADCF-8CCEA804052A}']
    function _Getvalues: JMap; cdecl;
    function _Getview: JView; cdecl;
    procedure _Setview(Value: JView); cdecl;
    function equals(other: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    property values: JMap read _Getvalues;
    property view: JView read _Getview write _Setview;
  end;
  TJTransitionValues = class(TJavaGenericImport<JTransitionValuesClass, JTransitionValues>) end;

  JInterpolatorClass = interface(JTimeInterpolatorClass)
    ['{A575B46A-E489-409C-807A-1B8F2BE092E8}']
  end;

  [JavaSignature('android/view/animation/Interpolator')]
  JInterpolator = interface(JTimeInterpolator)
    ['{F1082403-52DA-4AF0-B017-DAB334325FC7}']
  end;
  TJInterpolator = class(TJavaGenericImport<JInterpolatorClass, JInterpolator>) end;

  JToolbar_LayoutParamsClass = interface(JActionBar_LayoutParamsClass)
    ['{6D43796C-C163-4084-BB30-6FE68AFD7ABB}']
    {class} function init(source: JActionBar_LayoutParams): JToolbar_LayoutParams; cdecl; overload;
    {class} function init(c: JContext; attrs: JAttributeSet): JToolbar_LayoutParams; cdecl; overload;
    {class} function init(source: JViewGroup_LayoutParams): JToolbar_LayoutParams; cdecl; overload;
    {class} function init(source: JViewGroup_MarginLayoutParams): JToolbar_LayoutParams; cdecl; overload;
    {class} function init(source: JToolbar_LayoutParams): JToolbar_LayoutParams; cdecl; overload;
    {class} function init(gravity: Integer): JToolbar_LayoutParams; cdecl; overload;
    {class} function init(width: Integer; height: Integer): JToolbar_LayoutParams; cdecl; overload;
    {class} function init(width: Integer; height: Integer; gravity: Integer): JToolbar_LayoutParams; cdecl; overload;
  end;

  [JavaSignature('android/widget/Toolbar$LayoutParams')]
  JToolbar_LayoutParams = interface(JActionBar_LayoutParams)
    ['{BCD101F9-B7B7-4B2F-9460-056B3EA7B9F0}']
  end;
  TJToolbar_LayoutParams = class(TJavaGenericImport<JToolbar_LayoutParamsClass, JToolbar_LayoutParams>) end;

  JInputTransferTokenClass = interface(JObjectClass)
    ['{D587D7B8-DBE6-49E0-8938-B279F9E4B7DA}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/window/InputTransferToken')]
  JInputTransferToken = interface(JObject)
    ['{ABB24316-B8EA-42DE-AB3D-CA15ADAD0C91}']
    function describeContents: Integer; cdecl;
    function equals(obj: JObject): Boolean; cdecl;
    function hashCode: Integer; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJInputTransferToken = class(TJavaGenericImport<JInputTransferTokenClass, JInputTransferToken>) end;

  JOnBackInvokedCallbackClass = interface(IJavaClass)
    ['{06A86534-5B76-4BA0-AF7D-9A7A1D1D80E3}']
  end;

  [JavaSignature('android/window/OnBackInvokedCallback')]
  JOnBackInvokedCallback = interface(IJavaInstance)
    ['{601337A5-A018-420E-B6DA-806DED598BBD}']
    procedure onBackInvoked; cdecl;
  end;
  TJOnBackInvokedCallback = class(TJavaGenericImport<JOnBackInvokedCallbackClass, JOnBackInvokedCallback>) end;

  JOnBackInvokedDispatcherClass = interface(IJavaClass)
    ['{A5E30CAE-8E19-4B4A-8139-44BCD67DB362}']
    {class} function _GetPRIORITY_DEFAULT: Integer; cdecl;
    {class} function _GetPRIORITY_OVERLAY: Integer; cdecl;
    {class} function _GetPRIORITY_SYSTEM_NAVIGATION_OBSERVER: Integer; cdecl;
    {class} property PRIORITY_DEFAULT: Integer read _GetPRIORITY_DEFAULT;
    {class} property PRIORITY_OVERLAY: Integer read _GetPRIORITY_OVERLAY;
    {class} property PRIORITY_SYSTEM_NAVIGATION_OBSERVER: Integer read _GetPRIORITY_SYSTEM_NAVIGATION_OBSERVER;
  end;

  [JavaSignature('android/window/OnBackInvokedDispatcher')]
  JOnBackInvokedDispatcher = interface(IJavaInstance)
    ['{589E3D12-EAD4-49EE-954F-D8D6AF0F0A8C}']
    procedure registerOnBackInvokedCallback(priority: Integer; callback: JOnBackInvokedCallback); cdecl;
    procedure unregisterOnBackInvokedCallback(callback: JOnBackInvokedCallback); cdecl;
  end;
  TJOnBackInvokedDispatcher = class(TJavaGenericImport<JOnBackInvokedDispatcherClass, JOnBackInvokedDispatcher>) end;

  JSplashScreenClass = interface(IJavaClass)
    ['{8C9D6D91-D66C-430C-B055-C3D75FBF905F}']
    {class} function _GetSPLASH_SCREEN_STYLE_ICON: Integer; cdecl;
    {class} function _GetSPLASH_SCREEN_STYLE_SOLID_COLOR: Integer; cdecl;
    {class} property SPLASH_SCREEN_STYLE_ICON: Integer read _GetSPLASH_SCREEN_STYLE_ICON;
    {class} property SPLASH_SCREEN_STYLE_SOLID_COLOR: Integer read _GetSPLASH_SCREEN_STYLE_SOLID_COLOR;
  end;

  [JavaSignature('android/window/SplashScreen')]
  JSplashScreen = interface(IJavaInstance)
    ['{FCA1EDD1-2C28-40DD-9B87-16A6C816651A}']
    procedure clearOnExitAnimationListener; cdecl;
    procedure setOnExitAnimationListener(listener: JSplashScreen_OnExitAnimationListener); cdecl;
    procedure setSplashScreenTheme(themeId: Integer); cdecl;
  end;
  TJSplashScreen = class(TJavaGenericImport<JSplashScreenClass, JSplashScreen>) end;

  JSplashScreen_OnExitAnimationListenerClass = interface(IJavaClass)
    ['{E961868A-39A5-47C5-838B-2AA522633BBD}']
  end;

  [JavaSignature('android/window/SplashScreen$OnExitAnimationListener')]
  JSplashScreen_OnExitAnimationListener = interface(IJavaInstance)
    ['{24FE610B-30ED-4D43-BBDE-8EF7D1892D18}']
    procedure onSplashScreenExit(view: JSplashScreenView); cdecl;
  end;
  TJSplashScreen_OnExitAnimationListener = class(TJavaGenericImport<JSplashScreen_OnExitAnimationListenerClass, JSplashScreen_OnExitAnimationListener>) end;

  JSplashScreenViewClass = interface(JFrameLayoutClass)
    ['{9E219127-B957-42D6-99C6-1D9220C2BAB5}']
  end;

  [JavaSignature('android/window/SplashScreenView')]
  JSplashScreenView = interface(JFrameLayout)
    ['{6200474E-7BA0-4AE0-A6F2-80E4B410057D}']
    function getIconAnimationDuration: Jtime_Duration; cdecl;
    function getIconAnimationStart: JInstant; cdecl;
    function getIconView: JView; cdecl;
    procedure remove; cdecl;
    procedure setAlpha(alpha: Single); cdecl;
  end;
  TJSplashScreenView = class(TJavaGenericImport<JSplashScreenViewClass, JSplashScreenView>) end;

  JTrustedPresentationThresholdsClass = interface(JObjectClass)
    ['{6D0EB118-53F1-4417-9827-DCE0D45EDEC1}']
    {class} function _GetCREATOR: JParcelable_Creator; cdecl;
    {class} function init(minAlpha: Single; minFractionRendered: Single; stabilityRequirementMs: Integer): JTrustedPresentationThresholds; cdecl;
    {class} property CREATOR: JParcelable_Creator read _GetCREATOR;
  end;

  [JavaSignature('android/window/TrustedPresentationThresholds')]
  JTrustedPresentationThresholds = interface(JObject)
    ['{4964863A-6900-480B-BC1A-10B89CFCD0C6}']
    function describeContents: Integer; cdecl;
    function equals(o: JObject): Boolean; cdecl;
    function getMinAlpha: Single; cdecl;
    function getMinFractionRendered: Single; cdecl;
    function getStabilityRequirementMillis: Integer; cdecl;
    function hashCode: Integer; cdecl;
    function toString: JString; cdecl;
    procedure writeToParcel(dest: JParcel; flags: Integer); cdecl;
  end;
  TJTrustedPresentationThresholds = class(TJavaGenericImport<JTrustedPresentationThresholdsClass, JTrustedPresentationThresholds>) end;

  JMyLibMainActivityUtilClass = interface(JObjectClass)
    ['{A9ED2C5B-7FBB-414D-B093-DEB53AA601C1}']
    {class} function init: JMyLibMainActivityUtil; cdecl;
    {class} procedure create(activity: JActivity); cdecl;
    {class} procedure destroy(activity: JActivity); cdecl;
    {class} function isRunning: Boolean; cdecl;
    {class} procedure pause(activity: JActivity); cdecl;
    {class} procedure resume(activity: JActivity); cdecl;
  end;

  [JavaSignature('com/gyabinet/filament/mylibrary/MyLibMainActivityUtil')]
  JMyLibMainActivityUtil = interface(JObject)
    ['{0EB4F38B-131A-4922-AFC3-429F091DB934}']
  end;
  TJMyLibMainActivityUtil = class(TJavaGenericImport<JMyLibMainActivityUtilClass, JMyLibMainActivityUtil>) end;

  JUserPrincipalClass = interface(JPrincipalClass)
    ['{3A4E30AC-C080-4CEF-B16D-3BE169A79AFB}']
  end;

  [JavaSignature('java/nio/file/attribute/UserPrincipal')]
  JUserPrincipal = interface(JPrincipal)
    ['{368C434A-5D06-4C69-ACE9-FB952E4E8342}']
  end;
  TJUserPrincipal = class(TJavaGenericImport<JUserPrincipalClass, JUserPrincipal>) end;

  JGroupPrincipalClass = interface(JUserPrincipalClass)
    ['{AC00DB7A-54C1-48FE-97E9-FE412B618429}']
  end;

  [JavaSignature('java/nio/file/attribute/GroupPrincipal')]
  JGroupPrincipal = interface(JUserPrincipal)
    ['{5C76B8C3-59FE-425B-BF46-EF14A838DE08}']
  end;
  TJGroupPrincipal = class(TJavaGenericImport<JGroupPrincipalClass, JGroupPrincipal>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JAnimator', TypeInfo(AAW.JNI.mylibrary.JAnimator));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JAnimator_AnimatorListener', TypeInfo(AAW.JNI.mylibrary.JAnimator_AnimatorListener));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JAnimator_AnimatorPauseListener', TypeInfo(AAW.JNI.mylibrary.JAnimator_AnimatorPauseListener));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JKeyframe', TypeInfo(AAW.JNI.mylibrary.JKeyframe));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JLayoutTransition', TypeInfo(AAW.JNI.mylibrary.JLayoutTransition));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JLayoutTransition_TransitionListener', TypeInfo(AAW.JNI.mylibrary.JLayoutTransition_TransitionListener));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JPropertyValuesHolder', TypeInfo(AAW.JNI.mylibrary.JPropertyValuesHolder));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JStateListAnimator', TypeInfo(AAW.JNI.mylibrary.JStateListAnimator));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JTimeInterpolator', TypeInfo(AAW.JNI.mylibrary.JTimeInterpolator));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JTypeConverter', TypeInfo(AAW.JNI.mylibrary.JTypeConverter));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JTypeEvaluator', TypeInfo(AAW.JNI.mylibrary.JTypeEvaluator));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JValueAnimator', TypeInfo(AAW.JNI.mylibrary.JValueAnimator));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JValueAnimator_AnimatorUpdateListener', TypeInfo(AAW.JNI.mylibrary.JValueAnimator_AnimatorUpdateListener));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JValueAnimator_DurationScaleChangeListener', TypeInfo(AAW.JNI.mylibrary.JValueAnimator_DurationScaleChangeListener));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JGetCredentialRequest', TypeInfo(AAW.JNI.mylibrary.JGetCredentialRequest));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JULocale', TypeInfo(AAW.JNI.mylibrary.JULocale));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JULocale_AvailableType', TypeInfo(AAW.JNI.mylibrary.JULocale_AvailableType));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JULocale_Category', TypeInfo(AAW.JNI.mylibrary.JULocale_Category));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JPathMotion', TypeInfo(AAW.JNI.mylibrary.JPathMotion));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JScene', TypeInfo(AAW.JNI.mylibrary.JScene));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JTransition', TypeInfo(AAW.JNI.mylibrary.JTransition));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JTransition_EpicenterCallback', TypeInfo(AAW.JNI.mylibrary.JTransition_EpicenterCallback));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JTransition_TransitionListener', TypeInfo(AAW.JNI.mylibrary.JTransition_TransitionListener));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JTransitionManager', TypeInfo(AAW.JNI.mylibrary.JTransitionManager));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JTransitionPropagation', TypeInfo(AAW.JNI.mylibrary.JTransitionPropagation));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JTransitionValues', TypeInfo(AAW.JNI.mylibrary.JTransitionValues));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JInterpolator', TypeInfo(AAW.JNI.mylibrary.JInterpolator));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JToolbar_LayoutParams', TypeInfo(AAW.JNI.mylibrary.JToolbar_LayoutParams));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JInputTransferToken', TypeInfo(AAW.JNI.mylibrary.JInputTransferToken));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JOnBackInvokedCallback', TypeInfo(AAW.JNI.mylibrary.JOnBackInvokedCallback));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JOnBackInvokedDispatcher', TypeInfo(AAW.JNI.mylibrary.JOnBackInvokedDispatcher));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JSplashScreen', TypeInfo(AAW.JNI.mylibrary.JSplashScreen));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JSplashScreen_OnExitAnimationListener', TypeInfo(AAW.JNI.mylibrary.JSplashScreen_OnExitAnimationListener));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JSplashScreenView', TypeInfo(AAW.JNI.mylibrary.JSplashScreenView));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JTrustedPresentationThresholds', TypeInfo(AAW.JNI.mylibrary.JTrustedPresentationThresholds));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JMyLibMainActivityUtil', TypeInfo(AAW.JNI.mylibrary.JMyLibMainActivityUtil));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JUserPrincipal', TypeInfo(AAW.JNI.mylibrary.JUserPrincipal));
  TRegTypes.RegisterType('AAW.JNI.mylibrary.JGroupPrincipal', TypeInfo(AAW.JNI.mylibrary.JGroupPrincipal));
end;

initialization
  RegisterTypes;
end.

