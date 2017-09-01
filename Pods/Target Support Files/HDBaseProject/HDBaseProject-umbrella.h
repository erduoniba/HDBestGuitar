#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "HDBaseProject.h"
#import "NSObject+Custom.h"
#import "UIColor+RGBValues.h"
#import "UIImage+Add.h"
#import "UIImage+Crop.h"
#import "UIImage+Tint.h"
#import "UIImageView+VideoFirstImage.h"
#import "UILabel+HarryExtension.h"
#import "UITableView+Extension.h"
#import "UIView+Helpers.h"
#import "HDBaseCellViewModel.h"
#import "HDBaseUITableViewCell.h"
#import "HDBaseUITableViewController.h"
#import "HDBaseUIWebViewController.h"
#import "HDBaseViewController.h"
#import "HDGlobalMethods.h"
#import "HDGlobalVariable.h"
#import "HDCustomCache.h"
#import "HDHTTPSessionRequest.h"
#import "TOActivityChrome.h"
#import "TOActivitySafari.h"
#import "TOWebViewController.h"
#import "UIImage+TOWebViewControllerIcons.h"

FOUNDATION_EXPORT double HDBaseProjectVersionNumber;
FOUNDATION_EXPORT const unsigned char HDBaseProjectVersionString[];

