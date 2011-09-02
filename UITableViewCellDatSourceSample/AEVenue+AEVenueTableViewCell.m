//
//  AEVenue+AEVenueTableViewCell.m
//  UITableViewCellDatSourceSample
//
//  Created by Amos Elmaliah on 9/2/11.
//  Copyright (c) 2011 UIMUI. All rights reserved.
//

#import "AEVenue+AEVenueTableViewCell.h"
#import "AELocation.h"
#import "AECategory.h"
@implementation AEVenue (AEVenueTableViewCell)

-(NSString *) venueName
{
    return self.name;
}
-(NSString *)venueAddress
{
    return [(AELocation*)self.location address];
}
-(NSString *) streetAddress
{
    return [NSString stringWithFormat:@"%@ %@", [(AELocation*)self.location city], [(AELocation*)self.location country]];
}
-(NSNumber *) longitude
{
    return [(AELocation*)self.location longitude];
}
-(NSNumber *) latitude
{
    return [(AELocation*)self.location latitude];
}
-(NSString *) thumbURL
{
    return [(AECategory*)[self.categories anyObject] icon];
}

@end
