//
//  ParsingTools.m
//  ParsingTools
//
//  Created by Lukas
//

#import "ParsingTools.h"
#import <NaturalLanguage/NaturalLanguage.h>

@implementation ParsingTools

+ (NSString *)extractBodyFromEmail:(NSString *)hypertext {
    NSArray<NSString *> *lines = [hypertext componentsSeparatedByString:@"\n\n"];
    if (lines.count <= 1) {
        return nil;
    }
    NSString *body = [lines subarrayWithRange:NSMakeRange(1, lines.count - 1)].firstObject;
    return body;
}

+ (NSArray<NSString *> *)splitTextIntoSentences:(NSString *)text {
    NSMutableArray<NSString *> *sentences = [NSMutableArray array];
    
    NSLinguisticTaggerOptions options = NSLinguisticTaggerOmitWhitespace | NSLinguisticTaggerOmitPunctuation | NSLinguisticTaggerOmitOther;
    NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:@[NSLinguisticTagSchemeTokenType] options:0];
    tagger.string = text;
    
    [tagger enumerateTagsInRange:NSMakeRange(0, text.length) scheme:NSLinguisticTagSchemeLanguage options:options usingBlock:^(NSLinguisticTag _Nullable tag, NSRange tokenRange, NSRange sentenceRange, BOOL * _Nonnull stop) {
        NSString *sentence = [text substringWithRange:sentenceRange];
        [sentences addObject:sentence];
    }];
    
    return [sentences copy];
}


@end
