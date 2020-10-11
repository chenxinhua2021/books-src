/*
 * direct.h
 *
 * Functions for manipulating paths and directories (included from io.h)
 * plus functions for setting the current drive.
 *
 * This file is part of the Mingw32 package.
 *
 * Contributors:
 *  Created by Colin Peters <colin@bird.fu.is.saga-u.ac.jp>
 *
 *  THIS SOFTWARE IS NOT COPYRIGHTED
 *
 *  This source code is offered for use in the public domain. You may
 *  use, modify or distribute it freely.
 *
 *  This code is distributed in the hope that it will be useful but
 *  WITHOUT ANY WARRANTY. ALL WARRANTIES, EXPRESS OR IMPLIED ARE HEREBY
 *  DISCLAMED. This includes but is not limited to warranties of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * $Revision: 1.2 $
 * $Author: khan $
 * $Date: 1999/01/04 23:21:12 $
 *
 */

#ifndef __STRICT_ANSI__

#ifndef	_DIRECT_H_
#define	_DIRECT_H_

/* All the headers include this file. */
#include <_mingw.h>

#include <io.h>

#ifndef RC_INVOKED

#ifdef	__cplusplus
extern "C" {
#endif

/*
 * You really shouldn't be using these. Use the Win32 API functions instead.
 * However, it does make it easier to port older code.
 */
int	_getdrive ();
int	_chdrive (int nDrive);
char*	_getdcwd (int nDrive, char* caBuffer, int nBufLen);

#ifdef	__cplusplus
}
#endif

#endif	/* Not RC_INVOKED */

#endif	/* Not _DIRECT_H_ */

#endif	/* Not __STRICT_ANSI__ */

