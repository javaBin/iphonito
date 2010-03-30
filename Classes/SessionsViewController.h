//
//  FirstViewController.h
//  iphonito
//
//  Created by Bjarte Karlsen on 3/27/10.
//  Copyright Go Mobile 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SessionsViewController : UITableViewController {

	NSMutableArray* sessions;
	NSMutableArray *sectionsArray;
	UILocalizedIndexedCollation *collation;
}

- (void) configureSessions;

@property (nonatomic, retain) NSMutableArray *sectionsArray;
@property (nonatomic, retain) UILocalizedIndexedCollation *collation;
@property (nonatomic, retain) NSArray *sessions;

@end
