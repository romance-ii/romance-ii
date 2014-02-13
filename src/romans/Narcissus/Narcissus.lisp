(in-package :narcissus)

(define-condition unable-to-load-c++-libraries ()
  ((libs-loaded) (error-condition) (user-message)))

(defun start-server (argv)
  (caesar:with-oversight (:narcissus)
    (romance:server-start-banner "Narcissus" "Narcissus"
                                 "Physical forces simulation server")
   (format t "~&Narciussus contains:
   Bullet Collision Detection and Physics Library

   Copyright © 2012 Advanced Micro Devices, Inc. 

   http://bulletphysics.org

   This software is  provided 'as-is', without any  express or implied
   warranty.  In  no event  will the  authors be  held liable  for any
   damages  arising from  the  use of  this  software.  Permission  is
   granted to anyone  to use this software for  any purpose, including
   commercial  applications,  and  to  alter it  and  redistribute  it
   freely, subject to the following restrictions:

   1. The origin of this software must not be misrepresented; you must
      not claim that you wrote the  original software. If you use this
      software  in  a  product,   an  acknowledgment  in  the  product
      documentation would be appreciated but is not required.

   2. Altered source versions must be plainly marked as such, and must
      not be misrepresented as being the original software.

   3. This notice may not be removed or altered from any
      source distribution.
 

Narcissus wrapper Copyright © 2013-2014, Bruce-Robert Pocock

    This  program is  free software:  you can  redistribute it  and/or
    modify it under the terms of the GNU Affero General Public License
    as published by the Free  Software Foundation, either version 3 of
    the License, or (at your option) any later version.

    This program  is distributed in the  hope that it will  be useful,
    but WITHOUT  ANY WARRANTY;  without even  the implied  warranty of
    MERCHANTABILITY or FITNESS FOR A  PARTICULAR PURPOSE.  See the GNU
    Affero General Public License for more details.

    You should have  received a copy of the GNU  Affero General Public
    License    along    with    this    program.     If    not,    see
    <http://www.gnu.org/licenses/>.")
  
   (multiple-value-bind (loaded errors) (bullet-physics::load-c++-libraries)
     (when errors
       (error 'unable-to-load-c++-libraries
              :libs-loaded loaded
              :error-conditions errors
              :user-message (format nil "
************************************************************************

ERROR: Unable to load required C++ libraries.

Narcissus attempted to load the C++ Bullet Physics libraries, but was
unable to do so.

~{------------------------------------------------------------------------

An error condition was signaled: ~S

“~:*~A”

This prevented loading one or more libraries.~}
------------------------------------------------------------------------

However, the following libraries were loaded successfully:
~{~A~^, ~}"
                                    errors loaded)))
  
   (caesar:report :narcissus :init-loaded-c++-libs
                  "Loaded required C++ Bullet Physics libraries"
                  :libraries loaded)))
  (format t "~& Narcissus: Bye!~%"))


