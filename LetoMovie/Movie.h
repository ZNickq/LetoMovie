//
//  Movie.h
//  LetoMovie
//
//  Created by Zloteanu Nikita on 2/29/16.
//  Copyright © 2016 nichita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Movie : NSObject

@property NSString *title;
@property NSString *thumbnail;
@property float rating;

- (id) initWithTitle: (NSString *) title image: (NSString *) image andRating: (float) rating;

@end
