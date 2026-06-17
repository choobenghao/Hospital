function priority = assignPriority(N)

priority = zeros(1,N);

for i=1:N

    r = rand();

    if r <= 0.2

        priority(i)=1;

    elseif r <= 0.5

        priority(i)=2;

    else

        priority(i)=3;

    end

end

end