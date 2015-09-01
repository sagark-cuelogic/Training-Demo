//
//  main.m
//  KVCODemo
//
//  Created by Sagar Kudale on 01/09/15.
//  Copyright (c) 2015 Cuelogic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger ownedNumberOfDollers;

- (void) hasLostDoller;
- (void) hasGainDoller;
@end

@implementation Person
@synthesize name, ownedNumberOfDollers;

- (void) hasLostDoller {
    NSLog(@"%@ has lost dollers", name);
}
- (void) hasGainDoller {
     NSLog(@"%@ has gained dollers", name);
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"ownedNumberOfDollers"])
    {
        NSInteger oldC = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        NSInteger newC = [[change objectForKey:NSKeyValueChangeOldKey] integerValue];
        if(oldC < newC)
        {
            [self hasLostDoller];
        }else
        {
            [self hasGainDoller];
        }
    }
}

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        Person *firstPerson = [Person new];
        [firstPerson setValue:@"Sagar" forKey:@"name"];
        [firstPerson setValue:[NSNumber numberWithInteger:10] forKey:@"ownedNumberOfDollers"];
        
        [firstPerson addObserver:firstPerson forKeyPath:@"ownedNumberOfDollers" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
        NSLog(@"First Person: %@ has %d dollers", [firstPerson valueForKey:@"name"],[[firstPerson valueForKey:@"ownedNumberOfDollers"] intValue]);
        
        
        [firstPerson setValue:[NSNumber numberWithInteger:9] forKey:@"ownedNumberOfDollers"];
        
        
        Person *secondPerson = [Person new];
        [secondPerson setValue:@"Akash" forKey:@"name"];
        [secondPerson setValue:[NSNumber numberWithInteger:5] forKey:@"ownedNumberOfDollers"];
        
        NSLog(@"Second Person: %@ has %d dollers", [secondPerson valueForKey:@"name"],[[secondPerson valueForKey:@"ownedNumberOfDollers"] intValue]);
        
        
    [firstPerson removeObserver:firstPerson forKeyPath:@"ownedNumberOfDollers"];
        
    }
    
    
    return 0;
}
