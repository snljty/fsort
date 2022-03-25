! test for qsort

program main
    use qsort_mod
    implicit none
    integer(kind=4), parameter :: n = 12
    real(kind=8), dimension(:), pointer :: m
    character(kind=1,len=18) :: fmt

    allocate(m(n))

    write(fmt, "(a,i2,a)") "(", n, "(1x,f4.1))"

    call random_number(m)
    m = m * real(n)

    write(*, trim(fmt)) m
    call qsort_real(m, 1, n)
    write(*, trim(fmt)) m

    deallocate(m)
    nullify(m)

    stop
end program main

