//
//  VDSContactSync.h
//  ContactsSyncProject
//
//  Created by Vimal Das on 08/11/17.
//  Copyright © 2017 kawika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Contacts/Contacts.h>

@interface VDSContactSync : NSObject
{
    CNContactFormatter *formatter;
}
@property(strong,nonatomic) NSMutableArray *contactsArray;
@property(strong,nonatomic) NSMutableArray *contactsImageArray;
@property(strong,nonatomic) NSMutableArray *contactsThumbnailImageArray;
@property(strong,nonatomic) NSMutableArray *contactsNameArray;
-(void)setupContactsSyncWithPlaceholderImage:(UIImage *)placeholder withSuccess:(void (^)(bool status ,NSMutableArray *contactImageArray, NSMutableArray *contactThumbnailArray,NSMutableArray *contactNameArray,NSMutableArray *contactFulldetailsArray))completion;

@end
