//
//  JavaZoneRepository.h
//  iphonito
//
//  Created by Bjarte Karlsen on 3/27/10.
//  Copyright 2010 Go Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JavaZoneRepository : NSObject {

}

- (NSDictionary *) loadTracks;
- (NSArray *) loadSessions;
- (NSArray *) loadSpeakers;
- (NSArray *) loadTweets;

- (id) objectWithUrl:(NSURL *)url;
- (id) stringWithUrl:(NSURL *)url;
@end
