//
//  PlayerViewController.h
//  carsmart0323
//
//  Created by xyxd on 12-4-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayerViewController : UIViewController<AVAudioPlayerDelegate>{
    
    AVAudioPlayer *player;
}

@end
