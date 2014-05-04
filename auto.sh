#!/bin/bash
# 2014-04-03
# 编译当前工程并打包
# 只产生一个ipa


distDir="distdir"
#项目名称(xcode左边列表中显示的项目名称)
targetName="tweejump"
#应用app名称(xcode左边列表中显示的项目名称)
appName="测试程序"
ipafilename="tweeipa"
releaseDir="build/Release-iphoneos" #build的临时目录，会稍后删除
version="1.0"
sdk="macosx10.9"
sdk="iphoneos7.1"
sdk="iphonesimulator7.1"
sdk="iphonesimulator"
#rm -rdf "$distDir"
mkdir -p "$distDir"
sourceid=`date '+%Y-%m-%d_%H-%M-%S'` #最终ipa名称会包含时间
echo "ipafilename=$ipafilename"
echo "sourceid=$sourceid"
echo "targetName:$targetName"
echo "appName:$appName"
#rm -rdf "$releaseDir"
mkdir -p "$releaseDir"


ipapath="${distDir}/${targetName}_${version}_at_${sourceid}.ipa"


echo "***开始build app文件***"
echo "***开始clean ***"
xcodebuild -target "$targetName" clean 
echo "xcodebuild -target '$targetName' clean "
echo "***开始build ***"
#xcodebuild -sdk iphoneos -target "$targetName"  build
xcodebuild -sdk $sdk -target "$targetName"  build
appfile="${releaseDir}/${appName}.app"
if [ $sourceid == "appstore" ]
then
	cd $releaseDir
	zip -r "${targetName}_${ipafilename}_${version}.zip" "${targetName}.app"
	mv "${targetName}_${ipafilename}.zip" $distDir 2> /dev/null
	cd ../..
else
	echo "***开始打ipa渠道包****" 
	#sudo /usr/bin/xcrun -sdk iphoneos PackageApplication -v "$appfile" -o "$ipapath"
	sudo /usr/bin/xcrun -sdk $sdk PackageApplication -v "$appfile" -o "$ipapath"
fi

