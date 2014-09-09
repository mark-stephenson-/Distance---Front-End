//
//  PRQuestionOptionsViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRQuestionOptionsViewController.h"

#import <TheDistanceKit/TheDistanceKit.h>

#import "PRTheme.h"
#import "PRQuestionOptions.h"
#import "PROptionCollectionViewCell.h"

@interface PRQuestionOptionsViewController ()

@end

@implementation PRQuestionOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    titleLabel.text = [NSString stringWithFormat:@"Q%ld: %@", self.questionIndex + 1, optionsQuestion.questionTitle];
    
    if ([self.question.answer isKindOfClass:[NSIndexPath class]]) {
        NSIndexPath *selected = self.question.answer;
        [self.collectionView selectItemAtIndexPath:selected animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
}

-(void)setQuestion:(PRQuestion *)question
{
    if ([question isKindOfClass:[PRQuestionOptions class]]) {
        [super setQuestion:question];
        optionsQuestion = (PRQuestionOptions *) question;
        
        titleLabel.text = [NSString stringWithFormat:@"Q%ld: %@", self.questionIndex + 1, optionsQuestion.questionTitle];
        
        [self.collectionView reloadData];
    }
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    collectionViewWidthConstraint.constant = self.collectionView.contentSize.width;
}

#pragma mark - CollectionView DataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (optionsQuestion.showsNA) {
        return 2;
    }
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 1) {
        // two cells for NA and prefer not to answer
        return 2;
    } else {
        return optionsQuestion.options.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PROptionCollectionViewCell *optionCell = nil;
    
    if (indexPath.section == 1) {
        optionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OptionCell" forIndexPath:indexPath];
        
        NSString *title = nil;
        UIImage *image = nil;
        switch (indexPath.row) {
            case 0:
                title = @"Not Applicable";
                image = [UIImage imageNamed:@"n_a"];
                break;
            case 1:
                title = @"Prefer not to answer";
                break;
            default:
                break;
        }
        
        [optionCell setOptionTitle:title image:image andSecondImage:nil];
    } else {
        
        NSDictionary *thisOption = optionsQuestion.options[indexPath.row];
        
        NSString *identifier = @"OptionCell";
        if (thisOption[@"image2"] != nil) {
            identifier = @"OptionCell2";
        }
        
        optionCell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        if (thisOption[@"imageTint"]) {
            //NSLog(@"tint col: %@", thisOption[@"imageTint"]);
            optionCell.imageTintColor = thisOption[@"imageTint"];
        }
        [optionCell setOptionTitle:thisOption[@"title"] image:thisOption[@"image"] andSecondImage:thisOption[@"image2"]];
    }
    
    if ([self.question.answer isKindOfClass:[NSIndexPath class]]) {
        NSIndexPath *selectedPath = self.question.answer;
        
        if (indexPath.row == selectedPath.row && indexPath.section == selectedPath.section) {
            
            optionCell.tintColor = [[PRTheme sharedTheme] mainColor];
            [optionCell setSelected:YES];
            [optionCell layoutSubviews];
        }
    }
    
    [self applyThemeToView:optionCell];
    
    
    return optionCell;
}

#pragma mark - Collection Delegate

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"Selecting: %@", indexPath);
    NSArray *currentSelections = [collectionView indexPathsForSelectedItems];
    // NSLog(@"Selections: %@", currentSelections);
    
    for (NSIndexPath *selected in currentSelections) {
        if ([indexPath isEqual:selected]) {
            [collectionView deselectItemAtIndexPath:indexPath animated:NO];
            return NO;
        }
    }
    
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.question.answer = indexPath;
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.question.answer = nil;
}

@end
