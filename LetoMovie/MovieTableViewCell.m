//
//  MovieTableViewCell.m
//  LetoMovie
//
//  Created by Zloteanu Nikita on 2/29/16.
//  Copyright © 2016 nichita. All rights reserved.
//

#import "MovieTableViewCell.h"

@interface MovieTableViewCell()

@property NSString *thumbnailURL;

@end
@implementation MovieTableViewCell

NSMutableDictionary *allImages;

- (void) updateWithMovie: (Movie *) m
{
    if(allImages == nil) {
        allImages = [NSMutableDictionary new];
    }
    
    self.movieImage.image = nil;
    self.movieLabel.text = m.title;
    self.movieRating.text = [NSString stringWithFormat:@"%.01f", m.rating];
    
    if(allImages[m.thumbnail] != nil) {
        self.movieImage.image = allImages[m.thumbnail];
    } else {
        self.thumbnailURL = m.thumbnail;
        [self performSelectorInBackground:@selector(loadImage:) withObject:m.thumbnail];
    }
}

- (void) loadImage: (NSString *) thumbnail;
{
    //Get image from URL
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:thumbnail]];
    UIImage *image = [UIImage imageWithData:data];
    [self performSelectorOnMainThread:@selector(showImage:) withObject:image waitUntilDone:NO];
}

- (void) showImage: (UIImage *) image
{
    self.movieImage.image = image;
    allImages[self.thumbnailURL] = image;
}

@end
