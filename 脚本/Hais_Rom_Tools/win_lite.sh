#!/bin/bash

DELETE_SYSTEM="/system/app/AiAsstVision
/system/app/AnalyticsCore
/system/app/BasicDreams
/system/app/BookmarkProvider
/system/app/BTProductionLineTool
/system/app/BuiltInPrintService
/system/app/WallpaperBackup
/system/app/BluetoothMidiService
/system/app/goodix_sz
/system/app/GooglePrintRecommendationService
/system/app/MiLinkService2
/system/app/Joyose
/system/app/CarrierDefaultApp
/system/app/CatchLog
/system/app/Cit
/system/app/CtsShimPrebuilt
/system/app/FidoAuthen
/system/app/FM
/system/app/FrequentPhrase
/system/app/HTMLViewer
/system/app/HybridAccessory
/system/app/HybridPlatform
/system/app/KeyChain
/system/app/KSICibaEngine
/system/app/mab
/system/app/MetokNLP
/system/app/mi_connect_service
/system/app/Mipay
/system/app/MiPlayClient
/system/app/MiRadio
/system/app/MiuiAudioMonitor
/system/app/MiuiBluetooth
/system/app/MiuiBugReport
/system/app/MiuiDaemon
/system/app/MiuiSuperMarket
/system/app/MSA
/system/app/NextPay
/system/app/PacProcessor
/system/app/PaymentService
/system/app/PrintSpooler
/system/app/securityadd
/system/app/SecurityInputMethod
/system/app/SimAppDialog
/system/app/Stk
/system/app/TouchAssistant
/system/app/Traceur
/system/app/TranslationService
/system/app/Updater
/system/app/VsimCore
/system/app/WAPPushManager
/system/app/WMService
/system/app/XiaomiModemDebugService
/system/app/YouDaoEngine
/system/app/Zman
/system/app/mab
/system/data-app
/system/framework/arm
/system/framework/arm64
/system/framework/oat
/system/framework/boot.vdex
/system/framework/boot-android.test.base.vdex
/system/framework/boot-apache-xml.vdex
/system/framework/boot-bouncycastle.vdex
/system/framework/boot-com.nxp.nfc.nq.vdex
/system/framework/boot-core-libart.vdex
/system/framework/boot-ext.vdex
/system/framework/boot-framework.vdex
/system/framework/boot-ims-common.vdex
/system/framework/boot-miuisdk@boot.vdex
/system/framework/boot-miuisystemsdk@boot.vdex
/system/framework/boot-okhttp.vdex
/system/framework/boot-qcom.fmradio.vdex
/system/framework/boot-QPerformance.vdex
/system/framework/boot-tcmiface.vdex
/system/framework/boot-telephony-common.vdex
/system/framework/boot-telephony-ext.vdex
/system/framework/boot-UxPerformance.vdex
/system/framework/boot-voip-common.vdex
/system/framework/boot-WfdCommon.vdex
/system/media/wallpaper
/system/priv-app/BlockedNumberProvider
/system/priv-app/Browser
/system/priv-app/CallLogBackup
/system/priv-app/DMRegService
/system/priv-app/MiGameCenterSDKService
/system/priv-app/MiRcs
/system/priv-app/MiService
/system/priv-app/MiuiVideo
/system/priv-app/Music
/system/priv-app/MusicFX
/system/priv-app/com.qualcomm.location
/system/priv-app/QuickSearchBox
/system/priv-app/SoundRecorder
/system/app/systemAdSolution
/system/app/MSA-CN-NO_INSTALL_PACKAGE
/system/app/talkback
/system/app/PhotoTable
/system/app/mid_test
/system/app/MiuiVpnSdkManager
/system/app/FidoClient
/system/app/FidoCryptoService
/system/app/AutoTest
/system/app/AutoRegistration
/system/app/PrintRecommendationService
/system/app/SeempService
/system/app/com.miui.qr
/system/app/GPSLogSave
/system/app/SystemHelper
/system/app/SYSOPT
/system/app/xdivert
/system/app/MiuiDaemon
/system/app/Qmmi
/system/app/QdcmFF
/system/app/Xman
/system/app/Yman
/system/app/seccamsample
/system/app/greenguard
/system/app/QColor
/system/priv-app/dpmserviceapp
/system/priv-app/EmergencyInfo
/system/priv-app/UserDictionaryProvider
/system/priv-app/ONS
/system/product/app/datastatusnotification
/system/product/app/PhotoTable
/system/product/app/QdcmFF
/system/product/app/talkback
/system/product/app/xdivert
/system/product/priv-app/dpmserviceapp
/system/product/priv-app/EmergencyInfo
/system/product/priv-app/seccamservice
/system/data-app
/system/vendor/data-app"

DELETE_VENDOR="/vendor/app/GFManager/
/vendor/app/GFTest/"



PROJECT=../01-Project
ROM_SYSTEM=$PROJECT/system
ROM_VENDOR=$PROJECT/vendor

for FILE in $DELETE_SYSTEM ; do
  echo "- 删除System文件: "$ROM_SYSTEM$FILE
  rm -rf $ROM_SYSTEM$FILE
done
for FILE in $DELETE_VENDOR ; do
  echo "- 删除Vendor文件: "$ROM_VENDOR$FILE
  rm -rf $ROM_VENDOR$FILE
done

#优化GPS https://github.com/OLX-Team/GPS-Conf
echo "- 替换 "$ROM_SYSTEM
cp -rf ./system_files/ $ROM_SYSTEM/system
echo "- 替换 "$ROM_VENDOR
cp -rf ./vendor_files/ $ROM_VENDOR


#fs和context修复
FS_SYSTEM_PATH=$PROJECT"/temp/system_fs_config2"
CTX_SYSTEM_PATH=$PROJECT"/temp/system_file_contexts2"

function repairXbinFsAndCtx(){
	for file in `ls ./${1}_files/xbin`
		do
			echo "- 修复 $PROJECT/${1}/xbin/$file"
			echo "${1}/xbin/${file} 0000 2000 00755" >> $FS_SYSTEM_PATH
			echo "/${1}/xbin/${file} u:object_r:${file}_exec:s0" >> $CTX_SYSTEM_PATH
		done
}

repairXbinFsAndCtx system

function repairThemeFsAndCtx(){
	for file in `ls ./${1}_files/media/theme/default`
		do
			echo "- 修复 $PROJECT/${1}/media/theme/default/$file"
			echo "${1}/media/theme/default/${file} 0000 0000 00644" >> $FS_SYSTEM_PATH
			echo "/${1}/media/theme/default/${file} u:object_r:system_file:s0" >> $CTX_SYSTEM_PATH
		done
}

repairThemeFsAndCtx system


#执行部分Prop优化
echo "- 替换 /system/build.prop"
cat ./other_files/system.prop >> $ROM_SYSTEM/system/build.prop

#执行部分Prop优化
echo "- 替换 /system/prop.default"
cat ./other_files/prop.default >> $ROM_SYSTEM/system/etc/prop.default

