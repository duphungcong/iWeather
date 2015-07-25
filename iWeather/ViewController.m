//
//  ViewController.m
//  iWeather
//
//  Created by du phung cong on 7/25/15.
//  Copyright (c) 2015 duphungcong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UIButton *temperature;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *quote;
@property (weak, nonatomic) IBOutlet UILabel *temperatureUnit;

@end

@implementation ViewController
{
    NSArray *quotes;
    NSArray *locations;
    NSArray *photoFiles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    quotes = @[@"Một con ngựa đau cả tàu bỏ cỏ", @"Có công mài sắt có ngày nên kim", @"Chớ thấy sóng cả mà ngã tay chèo", @"Đi một ngày đàng học một sàng khôn", @"Học, học nữa, học mãi"];
    locations = @[@"Sydney, Australia", @"Ha Noi, Viet Nam", @"New York, USA", @"Paris, France"];
    photoFiles = @[@"rain", @"sunny", @"windy", @"thunder"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateWeather:(id)sender {
    int quoteIndex = arc4random_uniform(quotes.count);
    int photoFileIndex = arc4random_uniform(photoFiles.count);
    int locationIndex = arc4random_uniform(locations.count);
    //NSLog(@"%d", quoteIndex);
    self.quote.text = quotes[quoteIndex];
    self.weatherIcon.image = [UIImage imageNamed:photoFiles[photoFileIndex]];
    self.location.text = locations[locationIndex];
    
    float updatedTemperature;
    if([self.temperatureUnit.text isEqual: @"F"]) {
        updatedTemperature = [self convertCelciusToFarenheight: [self getTemperature]];
    }
    else {
        updatedTemperature = [self getTemperature];
    }
    
    NSString* string = [NSString stringWithFormat:@"%2.1f", updatedTemperature];
    [self.temperature setTitle:string forState:UIControlStateNormal];
}

- (IBAction)convertTemperature:(id)sender {
    NSString* buttonTitle = [sender titleForState:UIControlStateNormal];
    float currentTemperature = [buttonTitle floatValue];
    //NSLog(@"%2.1f", currentTemperature);

    float convertedTemperature;
    if([self.temperatureUnit.text  isEqual: @"C"]) {
        convertedTemperature = [self convertCelciusToFarenheight:currentTemperature];
        self.temperatureUnit.text = @"F";
    }
    else {
         convertedTemperature = [self convertFarenheightToCelcius:currentTemperature];
        self.temperatureUnit.text = @"C";
    }
    
    NSString* string = [NSString stringWithFormat:@"%2.1f", convertedTemperature];
    [self.temperature setTitle:string forState:UIControlStateNormal];
    
}

- (float) getTemperature {
    return 14.0 + arc4random_uniform(18) + (float)arc4random() / (float)INT32_MAX;
}

- (float) convertCelciusToFarenheight:(float)cTemperature {
    return cTemperature * 1.8 + 32;
}

- (float) convertFarenheightToCelcius:(float)fTemperature {
    return (fTemperature - 32) / 1.8;
}

@end
