//
//  AEVenueTableViewCell.m
//  UITableViewCellDatSourceSample
//
//  Created by Amos Elmaliah on 9/2/11.
//  Copyright (c) 2011 UIMUI. All rights reserved.
//

#import "AEVenueTableViewCell.h"
#import "UITableViewCellDataSource.h"

#define USE_SDWebImage 0 // https://github.com/rs/SDWebImage.git

#if USE_SDWebImage
#import "UIImageView+WebCache.h"
#endif

@interface AEVenuCellViewDataSource : NSObject <UITableViewCellDataSource>
@end

@implementation AEVenuCellViewDataSource

-(void)tableViewCell:(UITableViewCell*)anyCell didChangeItem:(NSObject<UITableViewCellDataSource>*)anyItem
{
    if ([anyItem conformsToProtocol:@protocol(AEVenueItem)] &&
        [anyCell isKindOfClass:[AEVenueTableViewCell class]]
        )
    {
        NSObject<AEVenueItem>* item = (NSObject<AEVenueItem>*)anyItem;
        
        NSString* venueName = item.venueName;
        NSString* streetAddress = item.streetAddress;

        AEVenueTableViewCell* cell = (AEVenueTableViewCell*)anyCell;
        
#if USE_SDWebImage
        NSURL* imageURL = [NSURL URLWithString:item.thumbURL];
        [cell.venueImageView setImageWithURL:imageURL];
#endif
        cell.venueNameLabel.text = venueName;
        cell.venueStreetAddressLabel.text = streetAddress;
        [cell setNeedsLayout];
    }
}

@end

@implementation AEVenueTableViewCell

@synthesize dataSource=_dataSource;
@synthesize item=_item;

@synthesize venueImageView;
@synthesize venueNameLabel;

@synthesize venueStreetAddressLabel;
@synthesize venueOtherAddressLabel;

@synthesize venuePhoneNumberButton;

#if USE_CELL_TYPES
@dynamic cellType;
#endif

-(void)configureStyle
{
    self.opaque = YES;
    
#if USE_CELL_TYPES
    self.cellType = GrouppedTableCellViewTypeTop;
#endif
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configureStyle];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureStyle];
    }
    return self;
}

-(void)createDataSource
{
    self.dataSource = [[AEVenuCellViewDataSource alloc] init];
}

#if USE_CELL_TYPES
-(void)setCellType:(GrouppedTableCellViewType)cellType
{
    
    if (_cellType == cellType) return;
    _cellType = cellType;
    
    UIImage* image = nil;
    switch (_cellType)
    {
        case GrouppedTableCellViewTypeTop:
            image = [UIImage imageNamed:@"CellHead.png"];
            break;
        case GrouppedTableCellViewTypeMid:
            image = [UIImage imageNamed:@"CellCntr.png"];
            break;
        case GrouppedTableCellViewTypeBottom:
            image = [UIImage imageNamed:@"CellBtm.png"];
            break;
        case GrouppedTableCellViewTypeSingle:
            image = [UIImage imageNamed:@"SingleCell.png"];
            break;
        default:
        case GrouppedTableCellViewTypeNone:
            break;
    }
    
    if (!self.backgroundView && image)
        self.backgroundView = [[[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, self.bounds.size.height)] autorelease];
    
    [(UIImageView*)self.backgroundView setImage:image];
}
#endif

-(void)setItem:(NSObject<AEVenueItem> *)item
{
    if (!self.dataSource)
        [self createDataSource];
    [[self dataSource] tableViewCell:self didChangeItem:item];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    /*
     // Code to adjust the distance label right next to the address.
     CGRect labelFrame = self.restaurantAddress.frame;
     CGSize constraintSize = CGSizeMake(260.0f, MAXFLOAT);
     // This step checks how tall the label would be with the desired font.
     CGSize labelSize = [self.restaurantAddress.text sizeWithFont:[UIFont systemFontOfSize:12.0] 
     constrainedToSize:constraintSize 
     lineBreakMode:UILineBreakModeWordWrap];
     
     labelSize.width = MAX(labelSize.width, 100.0);
     labelFrame.size = labelSize;
     
     self.restaurantAddress.frame = labelFrame;
     
     
     CGRect distanceLabelFrame = self.distance.frame;
     distanceLabelFrame.origin.x = labelFrame.origin.x+labelFrame.size.width + 5.0;
     self.distance.frame  = distanceLabelFrame;
     */
}

@end
