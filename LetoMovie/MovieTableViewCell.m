//
//  MovieTableViewCell.m
//  LetoMovie
//
//  Created by Zloteanu Nikita on 2/29/16.
//  Copyright © 2016 nichita. All rights reserved.
//

#import "MovieTableViewCell.h"

@implementation MovieTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) updateWithMovie: (Movie *) m
{
    self.movieImage.image = m.thumbnail;
    self.movieLabel.text = m.title;
    self.movieRating.text = [NSString stringWithFormat:@"%f", m.rating];
}

@end
