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
@synthesize sessions, sectionsArray, collation, filteredSessions, savedSearchTerm, searchWasActive, tableData;


- (void)viewDidLoad {
    [super viewDidLoad];
	
	JavaZoneRepository *repo = [[JavaZoneRepository alloc] init];
	self.title = @"Sessions";

	self.tableData = [repo loadSessions];
    self.sessions = self.tableData;
	
	// create a filtered list that will contain products for the search results table.
	self.filteredSessions = [NSMutableArray arrayWithCapacity:[self.sessions count]];
	
	// restore search settings if they were saved in didReceiveMemoryWarning.
    if (self.savedSearchTerm)
	{
        [self.searchDisplayController setActive:self.searchWasActive];
        [self.searchDisplayController.searchBar setText:savedSearchTerm];        
        self.savedSearchTerm = nil;
	
    }
	[self.tableView reloadData];
	self.tableView.scrollEnabled = YES;
	
}

- (void)setTableData:(NSArray *)newDataArray {
	if (newDataArray != tableData) {
		[tableData release];
		tableData = [newDataArray retain];
	}
	if (tableData == nil) {
		self.sectionsArray = nil;
	}
	else {
		[self configureSessions];
	}
}

- (void) configureSessions {
	
	self.collation = [UILocalizedIndexedCollation currentCollation];
	
	NSInteger index, sectionTitlesCount = [[collation sectionTitles] count];
	
	NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
	
	// Set up the sections array: elements are mutable arrays that will contain the time zones for that section.
	for (index = 0; index < sectionTitlesCount; index++) {
		NSMutableArray *array = [[NSMutableArray alloc] init];
		[newSectionsArray addObject:array];
		[array release];
	}
	
	for (Talk *talk in tableData) {
		
		NSInteger sectionNumber = [collation sectionForObject:talk collationStringSelector:@selector(title)];
		NSMutableArray *sectionForTalk = [newSectionsArray objectAtIndex:sectionNumber];
		[sectionForTalk addObject:talk];
	}
	
	for (index = 0; index < sectionTitlesCount; index++) {
		
		NSMutableArray *talkArrayForSection = [newSectionsArray objectAtIndex:index];
		NSArray *sortedTalkArrayForSection = [collation sortedArrayFromArray:talkArrayForSection collationStringSelector:@selector(title)];
		[newSectionsArray replaceObjectAtIndex:index withObject:sortedTalkArrayForSection];
	}
	
	self.sectionsArray = newSectionsArray;
	[newSectionsArray release];	
	
}



#pragma mark -
#pragma mark Table view data source and delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[collation sectionTitles] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
    return [[sectionsArray objectAtIndex:section] count];
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
    NSMutableArray *titles = [[collation sectionIndexTitles] mutableCopy];
	[titles insertObject:@"{search}" atIndex:0];
	return titles;
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
	if (index == 0) {
		// search item
		[tableView scrollRectToVisible:[[tableView tableHeaderView] bounds] animated:NO];
		return -1;
	}	
	
	
	return [collation sectionForSectionIndexTitleAtIndex:index];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
}


#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
	 [self.filteredSessions removeAllObjects]; // First clear the filtered array.
	 
	 for (Talk *talk in sessions)
	 {
		 NSComparisonResult result = [talk.title compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
		 if (result == NSOrderedSame)
		 {
			 [self.filteredSessions addObject:talk];
		 }
	 }
    self.tableData = filteredSessions;
	return YES;
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


- (void)viewDidDisappear:(BOOL)animated
{
    // save the state of the search UI so that it can be restored if the view is re-created
    self.searchWasActive = [self.searchDisplayController isActive];
    self.savedSearchTerm = [self.searchDisplayController.searchBar text];
}

- (void)viewDidUnload
{
	self.filteredSessions = nil;
}

- (void)dealloc {
	[sessions release];
	[sectionsArray release];
	[collation release];
    [super dealloc];
}

@end
