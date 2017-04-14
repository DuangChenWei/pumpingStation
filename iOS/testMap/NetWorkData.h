//
//  NetWorkData.h
//  textNSURLSession
//
//  Created by cw on 16/3/29.
//  Copyright © 2016年 Chen Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <ArcGIS/ArcGIS.h>
@interface NetWorkData : NSObject<NSURLSessionDataDelegate>
+(NetWorkData *)shareData;
@property(nonatomic,strong)NSURLSession *session;
- (void)GETMethod:(NSString *)URLString
                           parameters:(id)parameters
                              success:(void (^)( id responseObject))success
                              failure:(void (^)( NSError *error))failure;


-(void)PostMethod:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

-(NSDictionary *)getTTTTTTTT:(NSString *)URLString;

@property(nonatomic,strong)NSDictionary *dataDic;








@property (strong, nonatomic)AGSMapView *mapView;
@property(nonatomic,strong)AGSGraphicsLayer *drawLineLayer;

@property (nonatomic, strong)  AGSQueryTask *queryTask;
@property (nonatomic, strong)  AGSQuery *query;
@property (nonatomic, strong)  AGSFeatureSet *featureSet;
@property (nonatomic, strong)  AGSEnvelope *fullEnv;
@property (nonatomic, strong) AGSDynamicMapServiceLayer *layerBengzhan;


@end
