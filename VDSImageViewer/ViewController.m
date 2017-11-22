//
//  ViewController.m
//  VDSImageViewer
//
//  Created by Vimal Das on 18/11/17.
//  Copyright © 2017 Vimal Das. All rights reserved.
//

#import "ViewController.h"
#import "DemoTableViewCell.h"
#import "VDSImageViewerAnimations.h"
#import "VDSContactSync.h"

@interface ViewController ()
{
    NSArray *imageArray;
    NSArray *messageArray;
}
@property (strong,nonatomic) VDSImageViewerAnimations *obj;
@property (strong,nonatomic) VDSContactSync *contacts;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _contacts = [[VDSContactSync alloc]init];
    _obj = [[VDSImageViewerAnimations alloc]init];
    imageArray = [[NSArray alloc]init];
    messageArray = [[NSArray alloc]init];
    
    
    [_contacts setupContactsSyncWithPlaceholderImage:[UIImage imageNamed:@"3"] withSuccess:^(bool status, NSMutableArray *contactImageArray, NSMutableArray *contactThumbnailArray, NSMutableArray *contactNameArray, NSMutableArray *contactFulldetailsArray) {
       
        if (status) {
            
            _obj.imageArray = contactImageArray;
            
            imageArray = contactImageArray;
            messageArray = contactNameArray;
            dispatch_async(dispatch_get_main_queue(), ^{
                    [_table reloadData];
            });
            
        }
        
    }];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return imageArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"demo"];
    cell.imageVw.image = [UIImage imageWithData:imageArray[indexPath.row]];
    cell.lbl.text = messageArray[indexPath.row];
    
    cell.imageVw.tag = indexPath.row;
    [_obj setupViews:cell.imageVw view:self];
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155;
}

@end
