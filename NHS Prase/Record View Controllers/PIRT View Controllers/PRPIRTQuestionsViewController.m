//
//  PRPIRTQuestionsViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 02/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRPIRTQuestionsViewController.h"

#import "PROptionCollectionViewCell.h"

@interface PRPIRTQuestionsViewController ()

@end

@implementation PRPIRTQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == q1CV) {
        return 10;
    }
    
    if (collectionView == q2CV) {
        return 5;
    }
    
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == q1CV) {
        PROptionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NumberCell" forIndexPath:indexPath];
        [cell setOptionTitle:[@(indexPath.row + 1) stringValue] image:nil andSecondImage:nil];
        return cell;
    }
    
    if (collectionView == q2CV) {
        NSArray *titles = @[@"Defintely not",
                            @"Probably not",
                            @"Probably yes",
                            @"Definitely yes",
                            @"Don't know"];
        
        NSString *title = titles[indexPath.row];
        NSString *identifier = (indexPath.row == 0 || indexPath.row == 3) ? @"OptionCell2" : @"OptionCell";
        PROptionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        switch (indexPath.row) {
            case 0:
                [cell setOptionTitle:title image:[UIImage imageNamed:@"cross"] andSecondImage:[UIImage imageNamed:@"cross"]];
                break;
            case 1:
                [cell setOptionTitle:title image:[UIImage imageNamed:@"cross"] andSecondImage:nil];
                break;
            case 2:
                [cell setOptionTitle:title image:[UIImage imageNamed:@"tick"] andSecondImage:nil];
                break;
            case 3:
                [cell setOptionTitle:title image:[UIImage imageNamed:@"tick"] andSecondImage:[UIImage imageNamed:@"tick"]];
                break;
            case 4:
                [cell setOptionTitle:title image:[UIImage imageNamed:@"question"] andSecondImage:nil];
                break;
            default:
                break;
        }
        
        return cell;
    }
    
    return nil;
}

#pragma mark - IBActions



@end
