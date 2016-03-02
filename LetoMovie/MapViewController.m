//
//  MapViewController.m
//  LetoMovie
//
//  Created by Zloteanu Nikita on 3/2/16.
//  Copyright © 2016 nichita. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController ()

@end

@implementation MapViewController


NSMutableDictionary *geocodedCodes;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    
    if(geocodedCodes == nil) {
        geocodedCodes = [NSMutableDictionary new];
    }
    
    
    CLLocationCoordinate2D london;
    london.latitude =  51.507222;
    london.longitude = -0.1275;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (london, 20000, 20000);
    [self.mapView setRegion:region animated:YES];
    
    
    for(NSString *postcode in self.postcodes) {
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:postcode
                     completionHandler:^(NSArray* placemarks, NSError* error){
                         if (placemarks && placemarks.count > 0) {
                             MKPlacemark *mkmark = [[MKPlacemark alloc] initWithPlacemark:[placemarks firstObject]];
                             [self.mapView addAnnotation:mkmark];
                         } else {
                             //NSLog(@"Errored! %@", error.localizedDescription);
                         }
                     }
         ];
    }
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    MKPlacemark *mp = (MKPlacemark *) view.annotation;
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:mp];
    [mapItem setName:@"Cinema"];
    [mapItem openInMapsWithLaunchOptions:nil];
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

@end
