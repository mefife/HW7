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
}

-(void)addPassword:(id)sender; {
    self.enterView.keychainPassword.text = @"";
    self.enterView.keyChainHost.text = @"";
    self.enterView.keychainUser.text = @"";
    [self.navigationController presentViewController:self.enterNavigation animated:YES completion:^{
        self.enterView.MEFUpdating = 0;
        
    }];
}

-(void)viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
    NSLog(@"I appeared");
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSDictionary *query = @{(__bridge id)kSecClass : (__bridge id)kSecClassInternetPassword,
                          (__bridge id)kSecMatchLimit : (__bridge id) kSecMatchLimitAll,
                          (__bridge id)kSecReturnAttributes : (__bridge id)kCFBooleanTrue};
    
    CFArrayRef result = NULL;
    SecItemCopyMatching((__bridge CFDictionaryRef) query, (CFTypeRef *)&result);
    
    NSArray * resultData = (__bridge NSArray *)result;
    //NSLog(@"Here is the status: %d",(int)status);
    //NSLog(@" Here is one result: %@",resultData[0]);
    return resultData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
 static NSString *CellIdentifier = @"Cells";
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    NSDictionary *query = @{(__bridge id)kSecClass : (__bridge id)kSecClassInternetPassword,
                            (__bridge id)kSecMatchLimit : (__bridge id) kSecMatchLimitAll,
                            (__bridge id)kSecReturnAttributes : (__bridge id)kCFBooleanTrue};
    
    CFArrayRef result = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef) query, (CFTypeRef *)&result);
    
    NSArray * resultData = (__bridge NSArray *)result;
    
    if (status == 0 ) {
        cell.textLabel.text = [resultData[indexPath.row] valueForKey:@"srvr"];
        cell.detailTextLabel.text = [resultData[indexPath.row] valueForKey:@"acct"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"My Cell has been tapped");
    
    NSDictionary *query = @{(__bridge id)kSecClass : (__bridge id)kSecClassInternetPassword,
                            (__bridge id)kSecMatchLimit : (__bridge id) kSecMatchLimitAll,
                            (__bridge id)kSecReturnAttributes : (__bridge id)kCFBooleanTrue};
    
    CFArrayRef result = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef) query, (CFTypeRef *)&result);
    
    NSArray * resultData = (__bridge NSArray *)result;
    
    NSDictionary *passquery = @{(__bridge id)kSecClass : (__bridge id)kSecClassInternetPassword,
                                (__bridge id)kSecAttrServer : [resultData[indexPath.row] valueForKey:@"srvr"],
                                (__bridge id)kSecReturnData : (__bridge id)kCFBooleanTrue};
    
    CFTypeRef passresult = NULL;
    
    OSStatus statuspass = SecItemCopyMatching((__bridge CFDictionaryRef) passquery, (CFTypeRef *)&passresult);
    
    NSData *passData = (__bridge NSData *)passresult;
    
    
    if (statuspass == 0 && status == 0) {
        [self.navigationController presentViewController:self.enterNavigation animated:YES completion:^{
            self.enterView.keyChainHost.text = [resultData[indexPath.row] valueForKey:@"srvr"];
            self.enterView.keychainUser.text = [resultData[indexPath.row] valueForKey:@"acct"];
            self.enterView.keychainPassword.text = [[NSString alloc] initWithData:passData encoding:NSUTF8StringEncoding];
            self.enterView.MEFUpdating = 1;
            self.enterView.OldHostName = [resultData[indexPath.row] valueForKey:@"srvr"];
        }];
    }
    
    
}

@end
