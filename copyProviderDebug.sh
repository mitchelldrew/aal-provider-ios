#!
rm -rf provider.framework
rm -rf ~/workspace/ios/aal-app/provider.framework
rm -rf ~/workspace/ios/aal-app/presenter.framework
cp -R build/provider/Build/Products/Debug-iphonesimulator/provider.framework provider.framework
cp -R presenter.framework ~/workspace/ios/aal-app/presenter.framework
mv provider.framework ~/workspace/ios/aal-app/provider.framework
