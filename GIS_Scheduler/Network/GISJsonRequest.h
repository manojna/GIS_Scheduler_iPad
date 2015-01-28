//
//  GISJsonRequest.h
//  Gallaudet-Interpreting-Service
//
//Created by Paradigm on 02/05/14.
//  Copyright (c) 2014 Paradigm. All rights reserved.
//

#import "GISRequest.h"

@interface GISJsonRequest : GISRequest
{
@private
    id responseJson;
}

@property (nonatomic, retain) id responseJson;
@end
