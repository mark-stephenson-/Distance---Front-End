//
//  PRPIRTQuestionsViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 02/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRPIRTQuestionsViewController.h"

#import "PROptionCollectionViewCell.h"
#import "PRTheme.h"

#import "PRQuestion.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord.h>

@interface PRPIRTQuestionsViewController ()

@end

@implementation PRPIRTQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.seriousQuestion == nil) {
        self.seriousQuestion = [PRQuestion MR_createEntity];
    }
    
    if (self.preventQuestion == nil) {
        self.preventQuestion = [PRQuestion MR_createEntity];
    }
    
    if (self.seriousQuestion.answerID) {
        [q1CV selectItemAtIndexPath:[NSIndexPath indexPathForItem:self.seriousQuestion.answerID.integerValue inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
    
    if (self.preventQuestion.answerID) {
        [q2CV selectItemAtIndexPath:[NSIndexPath indexPathForItem:self.preventQuestion.answerID.integerValue inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
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
        
        UIImage *cross = [UIImage imageNamed:@"cross"];
        UIImage *tick = [UIImage imageNamed:@"tick"];
        
        UIColor *positiveColour = [[PRTheme sharedTheme] positiveColor];
        UIColor *negativeColour = [[PRTheme sharedTheme] negativeColor];
        
        NSString *title = titles[indexPath.row];
        NSString *identifier = (indexPath.row == 0 || indexPath.row == 3) ? @"OptionCell2" : @"OptionCell";
        PROptionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        switch (indexPath.row) {
            case 0:
                [cell setOptionTitle:title image:cross andSecondImage:cross];
                [cell setImageTintColor:negativeColour];
                break;
            case 1:
                [cell setOptionTitle:title image:cross andSecondImage:nil];
                [cell setImageTintColor:negativeColour];
                break;
            case 2:
                [cell setOptionTitle:title image:tick andSecondImage:nil];
                [cell setImageTintColor:positiveColour];
                break;
            case 3:
                [cell setOptionTitle:title image:tick andSecondImage:tick];
                [cell setImageTintColor:positiveColour];
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == q1CV) {
        self.seriousQuestion.answerID = @(indexPath.row);
    }
    
    if (collectionView == q2CV) {
        self.preventQuestion.answerID = @(indexPath.row);
    }
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == q1CV) {
        self.seriousQuestion.answerID = nil;
    }
    
    if (collectionView == q2CV) {
        self.preventQuestion.answerID = nil;
    }
}

@end
