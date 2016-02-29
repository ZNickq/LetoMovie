//
//  MovieDataSource.m
//  LetoMovie
//
//  Created by Zloteanu Nikita on 2/29/16.
//  Copyright © 2016 nichita. All rights reserved.
//

#import "MovieTableViewCell.h"
#import "MovieDataSource.h"

@implementation MovieDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allMovies.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieTableViewCell *mtvc = [tableView dequeueReusableCellWithIdentifier:@"movieCell"];
    
    Movie *m = self.allMovies[indexPath.row];
    [mtvc updateWithMovie:m];
    
    return mtvc;
}

- (void) setAllMovies:(NSArray *)allMovies
{
    _allMovies = allMovies;
    
    NSSortDescriptor *rating = [[NSSortDescriptor alloc] initWithKey:@"rating" ascending:NO];
    NSSortDescriptor *title = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:NO];
    
    NSArray *sortDescriptors = @[rating, title];
    
    _allMovies = [allMovies sortedArrayUsingDescriptors:sortDescriptors];

    
}

@end
