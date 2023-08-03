//
//  ParsingTools.h
//  ParsingTools
//
//  Created by Lukas
//

#import <Foundation/Foundation.h>

@interface ParsingTools : NSObject

+ (NSString *)extractBodyFromEmail:(NSString *)hypertext;
+ (NSArray<NSString *> *)splitTextIntoSentences:(NSString *)text;

@end
