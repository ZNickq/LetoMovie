//
//  MapViewController.h
//  LetoMovie
//
//  Created by Zloteanu Nikita on 3/2/16.
//  Copyright © 2016 nichita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property NSArray *postcodes;

@end
