#import "LixtalBrain.h"

@implementation LixtalBrain


// Totals up the values (counts) of our NSMutableDictionary for each key that is of the given class
// Note the nested call to intValue sent to the NSNumber returned from objectForKey:.

- (int)countOfClass:(Class)aClass
{
	int total = 0;
	for (id key in counts) {
		if ([key isKindOfClass:aClass]) {
			total += [[counts objectForKey:key] intValue];
		}
	}
	return total;
}

- (int)totalNumberCount
{
	return [self countOfClass:[NSNumber class]];
}

- (int)totalStringCount
{
	return [self countOfClass:[NSString class]];
}

// Returns all the keys in our NSMutableDictionary that are of the given class
// Note lazy instantiation of returnValue.  We return nil if we collected no objects of that class.

- (NSSet *)objectsOfClass:(Class)aClass
{
	NSMutableSet *returnValue = nil;
	for (id key in counts) {
		if ([key isKindOfClass:aClass]) {
			if (!returnValue) returnValue = [NSMutableSet set];
			[returnValue addObject:key];
		}
        
        // NSLog(@"%@",returnValue);
	}
    
	return returnValue;
}

- (NSSet *)strings
{
	return [self objectsOfClass:[NSString class]];
}

- (NSSet *)numbers
{
	return [self objectsOfClass:[NSNumber class]];
}

// TRIM THE STRING
- (NSString *)trim:(id)sender {
    
    
    // remove all newlines and replace with a white space
    NSArray *split = [sender componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    split = [split filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"length > 0"]];
    NSString *string = [split componentsJoinedByString:@" "];
    
    
    // Remove all http and email addresses
    NSDataDetector* detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSArray* matches = [detector matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    for (NSTextCheckingResult *match in matches) {
        // NSRange matchRange = [match range];
        
        if ([match resultType] == NSTextCheckingTypeLink) {
            NSURL *url = [match URL];
            
            NSString * nstr = [NSString stringWithFormat:@"%@",url];
            nstr = [nstr stringByReplacingOccurrencesOfString:@"mailto:" withString:@""];
            nstr = [nstr stringByReplacingOccurrencesOfString:@"http://" withString:@""];
            
            string = [string stringByReplacingOccurrencesOfString:nstr withString:@""];
            
            //NSLog(@" NSTR %@",nstr);
            //NSLog(@" URL %@",url);
            
        } else if ([match resultType] == NSTextCheckingTypePhoneNumber) {
            NSString *phoneNumber = [match phoneNumber];
            
            NSLog(@" PHONE %@",phoneNumber);
        }
    }
    
    
    
    // Find a replace incompatible words and characters
    NSMutableArray* aList = [[NSMutableArray alloc] initWithObjects:@"mailto:",@"http://",@"https://",@"?",@"!",@":",@";",@",",@"-",@"/",@"(",@")",@"%",@"&",@"+",@"-",@"@",@"\"",@"\'",nil];
    NSMutableArray* bList = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@".",@".",@".",@".",@"",@" ",@" ",@"",@"",@"",@"",@" ",@" ",@"",@"",@" ",nil];
    
    for (int i=0; i<[aList count];i++)
    {
        string = [string stringByReplacingOccurrencesOfString:[aList objectAtIndex:i]
                                                   withString:[bList objectAtIndex:i]];
    }
    
    // remove double spaces after removing url and email addresses
    string = [string stringByReplacingOccurrencesOfString:@"..." withString:@"."];
    string = [string stringByReplacingOccurrencesOfString:@".." withString:@"."];
    string = [string stringByReplacingOccurrencesOfString:@"    " withString:@" "];
    string = [string stringByReplacingOccurrencesOfString:@"   " withString:@" "];
    string = [string stringByReplacingOccurrencesOfString:@"  " withString:@" "];
    
    NSMutableCharacterSet *acceptedCharacters = [[NSMutableCharacterSet alloc] init];
    [acceptedCharacters formUnionWithCharacterSet:[NSCharacterSet letterCharacterSet]];
    [acceptedCharacters formUnionWithCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
    [acceptedCharacters addCharactersInString:@" _-.!"];
    
    // Turn accented letters into normal letters (optional)
    // NSData *sanitizedData = [string dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    // Corrected back-conversion from NSData to NSString
    // NSString *sanitizedText = [[NSString alloc] initWithData:sanitizedData encoding:NSASCIIStringEncoding];
    
    // Removing unaccepted characters
    //string = [[sanitizedText componentsSeparatedByCharactersInSet:[acceptedCharacters invertedSet]] componentsJoinedByString:@""];
    string = [[string componentsSeparatedByCharactersInSet:[acceptedCharacters invertedSet]] componentsJoinedByString:@""];
    

    
    
    NSString *output = [NSString stringWithFormat:@"%@",string];
    return output;
}



// LIXBEREGNER
- (NSString *)lix:(id)sender {
    
    
    // remove all newlines and replace with a white space
    NSArray *split = [sender componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    split = [split filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"length > 0"]];
    NSString *string = [split componentsJoinedByString:@" "];
    
    
    // Find a replace incompatible words and characters
    NSMutableArray* aList = [[NSMutableArray alloc] initWithObjects:@"?",@"!",@":",@";",@",",@"-",@"/",@"(",@")",@"%",@"&",@"+",@"-",@"@",nil];
    NSMutableArray* bList = [[NSMutableArray alloc] initWithObjects:@".",@".",@".",@".",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",nil];
    
    for (int i=0; i<[aList count];i++)
    {
        string = [string stringByReplacingOccurrencesOfString:[aList objectAtIndex:i]
                                                   withString:[bList objectAtIndex:i]];
    }
    
    
    
    
    
    // Finder alle ord inkl .mellemrum
    float allcharWithSpaces = string.length;
    
    // Look for dots
    NSArray *list = [string componentsSeparatedByString:@"."];
    float P = [list count]-1;
    //NSLog(@" Antal punktummer = %lu",(unsigned long)P);
    
    // Look for words
    NSString *string2 = string;
    NSArray *list2 = [string2 componentsSeparatedByString:@" "];
    float O = [list2 count];
    // NSLog(@" Antal ord: = %lu",(unsigned long)O);
    
    // Finder alle mellemrum
    float whiteSpaces = [list2 count]-1;
    
    // All chars without spaces
    float allCharsWithoutSpaces = allcharWithSpaces - whiteSpaces;
    
    // look for long words >= 7
    float L = 0;
    for (int s = 0; s < [list2 count]; s++) {
        if([[list2 objectAtIndex:s] length] > 6){
            L++;
        }
    }
    // NSLog(@" Antal lange ord %f",L);
    
    
    // Beregner LIXVÆRDI
    
    // OP
    float value1 = O;
    float value2 = P;
    float OP = (value2 == 0.0) ? 0 : value1 / value2; // This gives 0 if value2 is equal to 0
    //NSLog(@"OP == %f",OP);
    
    
    // LO
    float value3 = L;
    float value4 = O;
    float LO = (value3 == 0.0) ? 0 : value3 / value4 * 100; // This gives 0 if value2 is equal to 0
    // NSLog(@"LO == %f",LO);
    
    float lixnumber = (OP+LO);
    long roundedLixnumber = lroundf(lixnumber);
    
    // NSLog(@"%d",roundedLixnumber);
    // NSLog(@"Lixtal == %f",lixnumber);
    
    
    NSString *lixInfo = @"";
    
    if(roundedLixnumber > 54){
        lixInfo = @"Meget svær, faglitteratur på akademisk niveau, lovtekster.";
    }
    
    if(roundedLixnumber > 44 && roundedLixnumber < 55){
        lixInfo =  @"Svær, saglige bøger, populærvidenskabelige værker, akademiske udgivelser.";
    }
    
    if(roundedLixnumber > 34 && roundedLixnumber < 45){
        lixInfo = @"Middel, dagblade og tidsskrifter.";
    }
    
    if(roundedLixnumber > 24 && roundedLixnumber < 35){
        lixInfo = @"Let for øvede læsere, ugebladslitteratur og let skønlitteratur for voksne";
    }
    
    if(roundedLixnumber < 25){
        lixInfo = @"Let tekst for alle læsere, børnelitteratur";
    }
    
    
    // Removes all entries in Dictionary 'counts'
    [self clearCounts];
    
    for(int i =0 ; i < [list2 count] ; i++) {//if you have size, if don't not a problem, you could use while!
        double numericValue = [[list2 objectAtIndex:i] doubleValue];
        if (numericValue) {
            [self collect:[NSNumber numberWithDouble:numericValue]];
        } else {
            [self collect:[list2 objectAtIndex:i]];
        }
    }
    
    
    // Building up the output string
    NSString *strLixIndex = [NSString stringWithFormat:@"Lixtal = %ld",roundedLixnumber];
    NSString *strLixInfo = [NSString stringWithFormat:@"%@ %@",lixInfo,@"###"];
    NSString *strCommonWords = [NSString stringWithFormat:@"Top 10 hyppige ord: %@",[self showList]];
    NSString *strCountWords = [NSString stringWithFormat:@"Antal ord: %.0f",O];
    NSString *strCountNumbers = [NSString stringWithFormat:@"Antal tal: %d",[self totalNumberCount]];
    NSString *strCountCharsWithSpace = [NSString stringWithFormat:@"Antal tegn inkl. mellemrum: %.0f",allcharWithSpaces];
    NSString *strCountCharsWithoutSpace = [NSString stringWithFormat:@"Antal tegn ekskl. mellemrum: %.0f",allCharsWithoutSpaces];
    NSString *strWhiteSpaces = [NSString stringWithFormat:@"Antal mellemrum: %.0f",whiteSpaces];
    NSString *strCountCapitalized = [NSString stringWithFormat:@"Antal kapitaliserede ord: %d",[self capitalizedStringCount]];
    // putting it all together
    NSString *output = [NSString stringWithFormat:@"%@ \n%@ \n%@ \n\n%@ \n%@ \n%@ \n%@ \n%@ \n%@",strLixIndex, strLixInfo, strCommonWords, strCountWords, strCountNumbers, strCountCharsWithSpace, strCountCharsWithoutSpace, strWhiteSpaces, strCountCapitalized];
    
    return output;
    
}

// Same as totalStringCount, but ignores all keys except those which are capitalized.
// Notice that the "capitalization" of HELLO is Hello.
// This is pretty inefficient, but done this way just to demonstrate using our own property internally.

- (int)capitalizedStringCount
{
	int total = 0;
	for (id key in counts) {
        if ([key isKindOfClass:[NSString class]]) {
            if ([key isEqualToString:[key capitalizedString]] && ![key isEqual: @""]) {
                total += 1;
            }
        }
	}
	return total;
    
}

// First check to be sure the object is either an NSNumber (and within our allowed range) or an NSString.
// Then increment the count for this object in the counts NSDictionary.
// Note that if count is nil (i.e. this is the first time we've seen this object), [count intValue] is conveniently zero.

- (void)collect:(id)anObject
{
	if ([anObject isKindOfClass:[NSNumber class]]) {
        
	} else if (![anObject isKindOfClass:[NSString class]]) {
		anObject = nil;
	}
    
	if (anObject) {
		NSNumber *count = [counts objectForKey:anObject];
		if (!counts) counts = [[NSMutableDictionary alloc] init];
		[counts setObject:[NSNumber numberWithInt:[count intValue]+1] forKey:anObject];
	}
}


- (NSString *) showList
{
    
    NSArray *sortedKeys = [counts keysSortedByValueUsingComparator: ^(id obj1, id obj2) {
        if ([obj1 integerValue] > [obj2 integerValue])
            return (NSComparisonResult)NSOrderedDescending;
        if ([obj1 integerValue] < [obj2 integerValue])
            return (NSComparisonResult)NSOrderedAscending;
        return (NSComparisonResult)NSOrderedSame;
    }];
    NSArray *sortedValues = [[counts allValues] sortedArrayUsingSelector:@selector(compare:)];
    
    //Descending order
    NSMutableString* strhyppige = [NSMutableString stringWithCapacity:150];
    for (long s = ([sortedValues count]-1); s >= ([sortedValues count]-10); s--) {
        [strhyppige appendFormat:@" %@ (%@)",[sortedKeys objectAtIndex:s],[sortedValues objectAtIndex:s]];
    }
    return strhyppige;
    
}





// Remove objects from Dictionary 'counts'
- (void) clearCounts
{
    [counts removeAllObjects];
}


@end
