//
//  Talk.m
//  iphonito
//
//  Created by Bjarte Karlsen on 3/28/10.
//  Copyright 2010 Go Mobile. All rights reserved.
//

#import "Talk.h"


@implementation Talk

@synthesize bodyHtml, talkId, format, room, selfUri, sessionHtmlUrl, title, end, start, label, level, speakers;

+ (id)talkFromDictionary:(NSDictionary *)dict {
	
	Talk *newTalk = [[[self alloc] init] autorelease];
	newTalk.bodyHtml = [dict objectForKey:@"bodyHtml"];
	newTalk.talkId = [dict objectForKey: @"id"];
	newTalk.room = [dict objectForKey: @"room"];
	newTalk.format = [dict objectForKey: @"format"];
	newTalk.selfUri = [dict objectForKey: @"selfUri"];
	newTalk.sessionHtmlUrl = [dict objectForKey: @"sessionHtmlUrl"];
	newTalk.title = [dict objectForKey: @"title"];
	newTalk.end = [dict objectForKey: @"end"];
	newTalk.start = [dict objectForKey: @"start"];
	newTalk.label = [dict objectForKey: @"label"];
	newTalk.level = [dict objectForKey: @"end"];
	newTalk.speakers = [dict objectForKey: @"speakers"];

	return newTalk;
}

@end
