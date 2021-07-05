#import "AuthViewController.h"

@interface AuthViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *authorizeButton;

@property (weak, nonatomic) IBOutlet UIView *pinView;
@property (weak, nonatomic) IBOutlet UILabel *pinLabel;
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdButton;

@end

@implementation AuthViewController

// MARK: - Colors

NSString *whiteHex = @"FFFFFF";
NSString *blackCoralHex = @"4C5C68";
NSString *turquoiseGreenHex = @"91C7B1";
NSString *venetianRedHex = @"C20114";
NSString *blackHex = @"000000";
NSString *littleBoyBlueHex = @"80A4ED";
NSString *littleBoyBlueAlphaHex = @"80A4ED33";

// MARK: - Correct Constants

NSString *loginConstant = @"username";
NSString *passwordConstant = @"password";
NSString *pinConstant = @"1 2 3 ";
NSString *emptyPinConstant = @"_";

- (void)viewDidLoad
{
    [super viewDidLoad];

	[self configureDefaultState];

	UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
																			  action:@selector(handleTap)];
	[self.view addGestureRecognizer:gesture];
}

- (void)configureDefaultState
{
	self.view.backgroundColor = [self colorFromHexCode:whiteHex];

	_loginTextField.layer.borderColor = [[self colorFromHexCode:blackCoralHex] CGColor];
	_loginTextField.layer.borderWidth = 1.5;
	_loginTextField.layer.cornerRadius = 5;
	_loginTextField.delegate = self;
	_loginTextField.alpha = 1;
	_loginTextField.userInteractionEnabled = YES;
	_loginTextField.text = @"";

	_passwordTextField.layer.borderColor = [[self colorFromHexCode:blackCoralHex] CGColor];
	_passwordTextField.layer.borderWidth = 1.5;
	_passwordTextField.layer.cornerRadius = 5;
	_passwordTextField.delegate = self;
	_passwordTextField.alpha = 1;
	_passwordTextField.userInteractionEnabled = YES;
	_passwordTextField.text = @"";

	_authorizeButton.layer.borderColor = [[self colorFromHexCode:littleBoyBlueHex] CGColor];
	_authorizeButton.layer.borderWidth = 2;
	_authorizeButton.layer.cornerRadius = 10;
	_authorizeButton.alpha = 1;
	_authorizeButton.userInteractionEnabled = YES;

	[_pinView setAlpha:0];
	_pinView.layer.borderWidth = 2;
	_pinView.layer.cornerRadius = 10;
	_pinView.layer.borderColor = [[self colorFromHexCode:whiteHex] CGColor];
	_pinLabel.text = @"_";

	_firstButton.layer.cornerRadius = 25;
	_firstButton.layer.borderWidth = 1.5;
	_firstButton.layer.borderColor = [[self colorFromHexCode:littleBoyBlueHex] CGColor];

	_secondButton.layer.cornerRadius = 25;
	_secondButton.layer.borderWidth = 1.5;
	_secondButton.layer.borderColor = [[self colorFromHexCode:littleBoyBlueHex] CGColor];

	_thirdButton.layer.cornerRadius = 25;
	_thirdButton.layer.borderWidth = 1.5;
	_thirdButton.layer.borderColor = [[self colorFromHexCode:littleBoyBlueHex] CGColor];
}

- (void)firstStepComplete
{
	_loginTextField.alpha = 0.5;
	_loginTextField.userInteractionEnabled = NO;
	_passwordTextField.alpha = 0.5;
	_passwordTextField.userInteractionEnabled = NO;
	_authorizeButton.alpha = 0.5;
	_authorizeButton.userInteractionEnabled = NO;

	[_pinView setAlpha:1];
}

// MARK: - Actions

- (IBAction)authTouchDown:(id)sender
{
	_authorizeButton.backgroundColor = [self colorFromHexCode:littleBoyBlueAlphaHex];
}

- (IBAction)authTouchUp:(id)sender
{
	_authorizeButton.backgroundColor = [self colorFromHexCode:whiteHex];

	BOOL isSuccessLogin = [_loginTextField.text isEqualToString:loginConstant];
	NSString *loginHex = isSuccessLogin ? turquoiseGreenHex : venetianRedHex;
	_loginTextField.layer.borderColor = [[self colorFromHexCode:loginHex] CGColor];

	BOOL isSuccessPassword = [_passwordTextField.text isEqualToString:passwordConstant];
	NSString *passwordHex = isSuccessPassword ? turquoiseGreenHex : venetianRedHex;
	_passwordTextField.layer.borderColor = [[self colorFromHexCode:passwordHex] CGColor];

	if (isSuccessLogin && isSuccessPassword)
	{
		[self firstStepComplete];
	}
}

- (IBAction)numTouchDown:(UIButton *)sender
{
	sender.backgroundColor = [self colorFromHexCode:littleBoyBlueAlphaHex];
}

- (IBAction)numTouchUp:(UIButton *)sender
{
	sender.backgroundColor = [self colorFromHexCode:whiteHex];
	NSString *numString = [sender.titleLabel.text stringByAppendingString:@" "];

	if ([_pinLabel.text isEqualToString:emptyPinConstant])
	{
		_pinLabel.text = numString;
	}
	else
	{
		_pinLabel.text = [_pinLabel.text stringByAppendingString:numString];
	}

	if (_pinLabel.text.length == 6)
	{
		BOOL isSuccess = [_pinLabel.text isEqualToString:pinConstant];
		NSString *hex = isSuccess ? turquoiseGreenHex : venetianRedHex;
		_pinView.layer.borderColor = [[self colorFromHexCode:hex] CGColor];

		if (isSuccess)
		{
			[self authComplete];
		}
		else
		{
			_pinLabel.text = emptyPinConstant;
		}
	}
}

- (void)handleTap
{
	[self.view endEditing:YES];
}

// MARK: - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	textField.layer.borderColor = [[self colorFromHexCode:blackCoralHex] CGColor];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self.view endEditing:YES];
	return YES;
}


// MARK: - Helpers

- (UIColor *)colorFromHexCode:(NSString *)hexString
{
	NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
	if([cleanString length] == 3) {
		cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
						[cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
						[cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
						[cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
	}
	if([cleanString length] == 6) {
		cleanString = [cleanString stringByAppendingString:@"ff"];
	}

	unsigned int baseValue;
	[[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];

	float red = ((baseValue >> 24) & 0xFF)/255.0f;
	float green = ((baseValue >> 16) & 0xFF)/255.0f;
	float blue = ((baseValue >> 8) & 0xFF)/255.0f;
	float alpha = ((baseValue >> 0) & 0xFF)/255.0f;

	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (void)authComplete
{
	 UIAlertController * alert = [UIAlertController
								 alertControllerWithTitle:@"Welcome"
								 message:@"You are successfuly authorized!"
								 preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction* refreshButton = [UIAlertAction
								actionWithTitle:@"Refresh"
								style:UIAlertActionStyleDestructive
								handler:^(UIAlertAction * action) {
									[self configureDefaultState];
								}];

	[alert addAction:refreshButton];

	[self presentViewController:alert animated:YES completion:nil];
}

@end
