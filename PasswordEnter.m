//
//  PasswordEnter.m
//  UW_HW7_mefife
//
//  Created by Matthew Fife on 11/21/14.
//  Copyright (c) 2014 Matthew Fife. All rights reserved.
//

#import "PasswordEnter.h"

@interface PasswordEnter ()



@end

@implementation PasswordEnter

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.title = @"SUP";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(savePassword:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelPassword:)];
    
    //NSLog(@"Hello");
}

-(void)savePassword:(id)sender; {
    if ([self.keyChainHost.text length] == 0 || [self.keychainUser.text length] == 0 || [self.keychainPassword.text length] == 0) {
        return;
    }
    
    
    if (self.MEFUpdating == 0) {
        NSDictionary *attributes = @{ (__bridge id)kSecClass : (__bridge id)kSecClassInternetPassword,
                                      (__bridge id)kSecAttrAccount : self.keychainUser.text,
                                      (__bridge id)kSecAttrServer : self.keyChainHost.text,
                                      (__bridge id)kSecValueData : [self.keychainPassword.text dataUsingEncoding:NSUTF8StringEncoding] };
        
        OSStatus status = SecItemAdd((__bridge CFDictionaryRef)attributes, NULL);
        if (status == 0) {
            NSLog(@"Here is the updating mode %d:", self.MEFUpdating);
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
    }
    
    if (self.MEFUpdating == 1) {
        
        
        if (self.OldHostName == self.keyChainHost.text) {
            NSDictionary* updateQuery = @{ (__bridge id)kSecClass : (__bridge id)kSecClassInternetPassword,
                                           (__bridge id)kSecAttrServer : self.keyChainHost.text };
            
            NSDictionary* updatethings = @{ (__bridge id)kSecAttrAccount : self.keychainUser.text,
                                            (__bridge id)kSecValueData : [self.keychainPassword.text dataUsingEncoding:NSUTF8StringEncoding] };
            
            OSStatus helpstatus = SecItemUpdate((__bridge CFDictionaryRef) updateQuery, (__bridge CFDictionaryRef) updatethings);
            if (helpstatus == 0) {
                NSLog(@"Here is the updating mode %d:", self.MEFUpdating);
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }
        } else {
            NSDictionary* deleteQuery = @{ (__bridge id)kSecClass : (__bridge id)kSecClassInternetPassword,
                                           (__bridge id)kSecAttrServer : self.OldHostName };
            
            OSStatus delStatus = SecItemDelete((__bridge CFDictionaryRef) deleteQuery);
            
            NSDictionary *attributes = @{ (__bridge id)kSecClass : (__bridge id)kSecClassInternetPassword,
                                          (__bridge id)kSecAttrAccount : self.keychainUser.text,
                                          (__bridge id)kSecAttrServer : self.keyChainHost.text,
                                          (__bridge id)kSecValueData : [self.keychainPassword.text dataUsingEncoding:NSUTF8StringEncoding] };
            
            OSStatus status = SecItemAdd((__bridge CFDictionaryRef)attributes, NULL);
            if (status == 0 && delStatus == 0) {
                NSLog(@"Here is the updating mode %d:", self.MEFUpdating);
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }
            
            
            
        }
        
        
        
        
        
        
        
        
        
    }
    
    
    //NSLog(@"%d",(int)status);
    
    
    
    //NSDictionary * tempDictionary = @{@"Host" : self.keyChainHost.text , @"User" : self.keychainUser.text, @"Password" : self.keychainPassword.text};
    
    //[self.dataBall addObject:tempDictionary];
    
    //NSLog(@"Do some fancy saving here");
}

-(void)cancelPassword:(id)sender; {
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
