function service = generateService(N,meanService)

service = zeros(1,N);

for i=1:N

    service(i)= -meanService*log(rand());

end

end