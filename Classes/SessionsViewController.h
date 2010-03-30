//
//  FirstViewController.h
//  iphonito
//
//  Created by Bjarte Karlsen on 3/27/10.
//  Copyright Go Mobile 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SessionsViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate> 
{

	NSArray			*tableData;
	NSMutableArray	*filteredSessions;		
    NSString		*savedSearchTerm;
    BOOL			searchWasActive;
	
	NSArray						*sessions;
	NSMutableArray				*sectionsArray;
	UILocalizedIndexedCollation *collation;
}

- (void) configureSessions;

@property (nonatomic, retain) NSMutableArray *sectionsArray, *filteredSessions;
@property (nonatomic, retain) NSArray *sessions, *tableData;

@property (nonatomic, retain) UILocalizedIndexedCollation *collation;

@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) BOOL searchWasActive;

@end
