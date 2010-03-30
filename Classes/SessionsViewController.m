//
//  FirstViewController.m
//  iphonito
//
//  Created by Bjarte Karlsen on 3/27/10.
//  Copyright Go Mobile 2010. All rights reserved.
//

#import "SessionsViewController.h"
#import "JavaZoneRepository.h"
#import "Talk.h"

@implementation SessionsViewController
@synthesize sessions, sectionsArray, collation;


- (void)viewDidLoad {
    [super viewDidLoad];
	
	JavaZoneRepository *repo = [[JavaZoneRepository alloc] init];
	self.title = @"Sessions";

	self.sessions = [repo loadSessions];
	[self configureSessions];
	
}

- (void) configureSessions {
	// Get the current collation and keep a reference to it.
	self.collation = [UILocalizedIndexedCollation currentCollation];
	
	NSInteger index, sectionTitlesCount = [[collation sectionTitles] count];
	
	NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
	
	// Set up the sections array: elements are mutable arrays that will contain the time zones for that section.
	for (index = 0; index < sectionTitlesCount; index++) {
		NSMutableArray *array = [[NSMutableArray alloc] init];
		[newSectionsArray addObject:array];
		[array release];
	}
	
	// Segregate the time zones into the appropriate arrays.
	for (Talk *talk in sessions) {
		
		// Ask the collation which section number the time zone belongs in, based on its locale name.
		NSInteger sectionNumber = [collation sectionForObject:talk collationStringSelector:@selector(title)];
		
		// Get the array for the section.
		NSMutableArray *sectionForTalk = [newSectionsArray objectAtIndex:sectionNumber];
		
		//  Add the time zone to the section.
		[sectionForTalk addObject:talk];
	}
	
	// Now that all the data's in place, each section array needs to be sorted.
	for (index = 0; index < sectionTitlesCount; index++) {
		
		NSMutableArray *talkArrayForSection = [newSectionsArray objectAtIndex:index];
		
		// If the table view or its contents were editable, you would make a mutable copy here.
		NSArray *sortedTalkArrayForSection = [collation sortedArrayFromArray:talkArrayForSection collationStringSelector:@selector(title)];
		
		// Replace the existing array with the sorted array.
		[newSectionsArray replaceObjectAtIndex:index withObject:sortedTalkArrayForSection];
	}
	
	self.sectionsArray = newSectionsArray;
	[newSectionsArray release];	
	
}



#pragma mark -
#pragma mark Table view data source and delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// The number of sections is the same as the number of titles in the collation.
    return [[collation sectionTitles] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	// The number of time zones in the section is the count of the array associated with the section in the sections array.
	NSArray *talksInSection = [sectionsArray objectAtIndex:section];
	
    return [talksInSection count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Get the time zone from the array associated with the section index in the sections array.
	NSArray *talksInSection = [sectionsArray objectAtIndex:indexPath.section];
	
	// Configure the cell with the time zone's name.
	Talk *talk = [talksInSection objectAtIndex:indexPath.row];
    cell.textLabel.text = talk.title;
	
    return cell;
}


/*
 Section-related methods: Retrieve the section titles and section index titles from the collation.
 */

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[collation sectionTitles] objectAtIndex:section];
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [collation sectionIndexTitles];
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [collation sectionForSectionIndexTitleAtIndex:index];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[sessions release];
	[sectionsArray release];
	[collation release];
    [super dealloc];
}

@end
