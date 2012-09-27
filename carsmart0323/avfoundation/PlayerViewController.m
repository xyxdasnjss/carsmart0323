//
//  PlayerViewController.m
//  carsmart0323
//
//  Created by xyxd on 12-4-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface PlayerViewController ()

@end

@implementation PlayerViewController

//-(void)loadView{
//    
//    NSLog(@"loadView");
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"viewDidLoad");
    
    NSError *err;
    
    player = [ [ AVAudioPlayer alloc ]
              initWithContentsOfURL: [ NSURL fileURLWithPath: [ [ NSBundle mainBundle ] pathForResource: @"dadada" ofType:@"mp3" ] ]
              error: &err
              ];		
    
    if (err)
        NSLog(@"Failed to initialize AVAudioPlayer: %@\n", err);
    
   
    player.delegate = self;
    [ player prepareToPlay ];
    
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)playAction:(id)sender {
  
    if (player.isPlaying) {
        
        [player stop];
        
        
    }else {
        [ player play ];
    }


}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
