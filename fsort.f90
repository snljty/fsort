! module for quick sort

module fsort_mod

    ! type :: mytype
    !     integer :: dat
    ! end type mytype

    ! interface operator(.lt.)
    !     module procedure compare_mytype
    ! end interface

    ! private :: compare_mytype

    public :: fsort

    contains

    ! logical function compare_mytype(a, b)
    !     implicit none
    !     type(mytype), intent(in) :: a, b
    !
    !     if (a%dat .lt. b%dat) then
    !         compare_mytype = .true.
    !     else
    !         compare_mytype = .false.
    !     end if
    !
    !     return
    ! end function compare_mytype

    recursive subroutine fsort(arr, beg, end)
        implicit none
        real(kind=8), dimension(*), intent(inout) :: arr
        integer, intent(in) :: beg, end
        integer, parameter :: low_threshold = 8, high_threshold = 8192
        real(kind=8) :: mid, tmp
        integer :: i, j, dad, son

        ! insert sort
        if (end - beg + 1 <= low_threshold) then
            do i = beg + 1, end
                tmp = arr(i)
                j = i - 1
                do while ((j >= beg) .and. (tmp .lt. arr(j)))
                    arr(j + 1) = arr(j)
                    j = j - 1
                end do
                arr(j + 1) = tmp
            end do
            return
        end if

        ! heap sort
        if (end - beg + 1 >= high_threshold) then
            do i = (end - beg + 1) / 2 - 1, 0, -1
                dad = i + 1
                son = dad * 2
                do while (son <= end - beg + 1)
                    if (son <= end - beg) then
                        if (arr(son) .lt. arr(son + 1)) then
                            son = son + 1
                        end if
                    end if
                    if ((arr(son) .lt. arr(dad)) .or. (arr(son) == arr(dad))) then
                        exit
                    else
                        tmp = arr(dad)
                        arr(dad) = arr(son)
                        arr(son) = tmp
                        dad = son
                        son = dad * 2
                    end if
                end do
            end do
            do i = end - beg, 1, -1
                tmp = arr(1)
                arr(1) = arr(i + 1)
                arr(i + 1) = tmp
                dad = 1
                son = dad * 2
                do while (son <= i)
                    if (son <= i - 1) then
                        if (arr(son) .lt. arr(son + 1)) then
                            son = son + 1
                        end if
                    end if
                    if (arr(son) .lt. arr(dad)) then
                        exit
                    else
                        tmp = arr(dad)
                        arr(dad) = arr(son)
                        arr(son) = tmp
                        dad = son
                        son = dad * 2
                    end if
                end do
            end do
            return
        end if

        ! quick sort
        mid = arr((beg + end) / 2)
        i = beg
        j = end
        do while (.true.)
            do while (arr(i) .lt. mid)
                i = i + 1
            end do
            do while (mid .lt. arr(j))
                j = j - 1
            end do
            if (i >= j) then
                exit
            end if
            tmp = arr(i)
            arr(i) = arr(j)
            arr(j) = tmp
            i = i + 1
            j = j - 1
        end do
        i = i - 1
        j = j + 1
        if (beg < i) then
            call fsort(arr, beg, i)
        end if
        if (j < end) then
            call fsort(arr, j, end)
        end if
        return

    end subroutine fsort

end module fsort_mod

