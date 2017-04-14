//
//  ViewController.m
//  testMap
//
//  Created by wp on 2017/2/20.
//  Copyright © 2017年 wp. All rights reserved.
//

#import "ViewController.h"
#import <ArcGIS/ArcGIS.h>
#import "NetWorkData.h"
#import "BViewController.h"
#define UIColorFromHex(s)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]

@interface ViewController ()<AGSMapViewLayerDelegate,AGSQueryTaskDelegate,AGSMapViewTouchDelegate>
{
   
    BOOL isShowName;
    BOOL isShowFanwei;
    BOOL isShowQiyeLine;

    AGSDynamicMapServiceLayer *layerBengzhan;
    
    NSMutableArray *selectedMapPoints;

//    NSMutableArray *selectedMapPoints;
    
    
}
@property (strong, nonatomic) AGSMapView *mapView;
@property(nonatomic,strong)AGSGraphicsLayer *drawLineLayer;


@property (nonatomic, strong)  AGSEnvelope *fullEnv;



@end

@implementation ViewController


-(void)viewWillAppear:(BOOL)animated{

    if ([NetWorkData shareData].mapView&&[NetWorkData shareData].mapView.superview) {
        
        self.mapView=[NetWorkData shareData].mapView;
        [self.view addSubview:self.mapView];
    }
    
//    AGSPoint *newPoint = [AGSPoint pointWithX:self.mapView.visibleArea.envelope.center.x y:self.mapView.visibleArea.envelope.center.y spatialReference:self.mapView.spatialReference];
//    [self.mapView centerAtPoint:newPoint animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];



     selectedMapPoints = [[NSMutableArray alloc] init];
    
    self.mapView=[[AGSMapView alloc] initWithFrame:CGRectMake(20, 100, 320, 300)];
//    [self.view addSubview:self.mapView];
    self.mapView.touchDelegate=self;
    self.mapView.layerDelegate=self;
 
   
   
    
    [self LoadMap];


    
    self.drawLineLayer = [AGSGraphicsLayer graphicsLayer];
    [self.mapView addMapLayer:self.drawLineLayer withName:@"DrawLineLayer"];
    
    /* ##################################################### */

    [NetWorkData shareData].mapView=self.mapView;

    
    
 
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)mapView:(AGSMapView *)mapView didClickAtPoint:(CGPoint)screen mapPoint:(AGSPoint *)mappoint graphics:(NSDictionary *)graphics{

    
    
    AGSPoint* myMarkerPoint = [AGSPoint pointWithX:-100 y:50 spatialReference:self.mapView.spatialReference];
    
    
    
    AGSSimpleMarkerSymbol* myMarkerSymbol = [AGSSimpleMarkerSymbol simpleMarkerSymbol];
    myMarkerSymbol.color = [UIColor redColor];
    myMarkerSymbol.style = AGSSimpleMarkerSymbolStyleCircle;
    myMarkerSymbol.outline.color = [UIColor redColor];
    myMarkerSymbol.outline.width = 1;
    myMarkerSymbol.size=CGSizeMake(2, 2);
    NSLog(@"mappoint is %@", mappoint);
    AGSGraphic *pointGraphic = [[AGSGraphic alloc] initWithGeometry:mappoint symbol:myMarkerSymbol attributes:nil infoTemplateDelegate:nil];
    [self.drawLineLayer addGraphic:pointGraphic];
//
//    
//    
    AGSTextSymbol* txtSymbol = [AGSTextSymbol textSymbolWithText:@"11" color:[UIColor greenColor]];
//    txtSymbol. = -30.;
//    txtSymbol.yoffset = 30.;
    txtSymbol.fontSize = 10;
    txtSymbol.text=@"98797";
    txtSymbol.offset=CGPointMake(0, -10);
    AGSGraphic *pointGraphic1 = [[AGSGraphic alloc] initWithGeometry:[AGSPoint pointWithX:mappoint.x y:mappoint.y spatialReference:mapView.spatialReference]symbol:txtSymbol attributes:nil infoTemplateDelegate:nil];
    [self.drawLineLayer addGraphic:pointGraphic1];

    
//    AGSPictureMarkerSymbol* myPictureSymbol = [AGSPictureMarkerSymbol pictureMarkerSymbolWithImage:[UIImage imageNamed:@"5555.png"]];
//    
//    //向右上方偏移5个像素
//    //
//        AGSGraphic *pointGraphic1 = [[AGSGraphic alloc] initWithGeometry:mappoint symbol:myPictureSymbol attributes:nil infoTemplateDelegate:nil];
//        [self.drawLineLayer addGraphic:pointGraphic1];
    
    
    
    
    
    
//    [selectedMapPoints addObject:mappoint];
//    int count = [selectedMapPoints count];
//    if ( count> 1) {
//        
//        AGSMutablePolyline *polyLine = [[AGSMutablePolyline alloc] initWithSpatialReference:self.mapView.spatialReference];
//        [polyLine addPathToPolyline];
//        for (int i = 0; i < count; i++) {
//            [polyLine addPointToPath:[selectedMapPoints objectAtIndex:i]];
//        }
//
//        AGSSimpleLineSymbol* myOutlineSymbol = [AGSSimpleLineSymbol simpleLineSymbol];
//        myOutlineSymbol.color = [UIColor redColor];
//        myOutlineSymbol.width = 2;
//        myOutlineSymbol.style = AGSSimpleLineSymbolStyleDashDotDot;
//        AGSGraphic *graphic = [[AGSGraphic alloc] initWithGeometry:polyLine
//                                                            symbol:myOutlineSymbol
//                                                        attributes:nil infoTemplateDelegate:nil];
//        
//        [self.drawLineLayer addGraphic:graphic];
//        
//        //}
//    }

}
-(void)LoadMap
{
//    [SVProgressHUD showWithStatus:@"正在加载地图"];
    
    NSURL *urlBengzhan= [NSURL URLWithString:@"http://ysmapservices.sytxmap.com/arcgis/rest/services/New/ZongTu_Wai/MapServer/"];
    layerBengzhan = [AGSDynamicMapServiceLayer dynamicMapServiceLayerWithURL:urlBengzhan];
    NSLog(@"%@",layerBengzhan);
    
//    [self reFreshMapLayer];
    [self.mapView addMapLayer:layerBengzhan withName:@"BengzhanLayer"];
    
    
//    self.graphicsLayer = [AGSGraphicsLayer graphicsLayer];
//    [self.mapView addMapLayer:self.graphicsLayer withName:@"DrawLineLayer"];

    
    
}

- (void) reFreshMapLayer{
    NSMutableArray *layers = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 34; i++) {
        switch (i) {
            
          
                
            case 5:
                if (isShowName) {
                    [layers addObject:[NSNumber numberWithInt:i]];
                    NSLog(@"isShowName%d",i);
                }
                break;
         
            case 19:
                
                break;
            case 20:
                if (isShowQiyeLine) {
                    [layers addObject:[NSNumber numberWithInt:i]];
                    NSLog(@"isShowQiyeLine%d",i);
                }
                break;
        
            case 31:
                if (isShowFanwei) {
                    [layers addObject:[NSNumber numberWithInt:i]];
                     NSLog(@"isShowFanwei%d",i);
                }
                break;
           
           
            default:
                [layers addObject:[NSNumber numberWithInt:i]];
                break;
        }
    }
    NSLog(@"layersssss++++%@",layers);
    layerBengzhan.visibleLayers = layers;
    

    
}

- (IBAction)yuanqu:(id)sender {
    isShowQiyeLine=NO;
    isShowFanwei=NO;
    isShowName=YES;
    [self reFreshMapLayer];
//    NSMutableArray *layers = [NSMutableArray arrayWithArray:layerBengzhan.visibleLayers];
////    [layers removeObject:@39];
//    [layers addObject:@0];
//    [layers addObject:@1];
//    layerBengzhan.visibleLayers=layers;
//   NSLog(@"laye///888888++++%@",layerBengzhan.visibleLayers);
    
}
- (IBAction)qiyehongxian:(id)sender {
//    isShowQiyeLine=YES;
//    isShowFanwei=NO;
//    [self reFreshMapLayer];
//    [self.drawLineLayer removeAllGraphics];
    BViewController * b =[[BViewController alloc] init];
    [self.navigationController pushViewController:b animated:YES];
}
- (IBAction)quanbu:(id)sender {
    isShowQiyeLine=NO;
    isShowFanwei=NO;
    isShowName=NO;
    [self reFreshMapLayer];

//    NSArray *xArray=[NSArray arrayWithObjects:@"41520868.639053",@"41522468.808030",@"41522180.777614", nil];
//    NSArray *yArray=[NSArray arrayWithObjects:@"4626327.728237",@"4625655.657266",@"4623543.434216", nil];
//    
//    
//    AGSMutablePolyline *polyLine = [[AGSMutablePolyline alloc] initWithSpatialReference:self.mapView.spatialReference];
//    [polyLine addPathToPolyline];
//    
//    for (int i=0; i<3; i++) {
//        AGSPoint* myMarkerPoint = [AGSPoint pointWithX:[xArray[i] floatValue] y:[yArray[i] floatValue] spatialReference:self.mapView.spatialReference];
//        
//        
//        
////        AGSSimpleMarkerSymbol* myMarkerSymbol = [AGSSimpleMarkerSymbol simpleMarkerSymbol];
////        myMarkerSymbol.color = [UIColor clearColor];
//////        myMarkerSymbol.style = AGSSimpleMarkerSymbolStyleX;
////        myMarkerSymbol.outline.color = [UIColor whiteColor];
////        myMarkerSymbol.outline.width = 1;
////        myMarkerSymbol.outline.style=AGSSimpleLineSymbolStyleDot;
////        NSLog(@"mappoint is %@", myMarkerPoint);
//        AGSGraphic *pointGraphic = [[AGSGraphic alloc] initWithGeometry:myMarkerPoint symbol:nil attributes:nil infoTemplateDelegate:nil];
//        [self.drawLineLayer addGraphic:pointGraphic];
//        
//         [polyLine addPointToPath:myMarkerPoint];
//
//        
//    }
//    
//
//    
//        AGSSimpleLineSymbol* myOutlineSymbol = [AGSSimpleLineSymbol simpleLineSymbol];
//        myOutlineSymbol.color = [UIColor redColor];
//        myOutlineSymbol.width = 1;
//        myOutlineSymbol.style = AGSSimpleLineSymbolStyleInsideFrame;
//        AGSGraphic *graphic = [[AGSGraphic alloc] initWithGeometry:polyLine
//                                                            symbol:myOutlineSymbol
//                                                        attributes:nil infoTemplateDelegate:nil];
//        
//        [self.drawLineLayer addGraphic:graphic];
    
        //}
//    }


}

-(void) mapViewDidLoad:(AGSMapView *)mapView{
    self.fullEnv = [[AGSEnvelope alloc] initWithXmin:41508571.340459 ymin:4602901.254403 xmax:41528301.423954 ymax:4637976.958395 spatialReference:[[AGSSpatialReference alloc] initWithWKID:2365 WKT:nil]];; //self.mapView.visibleArea.envelope;
    NSLog(@"FullEnv=%@",self.fullEnv);
   
   
    
    [self gotoDefaultSize];
    
}


- (void) gotoDefaultSize{

    NSLog(@"%@", self.mapView.visibleAreaEnvelope.envelope);

    [self.mapView zoomToEnvelope:self.fullEnv animated:YES];
    //    self.mapView.visibleArea.envelope;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
