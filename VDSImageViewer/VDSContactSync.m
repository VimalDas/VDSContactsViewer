//
//  VDSContactSync.m
//  ContactsSyncProject
//
//  Created by Vimal Das on 08/11/17.
//  Copyright © 2017 kawika. All rights reserved.
//

#import "VDSContactSync.h"

@implementation VDSContactSync

-(NSMutableArray *)contactsArray{
    return _contactsArray;
}
-(NSMutableArray *)contactsImageArray{
    return _contactsImageArray;
}
-(NSMutableArray *)contactsThumbnailImageArray {
    return _contactsThumbnailImageArray;
}
-(NSMutableArray *)contactsNameArray{
    return _contactsNameArray;
}
-(void)setupContactsSyncWithPlaceholderImage:(UIImage *)placeholder withSuccess:(void (^)(bool status ,NSMutableArray *contactImageArray, NSMutableArray *contactThumbnailArray,NSMutableArray *contactNameArray,NSMutableArray *contactFulldetailsArray))completion{
    _contactsArray = [[NSMutableArray alloc] init];
    _contactsImageArray = [[NSMutableArray alloc] init];
     formatter = [[CNContactFormatter alloc] init];
    _contactsNameArray = [[NSMutableArray alloc]init];
    _contactsThumbnailImageArray = [[NSMutableArray alloc]init];
    CNContactStore *store = [[CNContactStore alloc]init];
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
        if (!granted) {
            completion(NO,nil,nil,nil,nil);
            return;
        }
        
        NSArray *keysToFetch = [[NSArray alloc]initWithObjects:  [CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName],CNContactPhoneNumbersKey,CNContactEmailAddressesKey,CNContactImageDataKey, CNContactThumbnailImageDataKey, nil];
        
        CNContactFetchRequest *request = [[CNContactFetchRequest alloc]initWithKeysToFetch: keysToFetch];
        NSError *fetchError;
        BOOL success = [store enumerateContactsWithFetchRequest:request error:&fetchError usingBlock:^(CNContact *contact, BOOL *stop) {
            if (!_contactsArray) {
                _contactsArray = [[NSMutableArray alloc] init];
            }
            [_contactsArray addObject:contact];
        }];
        
        if (!success) { NSLog(@"error = %@", fetchError); }
   
        for (CNContact *contact in _contactsArray) {
           
            if ([contact thumbnailImageData]){
                [_contactsThumbnailImageArray addObject:[contact thumbnailImageData]];
                [_contactsImageArray addObject:[contact thumbnailImageData]];
                
            }else {
                if (placeholder != nil) {
                    [_contactsThumbnailImageArray addObject: UIImageJPEGRepresentation(placeholder, 1.0)];
                    [_contactsImageArray addObject: UIImageJPEGRepresentation(placeholder, 1.0)];

                }
            }
            NSString *string = [formatter stringFromContact:contact];
            NSLog(@"contact = %@", string);
             [_contactsNameArray addObject:string];
        }
        completion(YES,_contactsImageArray,_contactsThumbnailImageArray,_contactsNameArray,_contactsArray);
    }];
}



@end
