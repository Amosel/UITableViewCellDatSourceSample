//
//  AEVenueTableViewCell.h
//  UITableViewCellDatSourceSample
//
//  Created by Amos Elmaliah on 9/2/11.
//  Copyright (c) 2011 UIMUI. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AEVenueItem <NSObject>
@property (nonatomic, copy, readonly) NSString *venueName;
@property (nonatomic, copy, readonly) NSString *venueAddress;
@property (nonatomic, copy, readonly) NSString *streetAddress;
@property (nonatomic, retain, readonly) NSNumber * longitude;
@property (nonatomic, retain, readonly) NSNumber * latitude;
@property (nonatomic, retain, readonly) NSString * thumbURL;
@end


@protocol UITableViewCellDataSource;
#define USE_CELL_TYPES 0
#if USE_CELL_TYPES
typedef enum GrouppedTableCellViewType{
    GrouppedTableCellViewTypeNone,
    GrouppedTableCellViewTypeTop,
    GrouppedTableCellViewTypeMid,
    GrouppedTableCellViewTypeBottom,
    GrouppedTableCellViewTypeSingle
}GrouppedTableCellViewType;
#endif

@interface AEVenueTableViewCell : UITableViewCell {
    
	id<UITableViewCellDataSource>_dataSource;
    NSObject<AEVenueItem>* _item;
#if USE_CELL_TYPES
    GrouppedTableCellViewType _cellType;
#endif
    
    IBOutlet UIImageView    *venueImageView;
	IBOutlet UILabel        *venueNameLabel;
	IBOutlet UILabel        *venueStreetAddressLabel;
	IBOutlet UILabel        *venueOtherAddressLabel;
	IBOutlet UIButton       *venuePhoneNumberButton;
}

@property(nonatomic, strong)id<UITableViewCellDataSource>dataSource;
@property(nonatomic, strong)NSObject<AEVenueItem>* item; // UITableViewCell should not refer internaly to their items, rather use the dataSource to configure them.

@property (nonatomic,retain) UIImageView    *venueImageView;
@property (nonatomic,retain) UILabel        *venueNameLabel;
@property (nonatomic,retain) UILabel        *venueStreetAddressLabel;
@property (nonatomic,retain) UILabel        *venueOtherAddressLabel;

@property (nonatomic,retain) UIButton       *venuePhoneNumberButton;

#if USE_CELL_TYPES
@property (nonatomic)GrouppedTableCellViewType cellType;
#endif

@end
