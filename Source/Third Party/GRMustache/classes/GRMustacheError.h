// The MIT License
//
// Copyright (c) 2012 Gwendal Roué
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>
#import "GRMustacheAvailabilityMacros.h"


/**
 * The codes of a GRMustache-generated NSError
 *
 * @since v1.0
 */
typedef enum {
    /**
     * The error code for parse errors.
     *
     * @since v1.0
     */
    GRMustacheErrorCodeParseError,
    
    /**
     * The error code for not found templates and partials.
     *
     * @since v1.0
     */
    GRMustacheErrorCodeTemplateNotFound,
} GRMustacheErrorCode AVAILABLE_GRMUSTACHE_VERSION_5_0_AND_LATER;


/**
 * The domain of a GRMustache-generated NSError
 *
 * @since v1.0
 */
extern NSString* const GRMustacheErrorDomain AVAILABLE_GRMUSTACHE_VERSION_5_0_AND_LATER;


/**
 * The name of exceptions raised by GRMustache when rendering a template,
 * whenever:
 *
 * - a filter is missing.
 * - an object expected to conform to the <GRMustacheFilter> protocol does not.
 * - a GRMustacheDynamicPartial instance can't be rendered because the partial
 *   template is missing.
 *
 * @see GRMustacheFilter protocol
 * @see GRMustacheDynamicPartial
 *
 * @since v5.1
 */
extern NSString * const GRMustacheRenderingException AVAILABLE_GRMUSTACHE_VERSION_5_1_AND_LATER;

/**
 * Deprecated. Use GRMustacheRenderingException instead.
 *
 * @since v4.3
 * @deprecated v5.1
 */
extern NSString * GRMustacheFilterException AVAILABLE_GRMUSTACHE_VERSION_5_0_AND_LATER_BUT_DEPRECATED_IN_GRMUSTACHE_VERSION_5_1;
