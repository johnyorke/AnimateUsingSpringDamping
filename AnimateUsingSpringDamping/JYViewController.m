//
//  JYViewController.m
//  AnimateUsingSpringDamping
//
//  Created by John Yorke on 20/11/2013.
//  Copyright (c) 2013 John Yorke. All rights reserved.
//

#import "JYViewController.h"

@interface JYViewController ()
@property (strong, nonatomic) IBOutlet UISlider *durationSlider;
@property (strong, nonatomic) IBOutlet UISlider *springDampingSlider;
@property (strong, nonatomic) IBOutlet UISlider *springVelocitySlider;
@property (strong, nonatomic) IBOutlet UISegmentedControl *optionsSegmentedControl;
@property (strong, nonatomic) IBOutlet UIImageView *alertView;

@property (strong, nonatomic) NSNumber *duration;
@property (strong, nonatomic) NSNumber *damping;
@property (strong, nonatomic) NSNumber *velocity;

@property (strong, nonatomic) IBOutlet UILabel *durationLabel;
@property (strong, nonatomic) IBOutlet UILabel *dampingLabel;
@property (strong, nonatomic) IBOutlet UILabel *velocityLabel;


@property CGPoint alertDefaultPosition;

@end

@implementation JYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.alertDefaultPosition = self.alertView.center;
    
    // Initial animation with default values
    [self animateAlert];
    
    // Add tap GR to the alert in order to trigger an animation
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(animateAlert)];
    [self.alertView addGestureRecognizer:tap];
    
    // Update the value labels whenever slider values are changed
    [self.durationSlider addTarget:self action:@selector(updateLabels) forControlEvents:UIControlEventValueChanged];
    [self.springDampingSlider addTarget:self action:@selector(updateLabels) forControlEvents:UIControlEventValueChanged];
    [self.springVelocitySlider addTarget:self action:@selector(updateLabels) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) animateAlert
{
    
    // Set the parameters to be passed into the animation
    self.duration = [NSNumber numberWithFloat:self.durationSlider.value];
    self.damping = [NSNumber numberWithFloat:self.springDampingSlider.value];
    self.velocity = [NSNumber numberWithFloat:self.springVelocitySlider.value];
    
    // int to hold UIViewAnimationOption
    NSInteger option;
    // Set the option value
    if (self.optionsSegmentedControl.selectedSegmentIndex == 0) {
        option = UIViewAnimationOptionCurveEaseIn;
    } else if (self.optionsSegmentedControl.selectedSegmentIndex == 1){
        option = UIViewAnimationCurveEaseOut;
    } else if (self.optionsSegmentedControl.selectedSegmentIndex == 2){
        option = UIViewAnimationCurveEaseInOut;
    } else {
        option = UIViewAnimationCurveLinear;
    }
    
    // Get the alert just off the screen
    [self moveAlertOffScreen];
    
    //Animate using values from sliders and segementedControl
    [UIView animateWithDuration:[self.duration floatValue] delay:0 usingSpringWithDamping:[self.damping floatValue] initialSpringVelocity:[self.velocity floatValue] options:option animations:^{
        self.alertView.center = self.alertDefaultPosition;
    }completion:nil];
}

- (void) moveAlertOffScreen
{
    // Get the alert just off screen
    self.alertView.center = CGPointMake(self.alertView.center.x, self.alertView.center.y - [UIScreen mainScreen].bounds.size.height / 2);
}

- (void) updateLabels
{
    // Update the labels above each slider
    self.durationLabel.text = [NSString stringWithFormat:@"%.1f",self.durationSlider.value];
    self.dampingLabel.text = [NSString stringWithFormat:@"%.1f",self.springDampingSlider.value];
    self.velocityLabel.text = [NSString stringWithFormat:@"%.1f",self.springVelocitySlider.value];
}


- (BOOL) prefersStatusBarHidden
{
    return YES;
}

@end
