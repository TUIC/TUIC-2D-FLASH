TUIC-2D-FLASH
=============

TUIC-2D-Flash open source project

Detail
=============   done
Another spatial approach, called TUIC-2D-Flash, use a layout similar to TUIC-2D. The figure shows a structure of the tag. A TUIC-Flash tag contains 3 reference points which user can design their own tag. The distance between the three reference points are also used to determine the tag ID.


Hardware
=============
We have implemented a TUIC-Flash tag using Lego and conductive material, which contains a 4×4 grid of touch points within a square frame. The figure shows the user design points, T0, T1, and T2 which are used to determine location and rotation of the TUIC-Flash object. User can also design the tangible's appearance by constructing the Lego brick.


Software
=============
When a touch points is detected, we first check to see if waiting mode is true. Then we set the timer as 30ms. In this period, we continue detect if there is any touch point been detected. If no other touch points are detected, we dispatch it as a touch event. Else, we push these points to queue and set the waiting mode as false. Finally, we will check if the queue is full and start to recognize the tag ID.
