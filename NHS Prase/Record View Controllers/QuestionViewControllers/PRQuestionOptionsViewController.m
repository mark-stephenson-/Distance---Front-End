//
//  PRQuestionOptionsViewController.m
//  NHS Prase
//
//  Created by Josh Campion on 01/09/2014.
//  Copyright (c) 2014 The Distance. All rights reserved.
//

#import "PRQuestionOptionsViewController.h"

#import <TheDistanceKit/TheDistanceKit_API.h>

#import <MagicalRecord/MagicalRecord.h>

#import "PRRecord.h"
#import "PRAnswerOption.h"

#import "PRTheme.h"
#import "PRQuestion.h"
#import "PRPMOSQuestion.h"
#import "PRAnswerSet.h"
#import "PROptionCollectionViewCell.h"
#import "NHS_Prase-Swift.h"
//#import "PRAPIManager.h"

@interface PRQuestionOptionsViewController ()

@end

@implementation PRQuestionOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    titleLabel.TDLocalizedStringKey = self.question.localizationKeyForQuestion;

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
        titleLabel.text = TDLocalizedStringWithDefaultValue(titleLabel.TDLocalizedStringKey, nil, nil, nil, nil);
    }
    
    [self.collectionView.collectionViewLayout invalidateLayout];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    //[self selectAnswer];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self selectAnswer];
}

-(void)setQuestion:(PRQuestion *)question
{
    [super setQuestion:question];

    if (headerLabel != nil) {
        headerLabel.TDLocalizedStringKey = @"question.index_header";
    }
    
    if (titleLabel != nil) {
        titleLabel.TDLocalizedStringKey = self.question.localizationKeyForQuestion;
    }
    
    if (headerLabel != nil && titleLabel != nil) {
        [self applyTheme];
        [self.collectionView reloadData];
        [self selectAnswer];
    }
}

-(void)selectAnswer
{
    if (self.question.answerID != nil) {
        NSIndexPath *selectedPath = [self.question indexPathForAnswerID:self.question.answerID];
        [self.collectionView selectItemAtIndexPath:selectedPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.collectionView.tintColor = [[PRTheme sharedTheme] mainColor];

    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView.collectionViewLayout prepareLayout];

    CGSize collectionSize = [self.collectionView.collectionViewLayout collectionViewContentSize];
    collectionViewWidthConstraint.constant = collectionSize.width;
    collectionViewHeightConstraint.constant = collectionSize.height;

    questionLabelHeightConstraint.constant = titleLabel.getEstimatedHeight;
}

#pragma mark - CollectionView DataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.question.pmosQuestion.answerSets.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    PRAnswerSet *theseAnswers = self.question.pmosQuestion.answerSets[section];
    return theseAnswers.options.count;
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
    NSString *identifier = @"OptionCell";
    
    return identifier;
}

-(void)configureCell:(PROptionCollectionViewCell *) optionCell forIndexPath:(NSIndexPath *) indexPath
{
    PRAnswerSet *sectionAnswers = self.question.pmosQuestion.answerSets[indexPath.section];
    PRAnswerOption *thisOption = sectionAnswers.options[indexPath.row];
    
    if ([thisOption.imageTintIdentifier isNonNullString]) {
        optionCell.imageTintColor = [[PRTheme sharedTheme] colourForIdentifier:thisOption.imageTintIdentifier];
    }
    
    NSString *localizationKey = [thisOption localizationKeyForAnswer];
    NSString *localizedTitle = TDLocalizedStringWithDefaultValue(localizationKey, nil, nil, nil, nil);
    UIImage *image1 = [thisOption.imageName isNonNullString] ? [UIImage imageNamed:thisOption.imageName] : nil;
    
    [optionCell setOptionTitle:localizedTitle image:image1 andSecondImage:nil];
    
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
    // whilst there are no images the size is just the size of the label including a margin
    CGFloat labelBuffer = 8;
    if (layoutLabel == nil) {
        layoutLabel = [[UILabel alloc] init];
        layoutLabel.TDTextStyleIdentifier = @"Caption 1";
        layoutLabel.numberOfLines = 0;
        layoutLabel.minimumScaleFactor = 0.5;
        layoutLabel.hidden = YES;
        [self.view addSubview:layoutLabel];
    }
    
    layoutLabel.frame = CGRectMake(0, 0, width - 2.0 * labelBuffer, 20.0);
    [self applyThemeToView:layoutLabel];
    
    PRAnswerSet *sectionAnswers = self.question.pmosQuestion.answerSets[indexPath.section];
    PRAnswerOption *thisOption = sectionAnswers.options[indexPath.row];
    NSString *localizationKey = [thisOption localizationKeyForAnswer];
    NSString *localizedTitle = TDLocalizedStringWithDefaultValue(localizationKey, nil, nil, nil, nil);
    layoutLabel.text = localizedTitle;
    
    layoutLabel.preferredMaxLayoutWidth = layoutLabel.frame.size.width;
    
    CGSize fittingSize = [layoutLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    fittingSize.height += 2;

    return fittingSize.height + labelBuffer * 2.0;
    
    /*
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
     */
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
    PRAnswerSet *sectionAnswers = self.question.pmosQuestion.answerSets[indexPath.section];
    PRAnswerOption *thisOption = sectionAnswers.options[indexPath.row];
    
    self.question.answerID = thisOption.answerID;
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.question.answerID = nil;
}

@end
