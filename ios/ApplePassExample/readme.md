#Apple Pass Example

Apple Wallet gives users a convenient way to organize and use loyalty cards, coupons, and gift certificates. You can bring up passes in your app with Relevant Solutions APIs, send them via email, or post them on the web. You can also set the time or location for an item to appear.

#1) Register Certificate with Apple
In order to use Apple Wallet, you will need to register the Pass Type ID by visiting Apple's Pass Type IDs registration: https://developer.apple.com/account/ios/identifier/passTypeId 

1) By clicking the plus button on the top right corner, you will then give your Pass Type ID a description and identifier. The identifier is a reverse of your product domain or the Bundle Identifier in Xcode.

2) Once you have created the pass, you will need to export it for external use. Click the newly created pass and there will be an "edit" button. You will want to "Create Certificate" and follow the iTunes guide.

3) Once you have uploaded the CSR, you will want to download the certificate and double click to add to your keychain. Find your certificate in the keychain and right click selecting "Export".

4) Enter a password for the export and either remember or write down the password because it will be used later on to validate with the admin portal

#2) Add certificate to Admin
Login to Relevant Solutions Admin portal: [Admin Portal](https://admin.groupinterest.com). If you do not see the "Certificate" menu item, navigate to "My App" > "Advanced " > Turn "Notifications Enabled" to "Enabled".

1) Navigate to Certificates and click "Add Certificate" at the top right corner

2) Give the certificate a Name, and use the same password you used to export the certificate in the above process. We hash and encrypt the password so that it is only used when signing a new passkit item

3) Please provide the expiration date from the iTunes developer portal and select Production as the environment. Since we are using the Wallet, we will want to select the Certificate Type as "Wallet"

4) Once you have selected the Certificate and clicked add, you will want to select the "Active" checkbox in the list of the certificate you have just added.


#3) Code Changes
In order to load wallet items, you will need to update the WKWebView to override the navigation of request and download the Apple Pass. This repository has code examples of how this can be done. When a certificate is available, we will display an "Add to Wallet" button with the expectation the client will handle the download of the Pass file and addition into the wallet. If you have any questions, please contact justin@itisrelevant.com
