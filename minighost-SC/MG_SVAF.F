! ************************************************************************
!
!               miniGhost: stencil computations with boundary exchange.
!                 Copyright (2012) Sandia Corporation
!
! Under terms of Contract DE-AC04-94AL85000, there is a non-exclusive
! license for use of this work by or on behalf of the U.S. Government.
!
! This library is free software; you can redistribute it and/or modify
! it under the terms of the GNU Lesser General Public License as
! published by the Free Software Foundation; either version 2.1 of the
! License, or (at your option) any later version.
!
! This library is distributed in the hope that it will be useful, but
! WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
! Lesser General Public License for more details.
!
! You should have received a copy of the GNU Lesser General Public
! License along with this library; if not, write to the Free Software
! Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
! USA
! Questions? Contact Richard F. Barrett (rfbarre@sandia.gov) or
!                    Michael A. Heroux (maherou@sandia.gov)
!
! ************************************************************************

MODULE MG_SVAF_MOD

   ! Purpose
   ! =======
   ! SVAF boundary exchange for 5- and 7-point stencils:
   !    pack, send, receive, unpack.

   USE MG_CONSTANTS_MOD
   USE MG_UTILS_MOD
   USE MG_IRECV_MOD
   USE MG_PACK_MOD
   USE MG_SEND_SVAF_MOD
   USE MG_UNPACK_SVAF_MOD

   IMPLICIT NONE

   ! Note: Using 0-based indexing on arrays.

CONTAINS
   
   SUBROUTINE MG_SVAF ( IVAR, IERR )
   
      ! -------------------------------------------------------
      ! Pack all variables for single message to each neighbor.
      ! -------------------------------------------------------

      ! ---------------------
      ! Argument Declarations
      ! ---------------------

      INTEGER, INTENT(IN) :: &
         IVAR           ! Return status

      INTEGER, INTENT(OUT) :: &
         IERR           ! Return status

      ! ------------------
      ! Local Declarations
      ! ------------------
   
      INTEGER :: &
         ICOUNT,                      &  ! Message size.
         ISTAT,                       &  ! MPI return status.
         IWHICH,                      &  ! MPI_Wait_any SRC process
         I, J, K, L, M, N,            &  ! Counters
         NUM_RECVS,                   &
         NUM_RECVS_OUTSTANDING,       &
         MSG_REQ_OFFSET,              &
         OFFSET,                      &
         OFFSET_LAST,                 &
         RECV_BUFFER_SIZE,            &
         SEND_BUFFER_SIZE,            &
         MSG_REQ(12)
   
      ! ---------------------
      ! Executable Statements
      ! ---------------------

      IERR = 0

      COUNT_SEND_NORTH = 0
      COUNT_SEND_SOUTH = 0
      COUNT_SEND_EAST  = 0
      COUNT_SEND_WEST  = 0
      COUNT_SEND_BACK  = 0
      COUNT_SEND_FRONT = 0
   
      SELECT CASE ( IVAR )

         CASE ( 1 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID1, IERR )
            CALL MG_SEND_SVAF ( GRID1, IERR )
            CALL MG_UNPACK_SVAF ( GRID1, IERR )
         CASE ( 2 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID2, IERR )
            CALL MG_SEND_SVAF ( GRID2, IERR )
            CALL MG_UNPACK_SVAF ( GRID2, IERR )
         CASE ( 3 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID3, IERR )
            CALL MG_SEND_SVAF ( GRID3, IERR )
            CALL MG_UNPACK_SVAF ( GRID3, IERR )
         CASE ( 4 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID4, IERR )
            CALL MG_SEND_SVAF ( GRID4, IERR )
            CALL MG_UNPACK_SVAF ( GRID4, IERR )
         CASE ( 5 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID5, IERR )
            CALL MG_SEND_SVAF ( GRID5, IERR )
            CALL MG_UNPACK_SVAF ( GRID5, IERR )
         CASE ( 6 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID6, IERR )
            CALL MG_SEND_SVAF ( GRID6, IERR )
            CALL MG_UNPACK_SVAF ( GRID6, IERR )
         CASE ( 7 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID7, IERR )
            CALL MG_SEND_SVAF ( GRID7, IERR )
            CALL MG_UNPACK_SVAF ( GRID7, IERR )
         CASE ( 8 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID8, IERR )
            CALL MG_SEND_SVAF ( GRID8, IERR )
            CALL MG_UNPACK_SVAF ( GRID8, IERR )
         CASE ( 9 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID9, IERR )
            CALL MG_SEND_SVAF ( GRID9, IERR )
            CALL MG_UNPACK_SVAF ( GRID9, IERR )
         CASE ( 10 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID10, IERR )
            CALL MG_SEND_SVAF ( GRID10, IERR )
            CALL MG_UNPACK_SVAF ( GRID10, IERR )
            
         CASE ( 11 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID11, IERR )
            CALL MG_SEND_SVAF ( GRID11, IERR )
            CALL MG_UNPACK_SVAF ( GRID11, IERR )
         CASE ( 12 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID12, IERR )
            CALL MG_SEND_SVAF ( GRID12, IERR )
            CALL MG_UNPACK_SVAF ( GRID12, IERR )
         CASE ( 13 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID13, IERR )
            CALL MG_SEND_SVAF ( GRID13, IERR )
            CALL MG_UNPACK_SVAF ( GRID13, IERR )
         CASE ( 14 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID14, IERR )
            CALL MG_SEND_SVAF ( GRID14, IERR )
            CALL MG_UNPACK_SVAF ( GRID14, IERR )
         CASE ( 15 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID15, IERR )
            CALL MG_SEND_SVAF ( GRID15, IERR )
            CALL MG_UNPACK_SVAF ( GRID15, IERR )
         CASE ( 16 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID16, IERR )
            CALL MG_SEND_SVAF ( GRID16, IERR )
            CALL MG_UNPACK_SVAF ( GRID16, IERR )
         CASE ( 17 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID17, IERR )
            CALL MG_SEND_SVAF ( GRID17, IERR )
            CALL MG_UNPACK_SVAF ( GRID17, IERR )
         CASE ( 18 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID18, IERR )
            CALL MG_SEND_SVAF ( GRID18, IERR )
            CALL MG_UNPACK_SVAF ( GRID18, IERR )
         CASE ( 19 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID19, IERR )
            CALL MG_SEND_SVAF ( GRID19, IERR )
            CALL MG_UNPACK_SVAF ( GRID19, IERR )
         CASE ( 20 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID20, IERR )
            CALL MG_SEND_SVAF ( GRID20, IERR )
            CALL MG_UNPACK_SVAF ( GRID20, IERR )

         CASE ( 21 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID21, IERR )
            CALL MG_SEND_SVAF ( GRID21, IERR )
            CALL MG_UNPACK_SVAF ( GRID21, IERR )
         CASE ( 22 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID22, IERR )
            CALL MG_SEND_SVAF ( GRID22, IERR )
            CALL MG_UNPACK_SVAF ( GRID22, IERR )
         CASE ( 23 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID23, IERR )
            CALL MG_SEND_SVAF ( GRID23, IERR )
            CALL MG_UNPACK_SVAF ( GRID23, IERR )
         CASE ( 24 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID24, IERR )
            CALL MG_SEND_SVAF ( GRID24, IERR )
            CALL MG_UNPACK_SVAF ( GRID24, IERR )
         CASE ( 25 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID25, IERR )
            CALL MG_SEND_SVAF ( GRID25, IERR )
            CALL MG_UNPACK_SVAF ( GRID25, IERR )
         CASE ( 26 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID26, IERR )
            CALL MG_SEND_SVAF ( GRID26, IERR )
            CALL MG_UNPACK_SVAF ( GRID26, IERR )
         CASE ( 27 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID27, IERR )
            CALL MG_SEND_SVAF ( GRID27, IERR )
            CALL MG_UNPACK_SVAF ( GRID27, IERR )
         CASE ( 28 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID28, IERR )
            CALL MG_SEND_SVAF ( GRID28, IERR )
            CALL MG_UNPACK_SVAF ( GRID28, IERR )
         CASE ( 29 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID29, IERR )
            CALL MG_SEND_SVAF ( GRID29, IERR )
            CALL MG_UNPACK_SVAF ( GRID29, IERR )
         CASE ( 30 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID30, IERR )
            CALL MG_SEND_SVAF ( GRID30, IERR )
            CALL MG_UNPACK_SVAF ( GRID30, IERR )
            
         CASE ( 31 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID31, IERR )
            CALL MG_SEND_SVAF ( GRID31, IERR )
            CALL MG_UNPACK_SVAF ( GRID31, IERR )
         CASE ( 32 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID32, IERR )
            CALL MG_SEND_SVAF ( GRID32, IERR )
            CALL MG_UNPACK_SVAF ( GRID32, IERR )
         CASE ( 33 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID33, IERR )
            CALL MG_SEND_SVAF ( GRID33, IERR )
            CALL MG_UNPACK_SVAF ( GRID33, IERR )
         CASE ( 34 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID34, IERR )
            CALL MG_SEND_SVAF ( GRID34, IERR )
            CALL MG_UNPACK_SVAF ( GRID34, IERR )
         CASE ( 35 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID35, IERR )
            CALL MG_SEND_SVAF ( GRID35, IERR )
            CALL MG_UNPACK_SVAF ( GRID35, IERR )
         CASE ( 36 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID36, IERR )
            CALL MG_SEND_SVAF ( GRID36, IERR )
            CALL MG_UNPACK_SVAF ( GRID36, IERR )
         CASE ( 37 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID37, IERR )
            CALL MG_SEND_SVAF ( GRID37, IERR )
            CALL MG_UNPACK_SVAF ( GRID37, IERR )
         CASE ( 38 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID38, IERR )
            CALL MG_SEND_SVAF ( GRID38, IERR )
            CALL MG_UNPACK_SVAF ( GRID38, IERR )
         CASE ( 39 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID39, IERR )
            CALL MG_SEND_SVAF ( GRID39, IERR )
            CALL MG_UNPACK_SVAF ( GRID39, IERR )
         CASE ( 40 )
            CALL MG_IRECV ( IERR )
            CALL MG_PACK ( GRID40, IERR )
            CALL MG_SEND_SVAF ( GRID40, IERR )
            CALL MG_UNPACK_SVAF ( GRID40, IERR )

         CASE DEFAULT
            WRITE(*,*) '** Error ** COMM_MG_SVAF: Unknown variable number ', IVAR, '.'

      END SELECT
            
   END SUBROUTINE MG_SVAF
   
END MODULE MG_SVAF_MOD
