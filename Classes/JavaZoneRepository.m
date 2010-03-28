//
//  JavaZoneRepository.m
//  iphonito
//
//  Created by Bjarte Karlsen on 3/27/10.
//  Copyright 2010 Go Mobile. All rights reserved.
//

#import "JavaZoneRepository.h"


@implementation JavaZoneRepository


- (NSString *)stringWithUrl:(NSURL *)url
{
	NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url
															  cachePolicy:NSURLRequestReturnCacheDataElseLoad
														  timeoutInterval:30];
	[urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];  
	
	// Fetch the JSON response
	NSData *urlData;
	NSURLResponse *response;
	NSError *error;
	
	// Make synchronous request
	urlData = [NSURLConnection sendSynchronousRequest:urlRequest
									returningResponse:&response
												error:&error];
	
 	// Construct a String around the Data from the response
	return [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
}

- (id) objectWithUrl:(NSURL *)url
{
	SBJSON *jsonParser = [SBJSON new];
	NSString *jsonString = [self stringWithUrl:url];
	// Parse the JSON into an Object
	return [jsonParser objectWithString:jsonString error:NULL];
}


- (NSArray *) loadSessions
{
	id response = [self objectWithUrl:[NSURL URLWithString:@"http://javazone.no/incogito09/rest/events/JavaZone%202009/sessions"]];
	
	NSDictionary *feed = (NSDictionary *)response;
	return (NSArray *) [feed objectForKey:@"sessions"];
}

- (NSArray *) loadSpeakers
{
	id response = [self objectWithUrl:[NSURL URLWithString:@"http://javazone.no/incogito09/rest/events/JavaZone%202009/speakers"]];
	
	NSArray *feed = (NSArray *)response;
	return feed;
}

- (NSDictionary *) loadTracks
{
	id response = [self objectWithUrl:[NSURL URLWithString:@"http://javazone.no/incogito09/rest/events/JavaZone%202009"]];
	
	NSDictionary *feed = (NSDictionary *)response;
	return feed;
}

- (NSArray *) loadTweets 
{
	id response = [self objectWithUrl:[NSURL URLWithString:@"http://search.twitter.com/search.json?&ors=%23jz10+%23javazone+%40javazone&lang=all"]];
	NSDictionary *feed = (NSDictionary *)response;
	return (NSArray *) [feed objectForKey:@"results"];
	
}
@end
