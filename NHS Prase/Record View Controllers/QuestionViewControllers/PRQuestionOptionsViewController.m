//
//  PRQuestionOptionsViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRQuestionOptionsViewController.h"

#import <TheDistanceKit/TheDistanceKit.h>

#import <MagicalRecord/CoreData+MagicalRecord.h>

#import "PRRecord.h"
#import "PRAnswerOption.h"

#import "PRTheme.h"
#import "PRQuestion.h"
#import "PROptionCollectionViewCell.h"

@interface PRQuestionOptionsViewController ()

@end

@implementation PRQuestionOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    titleLabel.TDLocalizedStringKey = self.question.questionID;
    
    ((UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout).minimumLineSpacing = 30.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)applyTheme
{
    [super applyTheme];

    NSInteger thisQuestionIndex = [self.question.record.questions indexOfObject:self.question] + 1;

    NSString *formatHeader = [NSString localizedStringWithFormat:TDLocalizedStringWithDefaultValue(@"question.index_header", nil, nil, @"Question %d:", @"The header identifiying the question number of this question in the PMOS questionnaire."), thisQuestionIndex];
    headerLabel.text = formatHeader;
    
    if ([titleLabel.TDLocalizedStringKey isNonNullString]) {
        titleLabel.text = PRLocalizedStringWithDefaultValue(titleLabel.TDLocalizedStringKey, nil, nil, nil, nil);
    }
    
    [self.collectionView.collectionViewLayout invalidateLayout];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self selectAnswer];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)setQuestion:(PRQuestion *)question
{
    [super setQuestion:question];
    
    if (headerLabel != nil) {
        headerLabel.TDLocalizedStringKey = @"question.index_header";
    }
    
    if (titleLabel != nil) {
        titleLabel.TDLocalizedStringKey = self.question.questionID;
    }
    
    if (headerLabel != nil && titleLabel != nil) {
        [self applyTheme];
        [self.collectionView reloadData];
        [self selectAnswer];
    }
}

-(void)selectAnswer
{
    if ([self.question.answerID isNonNullString]) {
        NSIndexPath *selectedPath = [self.question indexPathForAnswerID:self.question.answerID];
        [self.collectionView selectItemAtIndexPath:selectedPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.collectionView.tintColor = [[PRTheme sharedTheme] mainColor];
    
    if (CGSizeEqualToSize(CGSizeZero, oldViewSize) || !CGSizeEqualToSize(self.view.bounds.size, oldViewSize)) {
        [self.collectionView.collectionViewLayout invalidateLayout];
        [self.collectionView.collectionViewLayout prepareLayout];
        
        CGSize collectionSize = [self.collectionView.collectionViewLayout collectionViewContentSize];
        collectionViewWidthConstraint.constant = collectionSize.width;
        collectionViewHeightConstraint.constant = collectionSize.height;
    }
}

#pragma mark - CollectionView DataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.question.answerOptionsArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *sectionOptions = self.question.answerOptionsArray[section];
    return sectionOptions.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [self cellIdentifierForIndexPath:indexPath];
    
    PROptionCollectionViewCell *optionCell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [self configureCell:optionCell forIndexPath:indexPath];
    
    return optionCell;
}

-(NSString *)cellIdentifierForIndexPath:(NSIndexPath *) indexPath
{
    NSArray *sectionOptions = self.question.answerOptionsArray[indexPath.section];
    PRAnswerOption *thisOption = sectionOptions[indexPath.row];
    
    NSString *identifier = @"OptionCell";
    
    if (thisOption.image2 != nil) {
        identifier = @"OptionCell2";
    }
    
    return identifier;
}

-(void)configureCell:(PROptionCollectionViewCell *) optionCell forIndexPath:(NSIndexPath *) indexPath
{
    NSArray *sectionOptions = self.question.answerOptionsArray[indexPath.section];
    PRAnswerOption *thisOption = sectionOptions[indexPath.row];
    
    if ([thisOption.imageTintIdentifier isNonNullString]) {
        optionCell.imageTintColor = [[PRTheme sharedTheme] colourForIdentifier:thisOption.imageTintIdentifier];
    }
    
    NSString *localizedTitle = PRLocalizedStringWithDefaultValue(thisOption.optionID, nil, nil, nil, nil);
    UIImage *image1 = [thisOption.image1 isNonNullString] ? [UIImage imageNamed:thisOption.image1] : nil;
    UIImage *image2 = [thisOption.image2 isNonNullString] ? [UIImage imageNamed:thisOption.image2] : nil;
    
    [optionCell setOptionTitle:localizedTitle image:image1 andSecondImage:image2];
    
    [self applyThemeToView:optionCell];
}

#pragma mark - Collection Delegate

-(CGFloat)maximumLayoutWidthForCollectionView:(UICollectionView *)collectionView
{
    return collectionContainer.frame.size.width;
}

-(CGFloat)maximumLayoutHeightForCollectionView:(UICollectionView *)collectionView
{
    return collectionContainer.frame.size.height;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView heightForCellAtIndexPath:(NSIndexPath *)indexPath constrainedToWidth:(CGFloat)width
{
    NSString *identifier = [self cellIdentifierForIndexPath:indexPath];
    
    if (layoutCells == nil) {
        layoutCells = [NSMutableDictionary dictionary];
    }
    
    PROptionCollectionViewCell *layoutCell = layoutCells[identifier];
    
    if (layoutCell == nil) {
        UICollectionViewLayout *originalLayout = self.collectionView.collectionViewLayout;
        
        UICollectionViewFlowLayout *newLayout = [[UICollectionViewFlowLayout alloc] init];
        newLayout.itemSize = CGSizeMake(width, 200);
        collectionView.collectionViewLayout = newLayout;
        layoutCell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:nil];
        layoutCells[identifier] = layoutCell;
        collectionView.collectionViewLayout = originalLayout;
    }
    
    [self configureCell:layoutCell forIndexPath:indexPath];
    
    CGSize fittingSize = [layoutCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize constrainedToWidth:width];
    return fittingSize.height + 5.0;
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
    NSArray *sectionOptions = self.question.answerOptionsArray[indexPath.section];
    PRAnswerOption *thisOption = sectionOptions[indexPath.row];
    
    self.question.answerID = thisOption.optionID;
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.question.answerID = nil;
}

@end
