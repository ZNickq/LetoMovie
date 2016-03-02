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
#import "MovieDataSource.h"
#import "CineworldAPI.h"
#import "MapViewController.h"

@interface ViewController ()

@property MovieDataSource *dataSource;
@property CineworldAPI *api;

@property CLLocationManager *locationManager;


@property NSArray *postcodesToShow;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"Movies";
    _locationManager = [CLLocationManager new];
    [self.locationManager requestWhenInUseAuthorization];
    
    self.api = [CineworldAPI new];
    self.dataSource = [MovieDataSource new];
    [self performSelectorInBackground:@selector(loadMovies) withObject:nil];
    
    self.movieTableView.delegate = self;
    self.movieTableView.dataSource = _dataSource;
}

/*
 This method actually loads ratings from omdbapi, instead of Popcorn Time.
 This is because PT doesn't offer an easy-to-access API anymore, and approval for a key can take up to 60 days. 
 
 Also, I was unsure if using external libraries was discouraged for this exercise, so I tried to stick to default methods as much as possible.
 If given the liberty to use another library, I would use AFNetworking, both to simplify the below networking code and to handle image loading/cachings.
 Right now, there is a rudimentary caching method implemented in MovieTableViewCell, but AFNetworking has far superior caching methods for that purpose.
 */
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
        
        //Get movie rating from omdb
        NSString *ratingString = [NSString stringWithFormat:@"http://www.omdbapi.com/?t=%@&y=&plot=short&r=xml", title];
        ratingString = [ratingString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSURL *ratingURL = [NSURL URLWithString:ratingString];
        parser = [[NSXMLParser alloc] initWithContentsOfURL:ratingURL];
        NSDictionary *ratingData = [[XMLDictionaryParser sharedInstance] dictionaryWithParser:parser];
        
        //Only parse if available
        NSString *rating = ratingData[@"movie"][@"_imdbRating"];
        float parsedRating = 10.0;
        if(![rating isEqualToString:@"N/A"]) {
            parsedRating = [rating floatValue];
        }
        
        Movie *movie = [[Movie alloc] initWithTitle:title image:imageURL andRating:parsedRating];
        [loadedMovies addObject:movie];
    }
    
    
    
    //Sort by rating first, then title descending
    NSSortDescriptor *rating = [[NSSortDescriptor alloc] initWithKey:@"rating" ascending:NO];
    NSSortDescriptor *title = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:NO];
    NSArray *sortDescriptors = @[rating, title];
    self.dataSource.allMovies = [loadedMovies sortedArrayUsingDescriptors:sortDescriptors];
    
    
    [self.movieTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}


#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Movie *movie = self.dataSource.allMovies[indexPath.row];
    NSString *title = movie.title;
    self.postcodesToShow = [self.api findClosestMatch:title];
    if(self.postcodesToShow.count == 0) {
        //Deprecated, but works on < iOS 9
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"We're sorry, but it doesn't seem like Cineworld is playing that movie!"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alert show];
    } else {
        [self performSegueWithIdentifier:@"showMap" sender:self];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showMap"]) {
        MapViewController *map = segue.destinationViewController;
        map.postcodes = self.postcodesToShow;
    }
}


@end
