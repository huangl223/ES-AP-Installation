/*
indexing
	description: "C features of NS_OUTLINE_VIEW_DELEGATE"
	date: "$Date: 2009-04-26 20:46:55 +0000 (Sun, 26 Apr 2009) $"
	revision: "$Revision: 78382 $"
	copyright:	"Copyright (c) 2009, Daniel Furrer"
*/

#include <eif_eiffel.h>
#include <Cocoa/Cocoa.h>
#include "ns_outline_view_delegate.h"

@implementation OutlineViewDelegate 
	- (void)outlineViewSelectionDidChange:(NSNotification *)notification
	{
		outlineViewSelectionDidChange ( eif_access (callbackObject) );
	}

	- (EIF_REFERENCE)initWithCallbackObject:(EIF_REFERENCE) a_callbackObject
		andMethod:(outlineViewSelectionDidChangeTYPE) a_callbackMethod
	{
		callbackObject = eif_protect(a_callbackObject);
		outlineViewSelectionDidChange = a_callbackMethod;
		return (EIF_REFERENCE)self;
	}
@end