#import "ViewController.h"
#import "ImageTargetsViewController.h"


@interface ViewController ()

@property BOOL launchedCamera;

@end

@implementation ViewController


-(id)initWithFileName:(NSString *)fileName targetNames:(NSArray *)imageTargetNames overlayOptions:( NSDictionary *)overlayOptions vuforiaLicenseKey:(NSString *)vuforiaLicenseKey {

    self = [super init];
    self.imageTargets = [[NSDictionary alloc] initWithObjectsAndKeys: fileName, @"imageTargetFile", imageTargetNames, @"imageTargetNames", nil];
    self.overlayOptions = overlayOptions;
    self.vuforiaLicenseKey = vuforiaLicenseKey;
    NSLog(@"Vuforia Plugin :: initWithFileName: %@", fileName);
    NSLog(@"Vuforia Plugin :: overlayOptions: %@", self.overlayOptions);
    NSLog(@"Vuforia Plugin :: License key: %@", self.vuforiaLicenseKey);
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];

    NSLog(@"Vuforia Plugin :: viewController did load");
    self.launchedCamera = false;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (self.launchedCamera == false) {
        ImageTargetsViewController *vc = [[ImageTargetsViewController alloc]  initWithOverlayOptions:self.overlayOptions vuforiaLicenseKey:self.vuforiaLicenseKey];
        self.launchedCamera = true;

        vc.imageTargetFile = [self.imageTargets objectForKey:@"imageTargetFile"];
        vc.imageTargetNames = [self.imageTargets objectForKey:@"imageTargetNames"];

        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissMe {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CameraHasFound" object:self];
}

@end
