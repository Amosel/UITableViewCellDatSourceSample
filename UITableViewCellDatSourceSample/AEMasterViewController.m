//
//  AEMasterViewController.m
//  UITableViewCellDatSourceSample
//
//  Created by Amos Elmaliah on 9/2/11.
//  Copyright (c) 2011 UIMUI. All rights reserved.
//

#import "AEMasterViewController.h"

#import "AEDetailViewController.h"
#import "AEVenueTableViewCell.h"

@interface AEMasterViewController (UITableView)
@end

@implementation AEMasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize items=_items;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
        }
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self respondsToSelector:@selector(loadObjectsFromModel)]) 
        [self performSelector:@selector(loadObjectsFromModel)];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(AEVenueTableViewCell *)venueCellFromNib
{
    AEVenueTableViewCell * result = nil;
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"AEVenueTableCellView" owner:nil options:nil];
    
    for(id currentObject in topLevelObjects)
    {
        if([currentObject isKindOfClass:[AEVenueTableViewCell class]])
        {
            result = (AEVenueTableViewCell *)currentObject;
            break;
        }
    }
    return result;
}

@end

//#import "CoreData+MagicalRecord.h"
#import "AEVenue.h"
#import "AECategory.h"
#import "AELocation.h"
#import "NSManagedObject+MagicalRecord.h"

@implementation AEMasterViewController (Model)

-(void)modelDidLoad
{
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"AEVenue"];    
    NSSortDescriptor* descriptor = [NSSortDescriptor sortDescriptorWithKey:@"id" ascending:NO];
	[request setSortDescriptors:[NSArray arrayWithObject:descriptor]];
    
    _items = [AEVenue executeFetchRequest:request];
    [self.tableView reloadData];
}

-(void)loadObjectsFromModel
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"file.plist" ofType:nil];
    NSDictionary* dict = [[NSDictionary alloc] initWithContentsOfFile:path];
        
    [MagicalRecordHelpers setupCoreDataStack];
    
    for (NSDictionary* venueWrapperDict in [[[dict objectForKey:@"response"] objectForKey:@"venues"] objectForKey:@"items"])
    {
        NSDictionary* venueDict = [venueWrapperDict objectForKey:@"venue"];
        AEVenue*venue = [AEVenue createEntity];
        
        venue.id = [NSNumber numberWithLongLong:[[venueDict objectForKey:@"id"] longLongValue]];
        venue.name = [venueDict objectForKey:@"name"];
        NSArray* cateogries = [venueDict objectForKey:@"categories"];
        if (cateogries)
        {
            for (NSDictionary*catDict in cateogries)
            {
                AECategory* cat = [AECategory createEntity];
                cat.shortName = [catDict objectForKey:@"shortName"];
                cat.id = [NSNumber numberWithLongLong:[[venueDict objectForKey:@"id"] longLongValue]];
                cat.icon = [catDict objectForKey:@"icon"];
                [venue addCategoriesObject:cat];
            }
        }
        NSDictionary* locationDict = [venueDict objectForKey:@"location"];
        if (locationDict)
        {
            AELocation* location = [AELocation createEntity];
            location.address = [locationDict objectForKey:@"address"];
            location.city = [locationDict objectForKey:@"city"];
            location.country = [locationDict objectForKey:@"country"];
            location.latitude = [locationDict objectForKey:@"lat"];
            location.longitude = [locationDict objectForKey:@"lng"];
            
            [venue setLocation:location];
        }
    }
    
    [self modelDidLoad];
}

@end

@implementation AEMasterViewController (UITableView)

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_items count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    AEVenueTableViewCell *cell = (AEVenueTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [self venueCellFromNib];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    cell.item = [_items objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    if (!self.detailViewController) {
	        self.detailViewController = [[AEDetailViewController alloc] initWithNibName:@"AEDetailViewController_iPhone" bundle:nil];
	    }
        NSManagedObject *selectedObject = [_items objectAtIndex:indexPath.row];
        self.detailViewController.detailItem = selectedObject;    
        [self.navigationController pushViewController:self.detailViewController animated:YES];
    } else {
        NSManagedObject *selectedObject = [_items objectAtIndex:indexPath.row];
        self.detailViewController.detailItem = selectedObject;    
    }
}

@end