//
//  PasswordTableView.m
//  UW_HW7_mefife
//
//  Created by Matthew Fife on 11/21/14.
//  Copyright (c) 2014 Matthew Fife. All rights reserved.
//

#import "PasswordTableView.h"
#import "PasswordEnter.h"

@interface PasswordTableView () <UITableViewDelegate, UITableViewDataSource>
@property PasswordEnter * enterView;
@property UINavigationController * enterNavigation;
@end

@implementation PasswordTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPassword:)];
    self.enterView = [[PasswordEnter alloc] init];
    self.enterNavigation = [[UINavigationController alloc] initWithRootViewController:self.enterView];
    //self.enterNavigation.title = @"SUP";
    //self.enterNavigation.navigationItem.rightBarButtonItem = self.editButtonItem;
    //self.enterNavigation.navigationItem.leftBarButtonItem = self.
    
    //UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController: mvc];

}

-(void)addPassword:(id)sender; {
    [self.navigationController presentViewController:self.enterNavigation animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5; // Change this with keychain
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
 static NSString *CellIdentifier = @"Cells";
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = @"hi";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Configure the cell...
//    NSDictionary *query @{ (__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword,
//                           (__bridge id)kSecAttrAccount : self,
//                           (__bridge id)kSecReturnData : (__bridge id)kCFBooleanTrue };
//    
//    CFTypeRef result = NULL;
//    
//    SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
//    
//    if (result !=NULL) {
//        NSData * resultData = (__bridge NSData *)result;
//        cell.textLabel.text = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
//        }
    


    
    return cell;
}


-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"My Cell has been tapped");
    [self.navigationController presentViewController:self.enterNavigation animated:YES completion:nil];
    
}

@end
