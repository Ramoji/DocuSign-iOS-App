//
//  MenuViewController.m
//  DocuSign
//
//  Created by Aniket Deshmukh on 23/01/14.
//  Copyright (c) 2014 TopCoder. All rights reserved.
//

#import "MenuViewController.h"
#import "DocuSignClient.h"
#import "DocumentsListViewController.h"
#import "SignatureRequestViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowDocumentsList"]) {
        NSIndexPath * indexPath = (NSIndexPath *)sender;
        DSFolderType folderType;
        switch (indexPath.row) {
            case 0:
                folderType = AwaitingMySignature;
                break;
            case 1:
                folderType = Drafts;
                break;
            case 2:
                folderType = OutForSignature;
                break;
            case 3:
            default:
                folderType = Completed;
                break;
        }
        if ([segue.destinationViewController isKindOfClass:[DocumentsListViewController class]]) {
            DocumentsListViewController * destinationVC = (DocumentsListViewController *)segue.destinationViewController;
            
            destinationVC.title = [self.tableView cellForRowAtIndexPath:indexPath].textLabel.text;
            destinationVC.folderType = folderType;
        }
    }
    else if ([segue.identifier isEqualToString:@"RequestSignatureUsingTemplate"]) {
        if ([segue.destinationViewController isKindOfClass:[SignatureRequestViewController class]]) {
            SignatureRequestViewController * destinationVC = (SignatureRequestViewController *)segue.destinationViewController;
            destinationVC.signatureRequestType = UsingTemplate;
        }
    }
    else if ([segue.identifier isEqualToString:@"RequestSignatureUsingDocument"]) {
        if ([segue.destinationViewController isKindOfClass:[SignatureRequestViewController class]]) {
            SignatureRequestViewController * destinationVC = (SignatureRequestViewController *)segue.destinationViewController;
            destinationVC.signatureRequestType = UsingDocument;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row != [tableView numberOfRowsInSection:indexPath.section] - 1) {
            [self performSegueWithIdentifier:@"ShowDocumentsList" sender:indexPath];
    }
}

#pragma mark Navigation

@end
