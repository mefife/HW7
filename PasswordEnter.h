//
//  PasswordEnter.h
//  UW_HW7_mefife
//
//  Created by Matthew Fife on 11/21/14.
//  Copyright (c) 2014 Matthew Fife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordEnter : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *keyChainHost;
@property (weak, nonatomic) IBOutlet UITextField *keychainUser;
@property (weak, nonatomic) IBOutlet UITextField *keychainPassword;
@property int MEFUpdating; // 1 for yes 0 for no
@property NSMutableString * OldHostName;
@end
