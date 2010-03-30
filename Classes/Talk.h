//
//  Talk.h
//  iphonito
//
//  Created by Bjarte Karlsen on 3/28/10.
//  Copyright 2010 Go Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Talk : NSObject {

	NSString *bodyHtml;
	NSString *talkId;
	NSString *format;
	NSString *room;
	NSString *selfUri;
	NSString *sessionHtmlUrl;
	NSString *title;
	
	NSDictionary *end;
	NSDictionary *start;
	NSDictionary *label;
	NSDictionary *level;
	NSDictionary *speakers;
	
}

@property (nonatomic, copy) NSString *bodyHtml, *talkId, *format, *room, *selfUri, *sessionHtmlUrl, *title;
@property (nonatomic, retain) NSDictionary *end, *start, *label, *level, *speakers;


+ (id)talkFromDictionary:(NSDictionary *)dict;

@end
