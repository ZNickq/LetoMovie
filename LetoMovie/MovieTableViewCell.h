//
//  MovieTableViewCell.h
//  LetoMovie
//
//  Created by Zloteanu Nikita on 2/29/16.
//  Copyright © 2016 nichita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@property (weak, nonatomic) IBOutlet UILabel *movieLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieRating;

- (void) updateWithMovie: (Movie *) m;

@end
