#import "PRWard.h"

#import "PRHospital.h"
#import "PRTrust.h"

#import <MagicalRecord/MagicalRecord.h>
#import <MagicalRecord/CoreData+MagicalRecord.h>

@interface PRWard ()

// Private interface goes here.

@end


@implementation PRWard

// Custom logic goes here
+(void)createPrototypeWards
{
    BOOL wardsCreated = [PRWard MR_hasAtLeastOneEntity];
    
    if (!wardsCreated) {
        NSArray *trusts = @[@"Bradford Teaching Hospital NHS Foundation Trust", @"Barnsley Hospital NHS Foundation Trust"];
        NSDictionary *hospitals = @{@"Bradford Teaching Hospital NHS Foundation Trust": @[@"Bradford Teaching Hospital"],
                                    @"Barnsley Hospital NHS Foundation Trust": @[@"Barnsley Hospital"]};
        
        NSDictionary *wards = @{@"Bradford Teaching Hospital": @[@"Ward 6",
                                                                 @"Ward 18"],
                                @"Barnsley Hospital": @[@"Ward 19"]};
        
        NSUInteger uID = 0;
        for (int t = 0; t < trusts.count; t++) {
            PRTrust *thisTrust = [PRTrust MR_createEntity];
            thisTrust.name = trusts[t];
            thisTrust.id = @(uID);
            uID++;
            
            NSArray *thisTrustHospitals = hospitals[thisTrust.name];
            for (int h = 0; h < thisTrustHospitals.count; h++) {
                
                PRHospital *thisHospital = [PRHospital MR_createEntity];
                thisHospital.trust = thisTrust;
                thisHospital.name = thisTrustHospitals[h];
                thisHospital.id = @(uID);
                uID++;
                
                NSArray *thisHospitalWards = wards[thisHospital.name];
                for (int w = 0; w < thisHospitalWards.count; w++) {
                    
                    PRWard *thisWard = [PRWard MR_createEntity];
                    thisWard.hospital = thisHospital;
                    thisWard.name = thisHospitalWards[w];
                    thisWard.id = @(uID);
                    uID++;
                }
            }
        }
        
        NSLog(@"Created: %ld trusts, %ld hospitals and %ld wards", (long) [[PRTrust MR_numberOfEntities] integerValue], (long) [[PRHospital MR_numberOfEntities] integerValue], (long) [[PRWard MR_numberOfEntities] integerValue]);
    }
}

@end
