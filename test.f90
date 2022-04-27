! test for fsort

program main
    use fsort_mod
    implicit none
    integer(kind=4), parameter :: n = 12
    real(kind=8), dimension(:), pointer :: m
    character(kind=1,len=18) :: fmt
    integer(kind=4) :: i

    allocate(m(n))

    write(fmt, "(a,i2,a)") "(", n, "(1x,f4.1))"

    call random_number(m)
    m = m * real(n)

    write(*, "(a)") "Before sorting:"
    write(*, trim(fmt)) m
    call fsort(m, 1, n)
    write(*, "(a)") "After sorted:"
    write(*, trim(fmt)) m

    deallocate(m)
    nullify(m)

    stop
end program main

