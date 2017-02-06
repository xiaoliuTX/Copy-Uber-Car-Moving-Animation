//
//  DuMapBusAnnotationView.m
//  Dudubashi
//
//  Created by naiveBoy on 2017/1/11.
//  Copyright © 2017年 LTB. All rights reserved.
//

#import "MapBusAnnotationView.h"

@implementation MapBusAnnotationView

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self =  [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.masksToBounds = NO;
    }
    
    return self;
}
@end
