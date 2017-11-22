# VDSContactsViewer


1. create an object for VDSContactSync :     @property (strong,nonatomic) VDSContactSync *contacts;

2. initialize the object:   _contacts = [[VDSContactSync alloc]init];

3. call the function when you need contacts:   

 [_contacts setupContactsSyncWithPlaceholderImage:[UIImage imageNamed:@"3"] withSuccess:^(bool status, NSMutableArray *contactImageArray, NSMutableArray *contactThumbnailArray, NSMutableArray *contactNameArray, NSMutableArray *contactFulldetailsArray) {
       
        if (status) {
            imageArray = contactImageArray;
            messageArray = contactNameArray;
            
            // reload you tableview or collectioview if you are populating it with the contact information.
            
            dispatch_async(dispatch_get_main_queue(), ^{
                    [_table reloadData];
            });
            
        }

        You will get 
        names only in       :  contactNames
        images only in      :  contactImageArray
        thumbnails only in  :  contactThumbnailArray
        or all data in      :  contactFulldetailsArray

4. thats it. enjoyy!!!
