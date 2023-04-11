/*
indexing
	description: "C features for NS_OUTLINE_VIEW_DELEGATE"
	date: "$Date: 2009-04-26 20:46:55 +0000 (Sun, 26 Apr 2009) $"
	revision: "$Revision: 78382 $"
	copyright:	"Copyright (c) 2009, Daniel Furrer"
*/

#ifndef _NS_OUTLINE_VIEW_DELEGATE_H_INCLUDED_
#define _NS_OUTLINE_VIEW_DELEGATE_H_INCLUDED_

#include <eif_eiffel.h>
#include <Cocoa/Cocoa.h>

typedef EIF_REFERENCE (*outlineViewSelectionDidChangeTYPE) (EIF_REFERENCE);

@interface OutlineViewDelegate : NSObject {
	EIF_OBJECT callbackObject;
	outlineViewSelectionDidChangeTYPE outlineViewSelectionDidChange;
}
	- (EIF_REFERENCE)initWithCallbackObject:(EIF_REFERENCE)a_callbackObject
		andMethod:(outlineViewSelectionDidChangeTYPE) a_outlineViewSelectionDidChange;

	- (void)outlineViewSelectionDidChange:(NSNotification *)notification;
@end

#endif
