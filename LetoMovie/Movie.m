//
//  Movie.m
//  LetoMovie
//
//  Created by Zloteanu Nikita on 2/29/16.
//  Copyright © 2016 nichita. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id) initWithTitle: (NSString *) title image: (NSString *) image andRating: (float) rating;
{
    self = [super init];
    if(self) {
        self.title = title;
        self.thumbnail = image;
        self.rating = rating;
    }
    return self;
}

@end
