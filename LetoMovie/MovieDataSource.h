//
//  MovieDataSource.h
//  LetoMovie
//
//  Created by Zloteanu Nikita on 2/29/16.
//  Copyright © 2016 nichita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MovieDataSource : NSObject<UITableViewDataSource>

@property NSArray *allMovies;

@end
