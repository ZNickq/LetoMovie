//
//  CineworldAPI.m
//  LetoMovie
//
//  Created by Zloteanu Nikita on 3/1/16.
//  Copyright © 2016 nichita. All rights reserved.
//

#import "CineworldAPI.h"

@implementation CineworldMovie

@end


@interface CineworldAPI()

@property NSArray *cineworldMovies;

@end
@implementation CineworldAPI

- (id) init
{
    self = [super init];
    if(self) {
        [self loadMovieData];
    }
    return self;
}

- (void) loadMovieData
{
    NSURL *moviesURL = [NSURL URLWithString:@"http://www2.cineworld.co.uk/api/quickbook/films?key=kvne7aq9"];
    NSData *moviesData = [NSData dataWithContentsOfURL:moviesURL];
    NSDictionary *moviesDictionary = [NSJSONSerialization JSONObjectWithData:moviesData options:0 error:nil];
    
    NSMutableArray *movieObjects = [NSMutableArray new];
    for(NSDictionary *eachFilm in moviesDictionary[@"films"]) {
        NSInteger edi = [eachFilm[@"edi"] integerValue];
        NSString *title = eachFilm[@"title"];
        
        CineworldMovie *cm = [CineworldMovie new];
        cm.title = title;
        cm.edi = edi;
        [movieObjects addObject:cm];
    }
    self.cineworldMovies = movieObjects;
}

- (NSArray *) findClosestMatch:(NSString *)title
{
    for(CineworldMovie *cm in self.cineworldMovies) {
        if([cm.title containsString:title]) { //Cineworld title is more verbose, so we check contains, not equals
            NSString *moviesString = [NSString stringWithFormat:@"http://www.cineworld.com/api/quickbook/cinemas?key=kvne7aq9&film=%ld&full=true",cm.edi];
            NSURL *moviesURL = [NSURL URLWithString:moviesString];
            NSData *moviesData = [NSData dataWithContentsOfURL:moviesURL];
            NSDictionary *moviesDictionary = [NSJSONSerialization JSONObjectWithData:moviesData options:0 error:nil];
            
            NSMutableArray *toReturn = [NSMutableArray new];
            NSArray *cinemas = moviesDictionary[@"cinemas"];
            for(NSDictionary *cinema in cinemas) {
                [toReturn addObject:cinema[@"postcode"]];
            }
            return toReturn;
            
        }
    }
    return @[];
}

@end
