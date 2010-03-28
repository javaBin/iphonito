//
//  FirstViewController.m
//  iphonito
//
//  Created by Bjarte Karlsen on 3/27/10.
//  Copyright Go Mobile 2010. All rights reserved.
//

#import "SessionsViewController.h"
#import "JavaZoneRepository.h"

@implementation SessionsViewController
@synthesize sessions;


- (void)viewDidLoad {
    [super viewDidLoad];
	
	JavaZoneRepository *repo = [[JavaZoneRepository alloc] init];
	
	self.sessions = [repo loadSessions];
	
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sessions count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
    
	NSDictionary* session = (NSDictionary *) [self.sessions objectAtIndex: indexPath.row];
	
	cell.textLabel.text = (NSString *)[session objectForKey: @"title"];
    
    return cell;
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
    [super dealloc];
}

@end
