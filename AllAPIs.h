//
//  AllAPIs.h
//  GOK
//
//  Created by admin on 4/23/18.
//  Copyright © 2018 MAC012. All rights reserved.
//

#ifndef AllAPIs_h
#define AllAPIs_h


//#define BASE_URL [NSString stringWithFormat:@"http://164.100.133.85/controlapi/Default.aspx?extrefid=%@",[Utils getRandomValueWithDate]]
#define BASE_URL [NSString stringWithFormat:@"http://164.100.133.85/controlapiv12/Default.aspx?extrefid=%@",[Utils getRandomValueWithDate]]
#define PROFIE_PIC_BASE_URL [NSString stringWithFormat:@"http://164.100.133.85/controlapiv12/uploadfile.aspx"]
//#define PROFIE_PIC_BASE_URL [NSString stringWithFormat:@"http://164.100.133.85/ChannelInterfacestaging/uploadfile.aspx"]
 #define PUSHAPPID @""
#define UPLOADNCRIMAGEURL @"https://mgov.telangana.gov.in/gotapi/api/upload/uploadfile"
#define MOBILE_CommonElect @"https://mgov.telangana.gov.in/gotapi/api/Common/Details"

//#define PAYMENT_URL @"http://164.100.133.83/paymentgateway/makepayment"//live
#define PAYMENT_URL @"https://stgpgh.imimobile.net/paymentgateway/makepayment"// staging

#define LLTEST_ALL_QA_URL @"https://www.mobile.karnataka.gov.in/stagingdownload/MockTest.pdf"

#define IRCTC_REDIRECT_URL @"https://www.irctc.co.in/eticketing/wsapplogin"
#define IRCTC_CALL_BACK_UR @"https://mobile.karnataka.gov.in/stagingshop/goken/irctcbookingcallback.aspx"
//#define IRCTC_CALL_BACK_UR @"https://www.google.com"

#define CLEARTAX_URL(mobilenumber,emial) [NSString stringWithFormat:@"https://cleartax.in/partner/GoK?MobNo=%@&IMISessionID=%@&email=%@",mobilenumber,[Utils getRandomValueWithDate],emial]

#define BABAJOBS_URL(mobilenumber,lang) [NSString stringWithFormat:@"http://www.babajob.com/gok.aspx?mobile=%@&ln=%@&circle=%@&IMISessionID=%@",mobilenumber,lang,@"",[Utils getRandomValueWithDate]]


#define FRROVISAREG_URL [NSString stringWithFormat:@"http://164.100.133.84/documents/frro_visa_reg_documents.html"]
#define FRROFAQS_URL [NSString stringWithFormat:@"http://164.100.133.84/documents/frro_faqs.html"]
#define FRRODOCUMENTS_URL [NSString stringWithFormat:@"http://164.100.133.84/documents/frro_documents.html"]
#define FRROCONTACTLIST_URL [NSString stringWithFormat:@"http://164.100.133.84/documents/frro_contact_list.html"]

#define EMERGENCY @"https://mgov.telangana.gov.in/EmergencyNew.html"
#define ContactUs @"https://mgov.telangana.gov.in/contactus.html"
#define TANDC @"https://mgov.telangana.gov.in/TermNCondition.html"
#define PRIVACY @"https://mgov.telangana.gov.in/PrivacyPolicy.html"
#define FAQ @"https://mgov.telangana.gov.in/FaqNew.html"
#define APIVersion @"https://mgov.telangana.gov.in/gotapi/api/appversion/get?os=ios"
#define Disclaimer @"https://mgov.telangana.gov.in/DisclaimerNew.html"
#define RefundPolicy @"https://mgov.telangana.gov.in/RefndPloicy.html"
#define WeatherInfo @"https://www.google.co.in/search?q=weather"
#define TrafficChallan @"https://www.echallan.org/publicview/"
#define Agriculture @"https://mgov.telangana.gov.in/FarmMechGuide.html"
#define GHMCRedirect @"http://www.ghmc.gov.in/ghmc.aspx"
#define TWallet @"https://itunes.apple.com/in/app/t-wallet/id1231319830?mt=8"
#define Tourism @"http://tourism.telangana.gov.in/"
#define TelanganaState @"http://www.telangana.gov.in/"
#define MetroTimings @"https://www.ltmetro.com/lt-metro-passenger/travel-train-timings.html"
#define Metroroute @"https://www.ltmetro.com/lt-metro-passenger/travel-metro-networkmap.html"
#define MetroFares @"https://www.ltmetro.com/lt-metro-passenger/fare-ticketing-find-trip-fare.html"
#define RTA_M_Wallet @"https://itunes.apple.com/in/app/rta-m-wallet/id1087318928?mt=8"



#endif /* AllAPIs_h */
