! module for quick sort

module qsort_mod

    contains

    recursive subroutine qsort_real(arr, beg, end)
        implicit none
        real(kind=8), dimension(*), intent(inout) :: arr
        integer(kind=4), intent(in) :: beg, end
        integer(kind=4), parameter :: cutoff = 8
        real(kind=8) :: mid, tmp
        integer(kind=4) :: i, j

        if (end - beg + 1 <= cutoff) then
            ! insert sort
            do i = beg + 1, end
                tmp = arr(i)
                j = i - 1
                do while ((j >= beg) .and. (arr(j) > tmp))
                    arr(j + 1) = arr(j)
                    j = j - 1
                end do
                arr(j + 1) = tmp
            end do
            return
        end if

        ! quick sort
        mid = arr((beg + end) / 2)
        i = beg
        j = end
        do while (.true.)
            do while (arr(i) < mid)
                i = i + 1
            end do
            do while (mid < arr(j))
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
            call qsort(arr, beg, i)
        end if
        if (j < end) then
            call qsort(arr, j, end)
        end if

        return
    end subroutine qsort_real

end module qsort_mod

