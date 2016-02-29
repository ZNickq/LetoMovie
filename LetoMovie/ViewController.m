//
//  ViewController.m
//  LetoMovie
//
//  Created by Zloteanu Nikita on 2/29/16.
//  Copyright © 2016 nichita. All rights reserved.
//

#import "ViewController.h"
#import "XMLDictionary.h"
#import "Movie.h"

@interface ViewController ()

@property NSArray *allMovies;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performSelectorInBackground:@selector(loadMovies) withObject:nil];
}

- (void) loadMovies
{
    //Running on separate thread now
    NSURL *initURL = [NSURL URLWithString:@"http://www.fandango.com/rss/newmovies.rss"];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:initURL];
    NSDictionary *data = [[XMLDictionaryParser sharedInstance] dictionaryWithParser:parser];
    
    NSMutableArray *loadedMovies = [NSMutableArray new];
    //Loop through received films
    for(NSDictionary *each in data[@"channel"][@"item"]) {
        NSString *title = each[@"title"];
        NSString *imageURL = each[@"enclosure"][@"_url"];
        
        //Get image from URL
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
        UIImage *image = [UIImage imageWithData:data];
        
        //Get movie rating from omdb
        NSString *ratingString = [NSString stringWithFormat:@"http://www.omdbapi.com/?t=%@&y=&plot=short&r=xml", title];
        ratingString = [ratingString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSURL *ratingURL = [NSURL URLWithString:ratingString];
        parser = [[NSXMLParser alloc] initWithContentsOfURL:ratingURL];
        NSDictionary *ratingData = [[XMLDictionaryParser sharedInstance] dictionaryWithParser:parser];
        
        NSString *rating = ratingData[@"movie"][@"_imdbRating"];
        float parsedRating = 10.0;
        if(![rating isEqualToString:@"N/A"]) {
            parsedRating = [rating floatValue];
        }
        
        Movie *movie = [[Movie alloc] initWithTitle:title image:image andRating:parsedRating];
        [loadedMovies addObject:movie];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
