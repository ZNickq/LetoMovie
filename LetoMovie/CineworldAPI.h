//
//  CineworldAPI.h
//  LetoMovie
//
//  Created by Zloteanu Nikita on 3/1/16.
//  Copyright © 2016 nichita. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CineworldMovie : NSObject

@property NSString *title;
@property NSInteger edi;

@end

@interface CineworldAPI : NSObject

- (NSArray *) findClosestMatch: (NSString *) title;

@end
